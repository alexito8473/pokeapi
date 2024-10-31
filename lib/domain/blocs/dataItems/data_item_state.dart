part of 'data_item_bloc.dart';

class DataItemState {
  final Map<ListItemCategory, List<Item>> mapCategory;
  final Map<ListItemCategory, bool> mapCanObtainData;
  final bool isErrorObtainData;
  const DataItemState(
      {required this.mapCategory,
      required this.isErrorObtainData,
      required this.mapCanObtainData});

  factory DataItemState.init() {
    final Map<ListItemCategory, List<Item>> mapCategory = Map();
    final Map<ListItemCategory, bool> mapCanObtainData = Map();
    for (ListItemCategory itemCategory in ListItemCategory.values) {
      mapCategory[itemCategory] = List.empty(growable: true);
      mapCanObtainData[itemCategory] = true;
    }
    return DataItemState(
        mapCategory: mapCategory,
        isErrorObtainData: false,
        mapCanObtainData: mapCanObtainData);
  }

  DataItemState copyWith(
      {required Map<ListItemCategory, List<Item>>? mapCategory,
      required bool? isErrorObtainData,
      required Map<ListItemCategory, bool> mapCanObtainData}) {
    return DataItemState(
        mapCategory: mapCategory ?? this.mapCategory,
        isErrorObtainData: isErrorObtainData ?? this.isErrorObtainData,
        mapCanObtainData: mapCanObtainData);
  }
}
