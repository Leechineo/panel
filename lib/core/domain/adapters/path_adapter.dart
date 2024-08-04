abstract class PathAdapter {
  Future<String> getTemporaryDirectory();
  Future<void> createDirectoryRecursively(String directory);
}
