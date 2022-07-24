abstract class Cache {
  Future<bool> save<T>({
    required String key,
    required T value,
  });

  Future<T> load<T>(String key);

  Future<bool> remove(String key);
}
