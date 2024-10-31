part of 'data_pokemon_bloc.dart';

class DataPokemonState {
  final Map<GenerationPokemon, List<Pokemon>> mapPokemons;
  final Map<GenerationPokemon, bool> mapCanObtainData;
  final bool isErrorObtainData;
  final bool isChangeDataOnePokemon;
  final bool isCorrectDataOnePokemon;
  const DataPokemonState(
      {required this.mapPokemons,
      required this.isErrorObtainData,
      required this.mapCanObtainData,
      required this.isChangeDataOnePokemon,
      required this.isCorrectDataOnePokemon});

  factory DataPokemonState.init() {
    Map<GenerationPokemon, List<Pokemon>> mapPokemons = Map();
    Map<GenerationPokemon, bool> listCanObtainData = Map();
    for (GenerationPokemon generationPokemon in GenerationPokemon.values) {
      listCanObtainData[generationPokemon] = true;
      mapPokemons[generationPokemon] = List.empty(growable: true);
    }
    return DataPokemonState(
      mapPokemons: mapPokemons,
      isErrorObtainData: false,
      isChangeDataOnePokemon: false,
      isCorrectDataOnePokemon: false,
      mapCanObtainData: listCanObtainData,
    );
  }
  List<Pokemon> getLisPokemon({required GenerationPokemon generationPokemon}) {
    return mapPokemons[generationPokemon]!;
  }

  DataPokemonState copyWitch({
    required Map<GenerationPokemon, List<Pokemon>>? mapPokemons,
    required Map<GenerationPokemon, bool>? listCanObtainData,
    bool? isErrorObtainData,
    bool? isChangeDataOnePokemon,
    bool? isCorrectDataOnePokemon,
  }) {
    return DataPokemonState(
        mapPokemons: mapPokemons ?? this.mapPokemons,
        isErrorObtainData: isErrorObtainData ?? this.isErrorObtainData,
        isChangeDataOnePokemon:
            isChangeDataOnePokemon ?? this.isChangeDataOnePokemon,
        isCorrectDataOnePokemon:
            isCorrectDataOnePokemon ?? this.isCorrectDataOnePokemon,
        mapCanObtainData: listCanObtainData ?? this.mapCanObtainData);
  }
}
