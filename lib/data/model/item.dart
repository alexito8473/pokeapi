enum ListItemCategory {
  STAT_BOOSTS(id: 1, name: "Stat boosts"),
  EFFECT_DROP(id: 2, name: "Effect drop"),
  MEDICINE(id: 3, name: "Medicine"),
  PICKY_HEALING(id: 6, name: "Pick healing"),
  TYPE_PROTECTION(id: 7, name: "Type protection"),
  BACKING_ONLY(id: 8, name: "Backing only"),
  COLLECTIBLES(id: 9, name: "Collectibles"),
  EVOLUTION(id: 10, name: "Evolution"),
  SPELUNKING(id: 11, name: "Spelunking"),
  HELD_ITEMS(id: 12, name: "Held items"),
  CHOICE(id: 13, name: "Choice"),
  EFFORT_TRAINING(id: 14, name: "Effort training"),
  BAD_HELD_ITEMS(id: 15, name: "Bad held items"),
  TRAINING(id: 16, name: "Training"),
  EVENT_ITEMS(id: 20, name: "Event items"),
  GAMEPLAY(id: 21, name: "Gameplay"),
  ALL_MAIL(id: 25, name: "All mail"),
  VITAMINS(id: 26, name: "Vitamins"),
  HEALING(id: 27, name: "Healing"),
  PP_RECOVERY(id: 28, name: "PP recovery"),
  REVIVAL(id: 29, name: "Revival"),
  STATUS_CURES(id: 30, name: "Status cures"),
  SPECIAL_BALLS(id: 33, name: "Special balls"),
  STANDARD_BALLS(id: 34, name: "Standard balls"),
  APRICORN_BALLS(id: 39, name: "Apricorn balls"),
  MEGA_STONES(id: 44, name: "Mega stones"),
  MEMORIES(id: 45, name: "Memories"),
  Z_CRYSTALS(id: 46, name: "Z crystals");

  final String name;
  final int id;

  const ListItemCategory({required this.name, required this.id});
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
