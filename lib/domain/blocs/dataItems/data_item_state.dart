part of 'data_item_bloc.dart';

class DataItemState {
  final List<Item> listItemsCountable;
  final List<Item> listItemsConsumable;
  final List<Item> listItemsUsableOverWorld;
  final List<Item> listItemsUsableInBattle;
  final List<Item> listItemsHoldable;
  final List<Item> listItemsHoldableActive;
  final List<Item> listItemsUnderGround;
  final ItemAttribute currentAttribute;
  const DataItemState(
      {required this.listItemsCountable,
      required this.listItemsConsumable,
      required this.listItemsUsableOverWorld,
      required this.listItemsUsableInBattle,
      required this.listItemsHoldable,
      required this.listItemsHoldableActive,
      required this.listItemsUnderGround,
      required this.currentAttribute});

  factory DataItemState.init() {
    return DataItemState(
      listItemsCountable: List.empty(growable: true),
      listItemsConsumable: List.empty(growable: true),
      listItemsUsableOverWorld: List.empty(growable: true),
      listItemsUsableInBattle: List.empty(growable: true),
      listItemsHoldable: List.empty(growable: true),
      listItemsHoldableActive: List.empty(growable: true),
      listItemsUnderGround: List.empty(growable: true),
      currentAttribute: ItemAttribute.COUNTABLE,
    );
  }
  List<Item> getSpecificListItem(ItemAttribute itemAttribute) {
    switch (itemAttribute) {
      case ItemAttribute.COUNTABLE:
        return listItemsCountable;
      case ItemAttribute.CONSUMABLE:
        return listItemsConsumable;
      case ItemAttribute.USABLE_OVERWORLD:
        return listItemsUsableOverWorld;
      case ItemAttribute.USABLE_IN_BATTLE:
        return listItemsUsableInBattle;
      case ItemAttribute.HOLDABLE:
        return listItemsHoldable;
      case ItemAttribute.HOLDABLE_ACTIVE:
        return listItemsHoldableActive;
      case ItemAttribute.UNDERGROUND:
        return listItemsUnderGround;
    }
  }

  DataItemState copyWith(
      {required List<Item>? listItemsCountable,
      required List<Item>? listItemsConsumable,
      required List<Item>? listItemsUsableOverWorld,
      required List<Item>? listItemsUsableInBattle,
      required List<Item>? listItemsHoldable,
      required List<Item>? listItemsHoldableActive,
      required List<Item>? listItemsUnderGround,
      required ItemAttribute? currentAttribute}) {
    return DataItemState(
      listItemsCountable: listItemsCountable ?? this.listItemsCountable,
      listItemsConsumable: listItemsConsumable ?? this.listItemsConsumable,
      listItemsUsableOverWorld:
          listItemsUsableOverWorld ?? this.listItemsUsableOverWorld,
      listItemsHoldable: listItemsHoldable ?? this.listItemsHoldable,
      listItemsHoldableActive:
          listItemsHoldableActive ?? this.listItemsHoldableActive,
      listItemsUnderGround: listItemsUnderGround ?? this.listItemsUnderGround,
      listItemsUsableInBattle:
          listItemsUsableInBattle ?? this.listItemsUsableInBattle,
      currentAttribute: currentAttribute ?? this.currentAttribute,
    );
  }
}
