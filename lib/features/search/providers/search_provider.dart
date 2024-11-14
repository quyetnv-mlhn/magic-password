import 'package:magic_password/core/enums/section_enum.dart';
import 'package:magic_password/domain/entities/password/password.dart';
import 'package:magic_password/domain/entities/social_media/account_type.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:magic_password/app/providers/saved_password_provider.dart';
import 'package:magic_password/features/search/states/search_state.dart';

part 'search_provider.g.dart';

@riverpod
class SearchNotifier extends _$SearchNotifier {
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
    return passwords.where((password) {
      final matchesQuery = query.isEmpty ||
          password.accountType.name
              .toLowerCase()
              .contains(query.toLowerCase()) ||
          password.accountCredential
              .toLowerCase()
              .contains(query.toLowerCase());

      final matchesSection =
          sections.isEmpty || sections.contains(password.accountType.section);
      final matchesCategory =
          accountTypes.isEmpty || accountTypes.contains(password.accountType);

      return matchesQuery && matchesSection && matchesCategory;
    }).toList();
  }
}
