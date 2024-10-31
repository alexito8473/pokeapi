import 'package:pokeapi/data/model/typePokemon.dart';

enum GenerationPokemon {
  GENERATION_I(title: "Generation 1", number: 1),
  GENERATION_II(title: "Generation 2", number: 2),
  GENERATION_III(title: "Generation 3", number: 3),
  GENERATION_IV(title: "Generation 4", number: 4),
  GENERATION_V(title: "Generation 5", number: 5),
  GENERATION_VI(title: "Generation 6", number: 6),
  GENERATION_VII(title: "Generation 7", number: 7),
  GENERATION_VIII(title: "Generation 8", number: 8),
  GENERATION_IX(title: "Generation 9", number: 9);

  final String title;
  final int number;
  const GenerationPokemon({required this.title, required this.number});

  static GenerationPokemon obtainGenerationPokemon(String? generationString) {
    GenerationPokemon generation = GenerationPokemon.GENERATION_I;
    if (generationString != null) {
      for (GenerationPokemon generationPokemon in GenerationPokemon.values) {
        if (generationPokemon.title == generationString) {
          generation = generationPokemon;
        }
      }
    }
    return generation;
  }
}

class Ability {
  final String effectEntries;
  final String name;
  final bool isHidden;
  final String whenAppeared;
  const Ability(
      {required this.effectEntries,
      required this.name,
      required this.whenAppeared,
      required this.isHidden});
}

class Move {
  final String name;
  final List<DetailMove> detailsMoves;
  const Move({required this.name, required this.detailsMoves});
}

class DetailMove {
  final int level;
  final String method;
  final String game;
  const DetailMove(
      {required this.level, required this.method, required this.game});
}

class Stat {
  final String name;
  final int number;
  const Stat({required this.name, required this.number});
}

class Pokemon {
  final String name;
  final int? id;
  final List<Ability>? listAbilities;
  final List<TypePokemon>? listType;
  final List<Stat>? listStats;
  final List<String> sprites;
  final List<Move>? listMoves;
  final int? weight;
  final int? height;
  final bool haveAllData;
  const Pokemon(
      {required this.name,
      this.id,
      this.listAbilities,
      this.weight,
      this.listMoves,
      this.listType,
      this.haveAllData = false,
      required this.sprites,
      required this.listStats,
      this.height});

  Pokemon copyWitch(
      {String? name,
      int? id,
      List<Ability>? listAbilities,
      List<TypePokemon>? listType,
      List<Stat>? listStats,
      List<String>? sprites,
      List<Move>? listMoves,
      int? weight,
      int? height,
      bool? haveAllData}) {
    return Pokemon(
        name: name ?? this.name,
        sprites: sprites ?? this.sprites,
        listStats: listStats ?? this.listStats,
        id: id ?? this.id,
        listAbilities: listAbilities ?? this.listAbilities,
        listType: listType ?? this.listType,
        listMoves: listMoves ?? this.listMoves,
        haveAllData: haveAllData ?? this.haveAllData,
        height: height ?? this.height,
        weight: weight ?? this.weight);
  }
}
