import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:magic_password/core/enums/section_enum.dart';
import 'package:magic_password/domain/entities/password/password.dart';
import 'package:magic_password/domain/entities/social_media/account_type.dart';

part 'search_state.freezed.dart';

@freezed
class SearchPageState with _$SearchPageState {
  const factory SearchPageState({
    @Default(false) bool isLoading,
    @Default([]) List<PasswordEntity> filteredPasswords,
    @Default([]) List<PasswordEntity> allPasswords,
    @Default('') String searchQuery,
    @Default({}) Set<SectionEnum> selectedSections,
    @Default({}) Set<AccountTypeEntity> selectedType,
  }) = _SearchPageState;
}
