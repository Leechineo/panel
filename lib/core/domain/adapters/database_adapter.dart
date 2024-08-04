abstract class DatabaseAdapter {
  Future<dynamic> writeValue(String collectionName, String key, String value);
  Future<dynamic> getValue(String collectionName, String key);
  Future<void> removeValue(String collectionName, String key);
}
