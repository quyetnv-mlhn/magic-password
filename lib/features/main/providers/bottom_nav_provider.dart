import 'package:magic_password/core/enums/section_enum.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:magic_password/features/main/states/bottom_nav_state.dart';

part 'bottom_nav_provider.g.dart';

@riverpod
class BottomNavNotifier extends _$BottomNavNotifier {
  static const searchPageIndex = 3;

  @override
  BottomNavState build() => const BottomNavState();

  void changeIndex(int index, {Map<String, dynamic>? params}) {
    state = state.copyWith(
      currentIndex: index,
      params: params ?? {},
    );
  }

  void goToSearchPage({
    bool autoFocus = true,
    SectionEnum? initSection,
    bool showFilterSheet = false,
  }) {
    changeIndex(
      searchPageIndex,
      params: {
        'autoFocus': autoFocus,
        'initSection': initSection,
        'showFilterSheet': showFilterSheet,
      },
    );
  }
}
