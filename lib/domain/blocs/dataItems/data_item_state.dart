part of 'data_item_bloc.dart';

class DataItemState {
  final Map<String, List<Item>> mapCategory;
  final bool isErrorObtainData;
  const DataItemState(
      {required this.mapCategory, required this.isErrorObtainData});

  factory DataItemState.init() {
    return DataItemState(mapCategory: Map(), isErrorObtainData: false);
  }

  DataItemState copyWith(
      {required Map<String, List<Item>>? mapCategory,
      required bool? isErrorObtainData}) {
    return DataItemState(
        mapCategory: mapCategory ?? this.mapCategory,
        isErrorObtainData: isErrorObtainData ?? this.isErrorObtainData);
  }
}
