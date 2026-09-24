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
