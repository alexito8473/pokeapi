part of 'data_item_bloc.dart';

class DataItemEvent {
  final bool haveWifi;
  final ItemAttribute itemAttribute;
  const DataItemEvent({required this.haveWifi, required this.itemAttribute});
}
