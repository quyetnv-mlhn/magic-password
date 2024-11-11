import 'package:flutter_secure_storage/flutter_secure_storage.dart';

abstract class PasswordLocalDataSource {
  Future<void> savePassword(String name, String encryptedValue);
  Future<Map<String, String>> getAllPasswords();

  Future<String?> loadPassword(String name);
}

class PasswordLocalDataSourceImpl implements PasswordLocalDataSource {
  final FlutterSecureStorage _storage;

  PasswordLocalDataSourceImpl({
    required FlutterSecureStorage storage,
  }) : _storage = storage;

  @override
  Future<void> savePassword(String name, String encryptedValue) async {
    await _storage.write(key: name, value: encryptedValue);
  }

  @override
  Future<Map<String, String>> getAllPasswords() async {
    return await _storage.readAll();
  }

  @override
  Future<String?> loadPassword(String name) {
    return _storage.read(key: name);
  }
}
