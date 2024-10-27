import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';
import 'package:pokeapi/data/model/item.dart';
import 'package:pokeapi/domain/cubit/filterItems/filter_items_cubit.dart';

part 'filter_items_state.dart';

class FilterItemsCubit extends Cubit<FilterItemsState> {
  FilterItemsCubit() : super(FilterItemsState.init());

  void changeItemAttribute({required ItemAttribute itemAttribute}) {
    emit(FilterItemsState(itemAttribute: itemAttribute));
  }
}
