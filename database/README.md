# Content database

`content_schema.sql` documents the SQLite schema used by the Flutter application.

On native platforms, the app creates `casaget_content.db` automatically in the platform database directory and creates the `site_content` table on first launch.

The Web build uses the same `ContentStore` API with browser storage because a native SQLite file cannot be opened directly by a browser. This keeps the website deployable while native builds use SQLite.

Editable keys:

- `content.hero_title_fr`
- `content.hero_title_en`
- `content.hero_subtitle_fr`
- `content.hero_subtitle_en`
- `content.contact_subtitle_fr`
- `content.contact_subtitle_en`
- `news.fr.title`, `news.fr.excerpt`, `news.fr.image`, `news.fr.date`
- `leisure.video_0`, `leisure.video_1`, `leisure.video_2`
- `project.image_0`, `project.image_1`, `project.image_2`

The admin form expects paths relative to the Flutter project, for example
`images/video/ma-video.mp4` or `images/Projet/mon-image.jpeg`. Add the files to
those folders before entering their paths.

## Supabase news publishing

The public news section loads published records from Supabase and keeps the
built-in posts in `lib/constants/app_strings.dart` as fallback content. The
admin page uses Supabase Auth, writes bilingual news to `news_articles`, and
uploads selected images to the public `news-images` bucket.

1. Create a Supabase project.
2. In Supabase SQL Editor, run all of `database/supabase_news.sql`.
3. In Authentication > Users, create the administrator account with an email
	and password. Copy that user's UUID.
4. In SQL Editor, authorize only that account:

	```sql
	insert into public.news_admins (user_id)
	values ('ADMIN_AUTH_USER_UUID');
	```

5. Set the `SUPABASE_URL` and `SUPABASE_ANON_KEY` environment variables in
	Vercel under Project Settings > Environment Variables. Use the Project URL
	and publishable/anon key from Supabase API settings. These values are
	embedded in the public app; never use the Supabase service-role key.
6. Ensure the Vercel build command passes both variables to Flutter:

	```sh
	flutter build web --release --dart-define=SUPABASE_URL="$SUPABASE_URL" --dart-define=SUPABASE_ANON_KEY="$SUPABASE_ANON_KEY"
	```

	Set the output directory to `build/web`, then redeploy. For local builds,
	use the same command in PowerShell with `$env:SUPABASE_URL` and
	`$env:SUPABASE_ANON_KEY` in place of the shell variables above.

The SQL policies allow everyone to read published news and site settings, while
only user IDs in `news_admins` can publish, edit, or delete news and site
settings, and upload media. Uploaded media is stored in the public
`news-images` bucket; the admin supports files up to 50 MB. The admin login is
available at `/admin`.

After updating the SQL, redeploy the app. Admin changes to text and media URLs
are stored in `site_content` and become available to all visitors.
