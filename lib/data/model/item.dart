enum ItemAttribute {
  COUNTABLE(id: 1, name: "Countable", maxCount: 72),
  CONSUMABLE(id: 2, name: "Consumable", maxCount: 70),
  USABLE_OVERWORLD(id: 3, name: "Usable overworld", maxCount: 42),
  USABLE_IN_BATTLE(id: 3, name: "Usable in battle", maxCount: 42),
  HOLDABLE(id: 5, name: "Holdable", maxCount: 175),
  HOLDABLE_ACTIVE(id: 7, name: "Holdable active", maxCount: -1),
  UNDERGROUND(id: 8, name: "Underground", maxCount: -1);

  final String name;
  final int id;
  final int maxCount;
  const ItemAttribute(
      {required this.name, required this.id, required this.maxCount});
}

class Item {
  final String name;
  final int cost;
  final String sprite;
  final String descriptionEn;
  const Item(
      {required this.name,
      required this.cost,
      required this.sprite,
      required this.descriptionEn});
}
