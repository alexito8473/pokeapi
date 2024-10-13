import 'package:bloc/bloc.dart';
import 'package:http/http.dart';
import 'package:meta/meta.dart';
import 'package:pokeapi/data/model/pokemon.dart';
import 'package:pokeapi/data/model/type_pokemon.dart';
import 'package:pokeapi/domain/Constants.dart';
import 'package:pokeapi/domain/repositories/obtain_data_pokemons_repository.dart';
import 'package:bloc_concurrency/bloc_concurrency.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
part 'data_pokemon_event.dart';
part 'data_pokemon_state.dart';

class DataPokemonBloc extends Bloc<DataPokemonEvent, DataPokemonState> {
  DataPokemonBloc() : super(DataPokemonState.init()) {
    const int maxPokemonObtain = 151;
    on<DataPokemonEvent>((event, emit) async {
      dynamic dataAllPokemon;
      dynamic dataOnePokemon;
      Response responseDataOnePokemon;
      List<TypePokemon> listTypePokemon;
      TypePokemon? typePokemon;
      Response responseDataAllPokemon = await http.get(Uri.parse(
          "${Constants.urlObtainBasicDataAllPokemon}?limit=$maxPokemonObtain"));
      if (responseDataAllPokemon.statusCode == 200) {
        dataAllPokemon = jsonDecode(responseDataAllPokemon.body);
        for (int i = 0; i < maxPokemonObtain; i++) {
          responseDataOnePokemon =
              await http.get(Uri.parse(dataAllPokemon["results"][i]["url"]));
          if (responseDataOnePokemon.statusCode == 200) {
            listTypePokemon=[];
            dataOnePokemon = jsonDecode(responseDataOnePokemon.body);
            for (int i = 0; i < dataOnePokemon["types"].length; i++) {
              typePokemon = TypePokemon.obtainType(
                  dataOnePokemon["types"][i]["type"]["name"]);
              if (typePokemon != null) {
                listTypePokemon.add(typePokemon);
              }
            }
           state.listPokemons.add(Pokemon(
                name: dataAllPokemon["results"][i]["name"],
                id: i+1,
                spriteBack: dataOnePokemon["sprites"]["back_default"],
                spriteFront: dataOnePokemon["sprites"]["front_default"],
                spriteBackShiny: dataOnePokemon["sprites"]["back_shiny"],
                spriteFrontShiny: dataOnePokemon["sprites"]["front_shiny"],
                listType: listTypePokemon));
            emit(state.copyWitch(listPokemons: state.listPokemons));
          }
        }
      }
      emit(state.copyWitch(listPokemons: state.listPokemons));
    }, transformer: concurrent());
  }
}
