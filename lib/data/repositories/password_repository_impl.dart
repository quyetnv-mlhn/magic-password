import 'package:magic_password/data/datasources/local/password_local_datasource.dart';
import 'package:magic_password/data/datasources/local/password_manager_datasource.dart';
import '../../domain/repositories/password_repository.dart';
import '../../domain/entities/password/password.dart';
import '../../core/exceptions/password_exception.dart';
import '../../core/exceptions/validation_exception.dart';
import '../../gen/locale_keys.g.dart';

class PasswordRepositoryImpl implements PasswordRepository {
  final PasswordLocalDataSource _localDataSource;
  final PasswordManagerDataSource _managerDataSource;

  PasswordRepositoryImpl({
    required PasswordLocalDataSource localDataSource,
    required PasswordManagerDataSource managerDataSource,
  })  : _localDataSource = localDataSource,
        _managerDataSource = managerDataSource;

  @override
  Future<String> encryptPassword(String password, String key) async {
    try {
      return await _managerDataSource.encryptPassword(password, key);
    } catch (e) {
      throw EncryptionException(
        messageKey: '${LocaleKeys.error_encryptPasswordFailed}: $e',
      );
    }
  }

  @override
  Future<String> decryptPassword(String encryptedPassword, String key) async {
    try {
      return await _managerDataSource.decryptPassword(encryptedPassword, key);
    } catch (e) {
      throw DecryptionException(
        messageKey: '${LocaleKeys.error_decryptPasswordFailed}: $e',
      );
    }
  }

  @override
  String generateKey() {
    try {
      return _managerDataSource.generateKey();
    } catch (e) {
      throw PasswordStorageException(
        messageKey: '${LocaleKeys.error_failedGeneratePassword}: $e',
      );
    }
  }

  @override
  String generatePassword({
    int length = 20,
    bool useSpecialChars = true,
    bool useNumbers = true,
    bool useUppercase = true,
    bool useLowercase = true,
  }) {
    try {
      return _managerDataSource.generatePassword(
        length: length,
        useSpecialChars: useSpecialChars,
        useLowercase: useLowercase,
        useNumbers: useNumbers,
        useUppercase: useUppercase,
      );
    } catch (e) {
      throw PasswordStorageException(
        messageKey: '${LocaleKeys.error_failedGeneratePassword}: $e',
      );
    }
  }

  @override
  Future<List<PasswordEntity>> getSavedPasswords() async {
    try {
      final allPasswords = await _localDataSource.getAllPasswords();
      return allPasswords.entries
          .map(
            (e) => PasswordEntity(
              name: e.key,
              encryptedValue: e.value,
              isSaved: true,
            ),
          )
          .toList();
    } catch (e) {
      throw PasswordStorageException(
        messageKey: '${LocaleKeys.error_failedGetSavedPassword}: $e',
      );
    }
  }

  @override
  Future<void> savePassword(PasswordEntity password) async {
    try {
      await _localDataSource.savePassword(
        password.name,
        password.encryptedValue,
      );
    } catch (e) {
      throw PasswordStorageException(
        messageKey: '${LocaleKeys.error_failedSavePassword}: $e',
      );
    }
  }

  @override
  Future<String> loadEncryptedPassword(String name) async {
    try {
      final encrypted = await _localDataSource.loadPassword(name);
      if (encrypted == null) {
        throw const ValidationException(
          messageKey: LocaleKeys.error_passwordNotFound,
        );
      }
      return encrypted;
    } catch (e) {
      throw PasswordStorageException(
        messageKey: '${LocaleKeys.error_failedLoadEncryptedPassword}: $e',
      );
    }
  }
}
