part of 'data_item_bloc.dart';

class DataItemState {
  final List<Item> listItems;

  const DataItemState({required this.listItems});

  factory DataItemState.init() {
    return DataItemState(listItems: List.empty(growable: true));
  }

  DataItemState copyWith({required List<Item>? listItems}) {
    return DataItemState(listItems: listItems ?? this.listItems);
  }

}
