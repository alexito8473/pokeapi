part of 'filter_items_cubit.dart';

class FilterItemsState {
  final ListItemCategory listItemCategory;
  const FilterItemsState({required this.listItemCategory});

  factory FilterItemsState.init() {
    return const FilterItemsState(listItemCategory: ListItemCategory.STAT_BOOSTS);
  }
}
