part of 'filter_items_cubit.dart';

class FilterItemsState {
  final ListItemCategory listItemCategory;
  const FilterItemsState({required this.listItemCategory});

  factory FilterItemsState.init({required SharedPreferences prefs}) {
    return FilterItemsState(
        listItemCategory: ListItemCategory.obtainListItemCategory(
            prefs.getString(Constants.sharePreferenceItem)));
  }
}
