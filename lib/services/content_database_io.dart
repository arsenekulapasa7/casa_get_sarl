import 'package:path/path.dart' as path;
import 'package:sqflite_common_ffi/sqflite_ffi.dart';
import 'content_database.dart';

class ContentDatabaseImpl implements ContentDatabase {
  Database? _database;

  @override
  Future<void> initialize() async {
    sqfliteFfiInit();
    final databaseFactory = databaseFactoryFfi;
    final databasePath = path.join(
      await databaseFactory.getDatabasesPath(),
      'casaget_content.db',
    );

    _database = await databaseFactory.openDatabase(
      databasePath,
      options: OpenDatabaseOptions(
        version: 1,
        onCreate: (database, version) async {
          await database.execute('''
            CREATE TABLE site_content (
              content_key TEXT PRIMARY KEY,
              content_value TEXT NOT NULL
            )
          ''');
        },
      ),
    );
  }

  @override
  Future<String?> read(String key) async {
    final rows = await _database!.query(
      'site_content',
      columns: ['content_value'],
      where: 'content_key = ?',
      whereArgs: [key],
      limit: 1,
    );
    return rows.isEmpty ? null : rows.first['content_value'] as String;
  }

  @override
  Future<void> write(String key, String value) async {
    await _database!.insert('site_content', {
      'content_key': key,
      'content_value': value,
    }, conflictAlgorithm: ConflictAlgorithm.replace);
  }
}
