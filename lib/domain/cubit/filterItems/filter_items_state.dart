part of 'filter_items_cubit.dart';

class FilterItemsState {
  final ItemAttribute itemAttribute;
  const FilterItemsState({required this.itemAttribute});

  factory FilterItemsState.init() {
    return const FilterItemsState(itemAttribute: ItemAttribute.COUNTABLE);
  }
}
