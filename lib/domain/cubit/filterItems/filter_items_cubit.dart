import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';
import 'package:pokeapi/data/model/item.dart';
part 'filter_items_state.dart';

class FilterItemsCubit extends Cubit<FilterItemsState> {
  FilterItemsCubit() : super(FilterItemsState.init());

  void changeItemAttribute({required ListItemCategory listItemCategory}) {
    emit(FilterItemsState(listItemCategory: listItemCategory));
  }
}
