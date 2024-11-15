import 'package:flutter_secure_storage/flutter_secure_storage.dart';

abstract class PasswordLocalDataSource {
  Future<void> savePassword(String name, String passwordEntity);
  Future<Map<String, String>> getAllPasswords();

  Future<String?> loadPassword(String name);

  Future<void> deletePassword(String keyName);
}

class PasswordLocalDataSourceImpl implements PasswordLocalDataSource {
  final FlutterSecureStorage _storage;

  PasswordLocalDataSourceImpl({
    required FlutterSecureStorage storage,
  }) : _storage = storage;

  @override
  Future<void> savePassword(String name, String passwordEntity) async {
    await _storage.write(key: name, value: passwordEntity);
  }

  @override
  Future<Map<String, String>> getAllPasswords() async {
    return _storage.readAll();
  }

  @override
  Future<String?> loadPassword(String name) {
    return _storage.read(key: name);
  }

  @override
  Future<void> deletePassword(String keyName) async {
    await _storage.delete(key: keyName);
  }
}
