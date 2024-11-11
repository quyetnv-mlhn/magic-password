import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:magic_password/data/datasources/local/password_local_datasource.dart';
import 'package:magic_password/data/datasources/local/password_manager_datasource.dart';
import 'package:magic_password/data/repositories/password_repository_impl.dart';
import 'package:magic_password/domain/repositories/password_repository.dart';
import 'package:magic_password/services/password_manager.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'providers.g.dart';

@Riverpod(keepAlive: true)
FlutterSecureStorage secureStorage(Ref ref) {
  return const FlutterSecureStorage();
}

@Riverpod(keepAlive: true)
PasswordManager passwordManager(Ref ref) {
  return PasswordManager();
}

@Riverpod(keepAlive: true)
PasswordLocalDataSource passwordLocalDataSource(Ref ref) {
  final storage = ref.watch(secureStorageProvider);
  return PasswordLocalDataSourceImpl(storage: storage);
}

@Riverpod(keepAlive: true)
PasswordManagerDataSource passwordManagerDataSource(Ref ref) {
  final passwordManager = ref.watch(passwordManagerProvider);
  return PasswordManagerDataSourceImpl(passwordManager: passwordManager);
}

// Repository Provider
@Riverpod(keepAlive: true)
PasswordRepository passwordRepository(Ref ref) {
  final localDataSource = ref.watch(passwordLocalDataSourceProvider);
  final managerDataSource = ref.watch(passwordManagerDataSourceProvider);

  return PasswordRepositoryImpl(
    localDataSource: localDataSource,
    managerDataSource: managerDataSource,
  );
}
