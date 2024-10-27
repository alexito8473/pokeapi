part of 'data_pokemon_bloc.dart';

class DataPokemonEvent {
  final bool haveWifi;
  const DataPokemonEvent({required this.haveWifi});
}

class DataPokemonResetValueEvent extends DataPokemonEvent {

  const DataPokemonResetValueEvent({super.haveWifi=true});
}

class DataAllPokemonEvent extends DataPokemonEvent {
  const DataAllPokemonEvent({required super.haveWifi});
}

class DataOnePokemonEvent extends DataPokemonEvent {
  final int id;
  final BuildContext context;
  const DataOnePokemonEvent( {required super.haveWifi,required this.id,required this.context});
}

