create extension if not exists pgcrypto;

create table if not exists public.news_articles (
  id uuid primary key default gen_random_uuid(),
  title_fr text not null,
  excerpt_fr text not null,
  content_fr text not null,
  title_en text not null,
  excerpt_en text not null,
  content_en text not null,
  category_fr text not null default 'Actualité',
  category_en text not null default 'News',
  image_url text not null default '',
  published boolean not null default true,
  created_at timestamptz not null default now()
);

create table if not exists public.news_admins (
  user_id uuid primary key references auth.users(id) on delete cascade
);

alter table public.news_articles enable row level security;
alter table public.news_admins enable row level security;

create or replace function public.is_news_admin()
returns boolean
language sql
stable
security definer
set search_path = public
as $$
  select exists (
    select 1 from public.news_admins where user_id = auth.uid()
  );
$$;

create table if not exists public.site_content (
  content_key text primary key,
  value text not null,
  updated_at timestamptz not null default now()
);

grant execute on function public.is_news_admin() to anon, authenticated;
grant select on public.news_articles to anon, authenticated;
grant insert, update, delete on public.news_articles to authenticated;
grant select on public.site_content to anon, authenticated;
grant insert, update, delete on public.site_content to authenticated;

alter table public.site_content enable row level security;

drop policy if exists "Public reads site content" on public.site_content;
create policy "Public reads site content"
on public.site_content for select
using (true);

drop policy if exists "Admins create site content" on public.site_content;
create policy "Admins create site content"
on public.site_content for insert to authenticated
with check (public.is_news_admin());

drop policy if exists "Admins update site content" on public.site_content;
create policy "Admins update site content"
on public.site_content for update to authenticated
using (public.is_news_admin())
with check (public.is_news_admin());

drop policy if exists "Admins delete site content" on public.site_content;
create policy "Admins delete site content"
on public.site_content for delete to authenticated
using (public.is_news_admin());

drop policy if exists "Published news is public" on public.news_articles;
create policy "Published news is public"
on public.news_articles for select
using (published or public.is_news_admin());

drop policy if exists "Admins create news" on public.news_articles;
create policy "Admins create news"
on public.news_articles for insert to authenticated
with check (public.is_news_admin());

drop policy if exists "Admins update news" on public.news_articles;
create policy "Admins update news"
on public.news_articles for update to authenticated
using (public.is_news_admin())
with check (public.is_news_admin());

drop policy if exists "Admins delete news" on public.news_articles;
create policy "Admins delete news"
on public.news_articles for delete to authenticated
using (public.is_news_admin());

insert into storage.buckets (id, name, public)
values ('news-images', 'news-images', true)
on conflict (id) do update set public = true;

drop policy if exists "Public reads news images" on storage.objects;
create policy "Public reads news images"
on storage.objects for select
using (bucket_id = 'news-images');

drop policy if exists "Admins upload news images" on storage.objects;
create policy "Admins upload news images"
on storage.objects for insert to authenticated
with check (bucket_id = 'news-images' and public.is_news_admin());

drop policy if exists "Admins update news images" on storage.objects;
create policy "Admins update news images"
on storage.objects for update to authenticated
using (bucket_id = 'news-images' and public.is_news_admin())
with check (bucket_id = 'news-images' and public.is_news_admin());

drop policy if exists "Admins delete news images" on storage.objects;
create policy "Admins delete news images"
on storage.objects for delete to authenticated
using (bucket_id = 'news-images' and public.is_news_admin());

-- After creating the admin account in Supabase Auth, add its UUID here:
-- insert into public.news_admins (user_id) values ('ADMIN_AUTH_USER_UUID');