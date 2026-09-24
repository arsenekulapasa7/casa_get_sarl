import 'package:shared_preferences/shared_preferences.dart';
import 'content_database.dart';

class ContentDatabaseImpl implements ContentDatabase {
  late SharedPreferences _preferences;

  @override
  Future<void> initialize() async {
    _preferences = await SharedPreferences.getInstance();
  }

  @override
  Future<String?> read(String key) async => _preferences.getString(key);

  @override
  Future<void> write(String key, String value) async {
    await _preferences.setString(key, value);
  }
}
