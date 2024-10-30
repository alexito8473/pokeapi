import 'package:pokeapi/data/model/pokemon.dart';

class CalculatorTypePokemon {
  static Map<LevelResistance, List<TypePokemon>>
      calculateListTypePokemonWeakAndResistance({required Pokemon pokemon}) {
    Map<LevelResistance, List<TypePokemon>> mapLevelResistance = Map();
    mapLevelResistance[LevelResistance.NORMAL] = List.empty(growable: true);
    mapLevelResistance[LevelResistance.SUPER_WEAK] = List.empty(growable: true);
    mapLevelResistance[LevelResistance.SUPER_RESISTANCE] =
        List.empty(growable: true);
    mapLevelResistance[LevelResistance.RESISTANCE] = pokemon.listType!
        .map((e) => e.getResistance())
        .expand((element) => element)
        .toList();
    mapLevelResistance[LevelResistance.WEAK] = pokemon.listType!
        .map((e) => e.getWeak())
        .expand((element) => element)
        .toList();
    mapLevelResistance[LevelResistance.INMUNE] = pokemon.listType!
        .map((e) => e.getImmune())
        .expand((element) => element)
        .toList();
    mapLevelResistance[LevelResistance.NORMAL]!.addAll(
        mapLevelResistance[LevelResistance.RESISTANCE]!.where((element) =>
            mapLevelResistance[LevelResistance.WEAK]!.contains(element)));

    mapLevelResistance[LevelResistance.RESISTANCE]!.removeWhere((element) =>
        mapLevelResistance[LevelResistance.INMUNE]!.contains(element));

    mapLevelResistance[LevelResistance.WEAK]!.removeWhere((element) =>
        mapLevelResistance[LevelResistance.INMUNE]!.contains(element));

    mapLevelResistance[LevelResistance.RESISTANCE]!.removeWhere((element) =>
        mapLevelResistance[LevelResistance.NORMAL]!.contains(element));

    mapLevelResistance[LevelResistance.WEAK]!.removeWhere((element) =>
        mapLevelResistance[LevelResistance.NORMAL]!.contains(element));

    calculateListSuperResistanceOrSuperWealTypePokemon(
        listResistanceOrWeak: mapLevelResistance[LevelResistance.RESISTANCE]!,
        listVeryResistanceOrWeak:
            mapLevelResistance[LevelResistance.SUPER_RESISTANCE]!);

    calculateListSuperResistanceOrSuperWealTypePokemon(
        listResistanceOrWeak: mapLevelResistance[LevelResistance.WEAK]!,
        listVeryResistanceOrWeak:
            mapLevelResistance[LevelResistance.SUPER_WEAK]!);

    // Add all type pokemons, for before eliminate the that we do not want.
    mapLevelResistance[LevelResistance.NORMAL]!.addAll(TypePokemon.values.where(
        (element) =>
            !mapLevelResistance[LevelResistance.NORMAL]!.contains(element)));

    // Remove allType for each level of resistance
    mapLevelResistance[LevelResistance.NORMAL]!.removeWhere((element) =>
        mapLevelResistance[LevelResistance.SUPER_WEAK]!.contains(element));

    mapLevelResistance[LevelResistance.NORMAL]!.removeWhere((element) =>
        mapLevelResistance[LevelResistance.WEAK]!.contains(element));

    mapLevelResistance[LevelResistance.NORMAL]!.removeWhere((element) =>
        mapLevelResistance[LevelResistance.RESISTANCE]!.contains(element));

    mapLevelResistance[LevelResistance.NORMAL]!.removeWhere((element) =>
        mapLevelResistance[LevelResistance.SUPER_RESISTANCE]!
            .contains(element));

    mapLevelResistance[LevelResistance.NORMAL]!.removeWhere((element) =>
        mapLevelResistance[LevelResistance.INMUNE]!.contains(element));

    mapLevelResistance.removeWhere((key, value) => value.isEmpty);
    return Map.fromEntries(mapLevelResistance.entries.toList()
      ..sort((a, b) => a.key.index.compareTo(b.key.index)));
  }

  static void calculateListSuperResistanceOrSuperWealTypePokemon(
      {required List<TypePokemon> listResistanceOrWeak,
      required List<TypePokemon> listVeryResistanceOrWeak}) {
    Map<TypePokemon, int> listTypePokemon = {};
    for (TypePokemon typePokemon in listResistanceOrWeak) {
      if (listTypePokemon[typePokemon] != null) {
        listTypePokemon[typePokemon] = listTypePokemon[typePokemon]! + 1;
      } else {
        listTypePokemon[typePokemon] = 1;
      }
    }
    listTypePokemon.removeWhere((key, value) => value < 2);
    if (listTypePokemon.isNotEmpty) {
      listVeryResistanceOrWeak.addAll(listTypePokemon.keys);
      listResistanceOrWeak
          .removeWhere((element) => listTypePokemon.keys.contains(element));
    }
  }
}
