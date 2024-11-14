import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:magic_password/features/main/states/bottom_nav_state.dart';

part 'bottom_nav_provider.g.dart';

@riverpod
class BottomNavNotifier extends _$BottomNavNotifier {
  @override
  BottomNavState build() => const BottomNavState();

  void changeIndex(int index, {Map<String, dynamic>? params}) {
    state = state.copyWith(
      currentIndex: index,
      params: params ?? {},
    );
  }

  void goToSearchPage({bool autoFocus = true}) {
    changeIndex(3, params: {'autoFocus': autoFocus});
  }
}
