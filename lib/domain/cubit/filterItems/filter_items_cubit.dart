import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';
import 'package:pokeapi/data/model/item.dart';
import 'package:pokeapi/domain/Constants.dart';
import 'package:shared_preferences/shared_preferences.dart';
part 'filter_items_state.dart';

class FilterItemsCubit extends Cubit<FilterItemsState> {
  final SharedPreferences prefs;
  FilterItemsCubit({required this.prefs})
      : super(FilterItemsState.init(prefs: prefs));

  void changeItemAttribute({required ListItemCategory listItemCategory}) async {
    await prefs.setString(Constants.sharePreferenceItem, listItemCategory.name);
    emit(FilterItemsState(listItemCategory: listItemCategory));
  }
}
