part of 'change_mode_cubit.dart';

class ChangeModeState {
  final bool isDarkMode;
  const ChangeModeState({required this.isDarkMode});

  factory ChangeModeState.init({required SharedPreferences prefs}) {
    return ChangeModeState(
        isDarkMode: prefs.getBool(Constants.sharePreferenceIsDarkMode) ?? true);
  }
}
