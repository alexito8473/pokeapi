import 'package:pokeapi/data/model/type_pokemon.dart';

class Pokemon {
  final String name;
  final int? id;
  final String? urlDataPokemon;
  final List<String>? listAbilities;
  final List<String>? listMoves;
  final List<TypePokemon>? listType;
  final double? height;
  final String? spriteBack;
  final String? spriteFront;
  final String? spriteBackShiny;
  final String? spriteFrontShiny;
  const Pokemon(
      {required this.name,
      this.id,
      this.urlDataPokemon,
      this.listAbilities,
      this.height,
      this.listMoves,
      this.spriteBack,
      this.spriteFront,
      this.spriteBackShiny,
      this.spriteFrontShiny,
      this.listType});
}
