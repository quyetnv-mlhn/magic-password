import 'package:magic_password/app/providers/saved_password_provider.dart';
import 'package:magic_password/core/enums/section_enum.dart';
import 'package:magic_password/core/utils/error_handler.dart';
import 'package:magic_password/domain/entities/password/password.dart';
import 'package:magic_password/gen/locale_keys.g.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

import 'package:magic_password/features/home/states/home_page_state.dart';

part 'home_page_provider.g.dart';

@riverpod
class HomePageNotifier extends _$HomePageNotifier {
  late final SavedPasswordNotifier _savedPasswordProvider;

  @override
  Future<HomePageState> build() async {
    state = const AsyncData(HomePageState());

    try {
      _savedPasswordProvider = ref.read(savedPasswordNotifierProvider.notifier);

      final futures = await Future.wait([
        _savedPasswordProvider.separatePasswordsByAccountType(),
        _savedPasswordProvider.getListPasswordsRecentUsed(),
      ]);

      return HomePageState(
        isLoading: false,
        passwordsBySection:
            futures[0] as Map<SectionEnum, List<PasswordEntity>>,
        recentPasswords: futures[1] as List<PasswordEntity>,
      );
    } catch (e, stackTrace) {
      handleError(e, stackTrace);

      return HomePageState(
        isLoading: false,
        error: '${LocaleKeys.error} ${e.toString()}',
      );
    }
  }

  Future<void> refreshData() async {
    state = AsyncData(state.value!.copyWith(isLoading: true));
    state = await AsyncValue.guard(build);
  }
}
