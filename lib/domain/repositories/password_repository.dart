import '../entities/password.dart';

abstract class PasswordRepository {
  Future<List<PasswordEntity>> getSavedPasswords();
  Future<void> savePassword(PasswordEntity password);
  Future<String> encryptPassword(String password, String key);
  Future<String> decryptPassword(String encryptedPassword, String key);
  String generateKey();
  String generatePassword({int length = 20});

  Future<String> loadEncryptedPassword(String name);
}
