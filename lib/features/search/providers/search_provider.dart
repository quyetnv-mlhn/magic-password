import 'dart:async';

import 'package:magic_password/app/providers/password_handler_provider.dart';
import 'package:magic_password/core/enums/section_enum.dart';
import 'package:magic_password/domain/entities/password/password.dart';
import 'package:magic_password/domain/entities/social_media/account_type.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:magic_password/app/providers/saved_password_provider.dart';
import 'package:magic_password/features/search/states/search_state.dart';

part 'search_provider.g.dart';

@riverpod
class SearchNotifier extends _$SearchNotifier {
  Timer? _debounceTimer;

  @override
  Future<SearchPageState> build() async {
    state = const AsyncData(SearchPageState(isLoading: true));
    final future = await Future.wait([
      ref.read(savedPasswordNotifierProvider.notifier).fetchSavedPasswords(),
      Future.delayed(const Duration(milliseconds: 700)),
    ]);
    return SearchPageState(
      allPasswords: future[0] as List<PasswordEntity>,
      filteredPasswords: future[0] as List<PasswordEntity>,
    );
  }

  void search(String query) {
    _debounceTimer?.cancel();
    _debounceTimer = Timer(const Duration(milliseconds: 300), () {
      final currentState = state.value;
      if (currentState == null) {
        return;
      }

      state = AsyncData(
        currentState.copyWith(
          searchQuery: query,
          filteredPasswords: _getFilteredPasswords(
            query: query,
            sections: currentState.selectedSections,
            accountTypes: currentState.selectedType,
            passwords: currentState.allPasswords,
          ),
        ),
      );
    });
  }

  void updateFilters({
    Set<SectionEnum>? sections,
    Set<AccountTypeEntity>? accountTypes,
  }) {
    final currentState = state.value;
    if (currentState == null) {
      return;
    }

    state = AsyncData(
      currentState.copyWith(
        selectedSections: sections ?? currentState.selectedSections,
        selectedType: accountTypes ?? currentState.selectedType,
        filteredPasswords: _getFilteredPasswords(
          query: currentState.searchQuery,
          sections: sections ?? currentState.selectedSections,
          accountTypes: accountTypes ?? currentState.selectedType,
          passwords: currentState.allPasswords,
        ),
      ),
    );
  }

  void clearFilters() {
    final currentState = state.value;
    if (currentState == null) {
      return;
    }

    state = AsyncData(
      currentState.copyWith(
        selectedSections: {},
        selectedType: {},
        filteredPasswords: currentState.allPasswords,
      ),
    );
  }

  List<PasswordEntity> _getFilteredPasswords({
    required String query,
    required Set<SectionEnum> sections,
    required Set<AccountTypeEntity> accountTypes,
    required List<PasswordEntity> passwords,
  }) {
    if (query.isEmpty && sections.isEmpty && accountTypes.isEmpty) {
      return passwords;
    }

    final lowercaseQuery = query.toLowerCase();
    return passwords.where((password) {
      if (query.isNotEmpty) {
        final matchesQuery = password.accountType.name
                .toLowerCase()
                .contains(lowercaseQuery) ||
            password.accountCredential.toLowerCase().contains(lowercaseQuery);
        if (!matchesQuery) {
          return false;
        }
      }

      if (sections.isNotEmpty &&
          !sections.contains(password.accountType.section)) {
        return false;
      }

      if (accountTypes.isNotEmpty &&
          !accountTypes.contains(password.accountType)) {
        return false;
      }

      return true;
    }).toList();
  }

  Future<void> deletePassword(PasswordEntity password) async {
    final passwordHandler = ref.read(passwordHandlerProvider.notifier);
    await passwordHandler.deletePassword(password);
    await refreshData();
  }

  Future<void> refreshData() async {
    state = AsyncData(state.value!.copyWith(isLoading: true));
    state = await AsyncValue.guard(build);
  }

  void setShowFilterSheet(bool show) {
    final currentState = state.value;
    if (currentState == null) {
      return;
    }

    state = AsyncData(currentState.copyWith(showFilterSheet: show));
  }

  void presetFilter({
    Set<SectionEnum>? sections,
    Set<AccountTypeEntity>? accountTypes,
  }) {
    updateFilters(
      sections: sections,
      accountTypes: accountTypes,
    );
    setShowFilterSheet(true);
  }
}
