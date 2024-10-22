part of 'data_pokemon_bloc.dart';

class DataPokemonState {
  final List<Pokemon> listPokemons;
  final bool isErrorObtainData;
  final bool isChangeDataOnePokemon;
  final bool isCorrectDataOnePokemon;
  const DataPokemonState(
      {required this.listPokemons,
      required this.isErrorObtainData,
      required this.isChangeDataOnePokemon,
      required this.isCorrectDataOnePokemon});

  factory DataPokemonState.init() {
    return DataPokemonState(
      listPokemons: List.empty(growable: true),
      isErrorObtainData: false,
      isChangeDataOnePokemon: false,
      isCorrectDataOnePokemon: false,
    );
  }

  DataPokemonState copyWitch({
    required List<Pokemon>? listPokemons,
    bool? isErrorObtainData,
    bool? isChangeDataOnePokemon,
    bool? isCorrectDataOnePokemon,
  }) {
    return DataPokemonState(
        listPokemons: listPokemons ?? this.listPokemons,
        isErrorObtainData: isErrorObtainData ?? this.isErrorObtainData,
        isChangeDataOnePokemon:
            isChangeDataOnePokemon ?? this.isChangeDataOnePokemon,
        isCorrectDataOnePokemon:
            isCorrectDataOnePokemon ?? this.isCorrectDataOnePokemon);
  }
}


