import 'package:freezed_annotation/freezed_annotation.dart';

import 'package:magic_password/core/enums/section_enum.dart';
import 'package:magic_password/domain/entities/password/password.dart';

part 'home_page_state.freezed.dart';

@freezed
class HomePageState with _$HomePageState {
  const factory HomePageState({
    @Default(true) bool isLoading,
    @Default([]) List<PasswordEntity> recentPasswords,
    @Default({}) Map<SectionEnum, List<PasswordEntity>> passwordsBySection,
    String? error,
  }) = _HomePageState;
}
