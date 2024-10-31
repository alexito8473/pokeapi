part of 'data_pokemon_bloc.dart';

class DataPokemonEvent {
  final bool haveWifi;
  final GenerationPokemon generationPokemon;
  const DataPokemonEvent( {required this.haveWifi,required this.generationPokemon});
}

class DataPokemonResetValueEvent extends DataPokemonEvent {
  const DataPokemonResetValueEvent({super.haveWifi = true, required super.generationPokemon});
}

class DataAllPokemonEvent extends DataPokemonEvent {

  const DataAllPokemonEvent(
      {required super.haveWifi, required super.generationPokemon});
}

class DataOnePokemonEvent extends DataPokemonEvent {
  final int id;
  final BuildContext context;
  const DataOnePokemonEvent(
      {required super.haveWifi, required this.id, required this.context, required super.generationPokemon});
}
