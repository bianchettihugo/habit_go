abstract class StorageService {
  Future<void> setString(String key, String value);

  Future<void> setInt(String key, int value);

  Future<void> setBool(String key, bool value);

  Future<void> setDouble(String key, double value);

  String? getString(String key);

  int? getInt(String key);

  bool? getBool(String key);

  double? getDouble(String key);
}
