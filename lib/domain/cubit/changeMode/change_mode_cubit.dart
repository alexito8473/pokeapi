import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';

part 'change_mode_state.dart';

class ChangeModeCubit extends Cubit<ChangeModeState> {
  ChangeModeCubit() : super(ChangeModeState.init());

  void changeMode() {
    emit(ChangeModeState(isDarkMode: !state.isDarkMode));
  }
}
