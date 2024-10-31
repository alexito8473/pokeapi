import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';
import 'package:pokeapi/domain/Constants.dart';
import 'package:shared_preferences/shared_preferences.dart';

part 'change_mode_state.dart';

class ChangeModeCubit extends Cubit<ChangeModeState> {
  final SharedPreferences prefs;
  ChangeModeCubit({required this.prefs})
      : super(ChangeModeState.init(prefs: prefs));

  void changeMode() async {
    await prefs.setBool(Constants.sharePreferenceIsDarkMode, !state.isDarkMode);
    emit(ChangeModeState(isDarkMode: !state.isDarkMode));
  }
}
