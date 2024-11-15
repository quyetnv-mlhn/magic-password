import 'package:magic_password/domain/entities/password/password.dart';

abstract class PasswordRepository {
  Future<List<PasswordEntity>> getSavedPasswords();
  Future<void> savePassword(PasswordEntity password);
  Future<String> encryptPassword(String password, String key);
  Future<String> decryptPassword(String encryptedPassword, String key);
  String generateKey();
  String generatePassword({
    int length = 20,
    bool useSpecialChars = true,
    bool useNumbers = true,
    bool useUppercase = true,
    bool useLowercase = true,
  });

  Future<String> loadEncryptedPassword(String name);

  Future<void> deletePassword(PasswordEntity password);

  Future<void> updatePassword(PasswordEntity password);
}
