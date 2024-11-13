import 'package:magic_password/core/enums/section_enum.dart';
import 'package:magic_password/domain/entities/password/password.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

import 'package:magic_password/app/providers/password_handler_provider.dart';

part 'saved_password_provider.g.dart';

@Riverpod(keepAlive: true)
class SavedPasswordNotifier extends _$SavedPasswordNotifier {
  late final PasswordHandler _passwordHandler;

  @override
  Future<List<PasswordEntity>> build() async {
    _passwordHandler = ref.read(passwordHandlerProvider.notifier);
    return fetchSavedPasswords();
  }

  Future<List<PasswordEntity>> fetchSavedPasswords() async {
    return _passwordHandler.loadSavedPasswords();
  }

  Future<Map<SectionEnum, List<PasswordEntity>>>
      separatePasswordsByAccountType() async {
    final passwords = await fetchSavedPasswords();
    final Map<SectionEnum, List<PasswordEntity>> groupedPasswords = {};

    for (var password in passwords) {
      final section = password.accountType.section;
      if (groupedPasswords.containsKey(section)) {
        groupedPasswords[section]?.add(password);
      } else {
        groupedPasswords[section] = [password];
      }
    }

    return groupedPasswords;
  }

  Future<List<PasswordEntity>> getListPasswordsRecentUsed() async {
    final passwords = await fetchSavedPasswords();
    passwords.sort((a, b) => b.lastUsedAt.compareTo(a.lastUsedAt));
    return passwords.take(5).toList();
  }
}
