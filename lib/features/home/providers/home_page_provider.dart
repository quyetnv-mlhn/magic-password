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
  @override
  Future<HomePageState> build() async {
    state = const AsyncData(HomePageState());

    try {
      return _loadData();
    } catch (e, stackTrace) {
      handleError(e, stackTrace);
      return _handleError(e);
    }
  }

  Future<HomePageState> _loadData() async {
    final savedPasswordProvider =
        ref.read(savedPasswordNotifierProvider.notifier);

    final futures = await Future.wait([
      savedPasswordProvider.separatePasswordsByAccountType(),
      savedPasswordProvider.getListPasswordsRecentUsed(),
      Future.delayed(const Duration(milliseconds: 700)),
    ]);

    return HomePageState(
      isLoading: false,
      passwordsBySection: futures[0] as Map<SectionEnum, List<PasswordEntity>>,
      recentPasswords: futures[1] as List<PasswordEntity>,
    );
  }

  HomePageState _handleError(Object error) {
    return HomePageState(
      isLoading: false,
      error: '${LocaleKeys.error} $error',
    );
  }

  Future<void> refreshData() async {
    state = AsyncData(state.value!.copyWith(isLoading: true));
    state = await AsyncValue.guard(_loadData);
  }
}
