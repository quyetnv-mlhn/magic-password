import 'dart:convert';

import 'package:easy_localization/easy_localization.dart';
import 'package:magic_password/data/datasources/local/password_local_datasource.dart';
import 'package:magic_password/data/datasources/local/password_manager_datasource.dart';
import 'package:magic_password/domain/repositories/password_repository.dart';
import 'package:magic_password/domain/entities/password/password.dart';
import 'package:magic_password/core/exceptions/password_exception.dart';
import 'package:magic_password/core/exceptions/validation_exception.dart';
import 'package:magic_password/gen/locale_keys.g.dart';

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
        messageKey: '${LocaleKeys.errors_encryptPasswordFailed.tr()}: $e',
      );
    }
  }

  @override
  Future<String> decryptPassword(String encryptedPassword, String key) async {
    try {
      return await _managerDataSource.decryptPassword(encryptedPassword, key);
    } catch (e) {
      throw DecryptionException(
        messageKey: '${LocaleKeys.errors_decryptPasswordFailed.tr()}: $e',
      );
    }
  }

  @override
  String generateKey() {
    try {
      return _managerDataSource.generateKey();
    } catch (e) {
      throw PasswordStorageException(
        messageKey: '${LocaleKeys.errors_failedGeneratePassword.tr()}: $e',
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
        messageKey: '${LocaleKeys.errors_failedGeneratePassword.tr()}: $e',
      );
    }
  }

  @override
  Future<List<PasswordEntity>> getSavedPasswords() async {
    try {
      final allPasswords = await _localDataSource.getAllPasswords();
      return allPasswords.values
          .map((e) => PasswordEntity.fromJson(jsonDecode(e)))
          .toList();
    } catch (e) {
      throw PasswordStorageException(
        messageKey: '${LocaleKeys.errors_failedGetSavedPassword.tr()}: $e',
      );
    }
  }

  @override
  Future<void> savePassword(PasswordEntity password) async {
    try {
      await _localDataSource.savePassword(
        password.keyName,
        jsonEncode(password.toJson()),
      );
    } catch (e) {
      throw PasswordStorageException(
        messageKey: '${LocaleKeys.errors_failedSavePassword.tr()}: $e',
      );
    }
  }

  @override
  Future<String> loadEncryptedPassword(String name) async {
    try {
      final encrypted = await _localDataSource.loadPassword(name);
      if (encrypted == null) {
        throw ValidationException(
          messageKey: LocaleKeys.errors_passwordNotFound.tr(),
        );
      }
      return encrypted;
    } catch (e) {
      throw PasswordStorageException(
        messageKey: '${LocaleKeys.errors_failedLoadEncryptedPassword.tr()}: $e',
      );
    }
  }

  @override
  Future<void> deletePassword(PasswordEntity password) async {
    try {
      await _localDataSource.deletePassword(password.keyName);
    } catch (e) {
      throw PasswordStorageException(
        messageKey: '${LocaleKeys.errors_failedDeletePassword.tr()}: $e',
      );
    }
  }

  @override
  Future<void> updatePassword(PasswordEntity password) {
    try {
      return _localDataSource.savePassword(
        password.keyName,
        jsonEncode(password.toJson()),
      );
    } catch (e) {
      throw PasswordStorageException(
        messageKey: '${LocaleKeys.errors_failedUpdatePassword.tr()}: $e',
      );
    }
  }
}
