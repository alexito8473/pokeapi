part of 'data_pokemon_bloc.dart';

class DataPokemonState {
  final List<Pokemon> listPokemons;

  const DataPokemonState({required this.listPokemons});

  factory DataPokemonState.init() {
    return DataPokemonState(listPokemons: List.empty(growable: true));
  }

  DataPokemonState copyWitch({required List<Pokemon>? listPokemons}) {
    return DataPokemonState(listPokemons: listPokemons ?? this.listPokemons);
  }
}
