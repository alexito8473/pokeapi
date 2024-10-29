part of 'change_mode_cubit.dart';

class ChangeModeState {
  final bool isDarkMode;
  const ChangeModeState({required this.isDarkMode});

  factory ChangeModeState.init() {
    return const ChangeModeState(isDarkMode: true);
  }
}
