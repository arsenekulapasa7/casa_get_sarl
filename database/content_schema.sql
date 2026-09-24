-- CASA GET website content database
-- The Flutter app creates the SQLite file automatically as casaget_content.db.

CREATE TABLE IF NOT EXISTS site_content (
  content_key TEXT PRIMARY KEY,
  content_value TEXT NOT NULL
);

-- Optional initial values. Empty values make the app use its built-in defaults.
INSERT OR IGNORE INTO site_content (content_key, content_value) VALUES
  ('content.hero_title_fr', ''),
  ('content.hero_title_en', ''),
  ('content.hero_subtitle_fr', ''),
  ('content.hero_subtitle_en', ''),
  ('content.contact_subtitle_fr', ''),
  ('content.contact_subtitle_en', ''),
  ('news.fr.title', ''),
  ('news.fr.excerpt', ''),
  ('news.fr.image', ''),
  ('news.fr.date', ''),
  ('leisure.video_0', ''),
  ('leisure.video_1', ''),
  ('leisure.video_2', ''),
  ('project.image_0', ''),
  ('project.image_1', ''),
  ('project.image_2', '');
