import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:magic_password/features/main/states/bottom_nav_state.dart';

part 'bottom_nav_provider.g.dart';

@riverpod
class BottomNavNotifier extends _$BottomNavNotifier {
  @override
  BottomNavState build() => const BottomNavState();

  void changeIndex(int index) {
    state = state.copyWith(currentIndex: index);
  }
}
