part of 'data_item_bloc.dart';

class DataItemEvent {
  final bool haveWifi;
  final ListItemCategory itemCategory;
  const DataItemEvent({required this.haveWifi, required this.itemCategory});
}
