import 'package:magic_password/services/password_manager.dart';

abstract class PasswordManagerDataSource {
  String generateKey();
  String generatePassword({
    int length,
    bool useSpecialChars,
    bool useNumbers,
    bool useUppercase,
    bool useLowercase,
  });
  Future<String> encryptPassword(String password, String key);
  Future<String> decryptPassword(String encryptedPassword, String key);
}

class PasswordManagerDataSourceImpl implements PasswordManagerDataSource {
  final PasswordManager _passwordManager;

  PasswordManagerDataSourceImpl({
    required PasswordManager passwordManager,
  }) : _passwordManager = passwordManager;

  @override
  String generateKey() {
    return _passwordManager.generateRandomKey().substring(0, 32);
  }

  @override
  String generatePassword({
    int length = 20,
    bool useSpecialChars = true,
    bool useNumbers = true,
    bool useUppercase = true,
    bool useLowercase = true,
  }) {
    return _passwordManager.generatePassword(
      length: length,
      useSpecialChars: useSpecialChars,
      useLowercase: useLowercase,
      useNumbers: useNumbers,
      useUppercase: useUppercase,
    );
  }

  @override
  Future<String> encryptPassword(String password, String key) async {
    return _passwordManager.encryptPassword(password, key);
  }

  @override
  Future<String> decryptPassword(String encryptedPassword, String key) async {
    return _passwordManager.decryptPassword(encryptedPassword, key);
  }
}
