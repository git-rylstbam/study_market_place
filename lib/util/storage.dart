import 'package:get_storage/get_storage.dart';

/// CreateDate: 2025/7/7 18:47
/// Author: Lee
/// Description:

class StorageUtil {
  static const defaultContainerKey = 'LFStorage';

  static final shared = GetStorageUtilCore();

  static T? read<T>(String key) => shared.read<T>(key);

  static Future<void> write(String key, dynamic value) =>
      shared.write(key, value);

  static bool has(String key) => shared.has(key);

  static Future<void> remove(String key) => shared.remove(key);

  static Future<void> clear() => shared.clear();
}

class GetStorageUtilCore implements StorageUtilCore {
  GetStorageUtilCore([String container = 'LFStorage'])
    : instance = GetStorage(container);

  final GetStorage instance;

  @override
  T? read<T>(String key) => instance.read<T>(key);

  @override
  Future<void> write(String key, value) => instance.write(key, value);

  @override
  bool has(String key) => instance.hasData(key);

  @override
  Future<void> remove(String key) => instance.remove(key);

  @override
  Future<void> clear() => instance.erase();
}

abstract class StorageUtilCore {
  T? read<T>(String key);

  Future<void> write(String key, dynamic value);

  bool has(String key);

  Future<void> remove(String key);

  Future<void> clear();
}
