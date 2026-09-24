import 'content_database.dart';
import 'content_database_io.dart'
    if (dart.library.html) 'content_database_web.dart';

class ContentStore {
  ContentStore._();

  static final ContentStore instance = ContentStore._();
  static const _heroTitleFrKey = 'content.hero_title_fr';
  static const _heroTitleEnKey = 'content.hero_title_en';
  static const _heroSubtitleFrKey = 'content.hero_subtitle_fr';
  static const _heroSubtitleEnKey = 'content.hero_subtitle_en';
  static const _contactSubtitleFrKey = 'content.contact_subtitle_fr';
  static const _contactSubtitleEnKey = 'content.contact_subtitle_en';

  final ContentDatabase _database = ContentDatabaseImpl();
  final Map<String, String> _values = {};

  Future<void> initialize() async {
    await _database.initialize();
    for (final key in [
      _heroTitleFrKey,
      _heroTitleEnKey,
      _heroSubtitleFrKey,
      _heroSubtitleEnKey,
      _contactSubtitleFrKey,
      _contactSubtitleEnKey,
      'news.fr.title',
      'news.fr.excerpt',
      'news.fr.image',
      'news.fr.date',
      'leisure.video_0',
      'leisure.video_1',
      'leisure.video_2',
      'leisure.video_description_0',
      'leisure.video_description_1',
      'leisure.video_description_2',
      'project.image_0',
      'project.image_1',
      'project.image_2',
    ]) {
      final value = await _database.read(key);
      if (value != null) _values[key] = value;
    }
  }

  String get heroTitleFr => _values[_heroTitleFrKey] ?? '';
  String get heroTitleEn => _values[_heroTitleEnKey] ?? '';
  String get heroSubtitleFr => _values[_heroSubtitleFrKey] ?? '';
  String get heroSubtitleEn => _values[_heroSubtitleEnKey] ?? '';
  String get contactSubtitleFr => _values[_contactSubtitleFrKey] ?? '';
  String get contactSubtitleEn => _values[_contactSubtitleEnKey] ?? '';

  String value(String key) => _values[key] ?? '';

  static bool isDataUrl(String value) => value.startsWith('data:');

  Future<void> saveValues(Map<String, String> values) async {
    await Future.wait(
      values.entries.map((entry) => _database.write(entry.key, entry.value)),
    );
    _values.addAll(values);
  }

  Future<void> save({
    required String heroTitleFr,
    required String heroTitleEn,
    required String heroSubtitleFr,
    required String heroSubtitleEn,
    required String contactSubtitleFr,
    required String contactSubtitleEn,
  }) async {
    final values = <String, String>{
      _heroTitleFrKey: heroTitleFr,
      _heroTitleEnKey: heroTitleEn,
      _heroSubtitleFrKey: heroSubtitleFr,
      _heroSubtitleEnKey: heroSubtitleEn,
      _contactSubtitleFrKey: contactSubtitleFr,
      _contactSubtitleEnKey: contactSubtitleEn,
    };
    await saveValues(values);
  }
}
