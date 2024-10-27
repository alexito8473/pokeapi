import 'package:bloc/bloc.dart';
import 'package:flutter/cupertino.dart';
import 'package:go_router/go_router.dart';
import 'package:http/http.dart';
import 'package:pokeapi/data/model/pokemon.dart';
import 'package:pokeapi/domain/Constants.dart';
import 'package:bloc_concurrency/bloc_concurrency.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
part 'data_pokemon_event.dart';
part 'data_pokemon_state.dart';

class DataPokemonBloc extends Bloc<DataPokemonEvent, DataPokemonState> {
  DataPokemonBloc() : super(DataPokemonState.init()) {
    const int maxPokemonObtain = 151;
    on<DataPokemonResetValueEvent>(
      (event, emit) {
        emit(DataPokemonState(
            listPokemons: state.listPokemons,
            isErrorObtainData: false,
            isChangeDataOnePokemon: false,
            isCorrectDataOnePokemon: false));
      },
    );
    on<DataOnePokemonEvent>((event, emit) async {
      Pokemon pokemon =
          state.listPokemons.firstWhere((element) => element.id == event.id);
      if (pokemon.haveAllData) {
        emit(DataPokemonState(
            isChangeDataOnePokemon: false,
            listPokemons: state.listPokemons,
            isCorrectDataOnePokemon: false,
            isErrorObtainData: false));
        event.context.go("/home/DataPokemon", extra: pokemon);
      } else {
        Pokemon newPokemon;
        dynamic dataOnePokemon;
        dynamic dataAbility;
        Response responseDataAbility;
        Response responseDataOnePokemon;
        List<Ability> listAbility = List.empty(growable: true);
        List<Move> listMovies = List.empty(growable: true);
        List<DetailMove> listDetailsMove = List.empty(growable: true);
        List<Stat> listStats = List.empty(growable: true);

        emit(DataPokemonState(
            isChangeDataOnePokemon: true,
            listPokemons: state.listPokemons,
            isCorrectDataOnePokemon: false,
            isErrorObtainData: false));

        if (event.haveWifi) {
          try {
            responseDataOnePokemon = await http.get(Uri.parse(
                "${Constants.urlObtainAdvancedDataPokemon}${pokemon.id}/"));
            if (responseDataOnePokemon.statusCode == 200) {
              dataOnePokemon = jsonDecode(responseDataOnePokemon.body);

              for (int i = 0; i < dataOnePokemon["abilities"].length; i++) {
                responseDataAbility = await http.get(Uri.parse(
                    dataOnePokemon["abilities"][i]["ability"]["url"]));
                if (responseDataAbility.statusCode == 200) {
                  dataAbility = jsonDecode(responseDataAbility.body);
                  listAbility.add(Ability(
                      effectEntries: dataAbility["effect_entries"][0]["effect"],
                      name: dataOnePokemon["abilities"][i]["ability"]["name"],
                      whenAppeared: dataAbility["generation"]["name"],
                      isHidden: dataOnePokemon["abilities"][i]["is_hidden"]));
                }
              }
              for (int i = 0; i < dataOnePokemon["moves"].length; i++) {
                listDetailsMove = List.empty(growable: true);

                for (int j = 0;
                    j <
                        dataOnePokemon["moves"][i]["version_group_details"]
                            .length;
                    j++) {
                  listDetailsMove.add(DetailMove(
                      level: dataOnePokemon["moves"][i]["version_group_details"]
                          [j]["level_learned_at"],
                      method: dataOnePokemon["moves"][i]
                              ["version_group_details"][j]["move_learn_method"]
                          ["name"],
                      game: dataOnePokemon["moves"][i]["version_group_details"]
                          [j]["version_group"]["name"]));
                }

                listMovies.add(Move(
                    name: dataOnePokemon["moves"][i]["move"]["name"],
                    detailsMoves: listDetailsMove));
              }

              for (int i = 0; i < dataOnePokemon["stats"].length; i++) {
                listStats.add(Stat(
                    name: dataOnePokemon["stats"][i]["stat"]["name"],
                    number: dataOnePokemon["stats"][i]["base_stat"]));
              }

              newPokemon = Pokemon(
                  id: pokemon.id,
                  name: pokemon.name,
                  sprites: pokemon.sprites,
                  listType: pokemon.listType,
                  weight: dataOnePokemon["weight"],
                  haveAllData: true,
                  listAbilities: listAbility,
                  listStats: listStats,
                  listMoves: listMovies);
              state.listPokemons.remove(pokemon);
              state.listPokemons.add(newPokemon);
              state.listPokemons.sort((a, b) => a.id!.compareTo(b.id!));
              event.context.go("/home/DataPokemon",
                  extra: newPokemon); //Navigation to DataPokemon
              emit(DataPokemonState(
                  isChangeDataOnePokemon: false,
                  listPokemons: state.listPokemons,
                  isCorrectDataOnePokemon: true,
                  isErrorObtainData: false));
            }
          } catch (e) {
            emit(DataPokemonState(
                isChangeDataOnePokemon: false,
                listPokemons: state.listPokemons,
                isCorrectDataOnePokemon: false,
                isErrorObtainData: true));
          }
        } else {
          emit(DataPokemonState(
              isChangeDataOnePokemon: false,
              listPokemons: state.listPokemons,
              isCorrectDataOnePokemon: false,
              isErrorObtainData: true));
        }
      }
    }, transformer: concurrent());
    on<DataAllPokemonEvent>((event, emit) async {
      if (state.listPokemons.length == maxPokemonObtain) return;
      dynamic dataAllPokemon;
      dynamic dataOnePokemon;
      Response responseDataOnePokemon;
      List<TypePokemon> listTypePokemon;
      TypePokemon? typePokemon;
      if (event.haveWifi) {
        String uri = state.listPokemons.isNotEmpty
            ? "${Constants.urlObtainBasicDataAllPokemon}?offset=${state.listPokemons.length}&limit=${maxPokemonObtain - state.listPokemons.length}"
            : "${Constants.urlObtainBasicDataAllPokemon}?limit=$maxPokemonObtain";
        try {
          Response responseDataAllPokemon = await http.get(Uri.parse(uri));
          if (responseDataAllPokemon.statusCode == 200) {
            dataAllPokemon = jsonDecode(responseDataAllPokemon.body);
            for (int i = 0; i < maxPokemonObtain; i++) {
              responseDataOnePokemon = await http
                  .get(Uri.parse(dataAllPokemon["results"][i]["url"]));
              if (responseDataOnePokemon.statusCode == 200) {
                listTypePokemon = [];
                dataOnePokemon = jsonDecode(responseDataOnePokemon.body);
                for (int j = 0; j < dataOnePokemon["types"].length; j++) {
                  typePokemon = TypePokemon.obtainType(
                      dataOnePokemon["types"][j]["type"]["name"]);

                  if (typePokemon != null) {
                    listTypePokemon.add(typePokemon);
                  }
                }
                state.listPokemons.add(Pokemon(
                    name: dataAllPokemon["results"][i]["name"],
                    id: dataOnePokemon["id"],
                    listType: listTypePokemon,
                    sprites: [
                      dataOnePokemon["sprites"]["front_default"],
                      dataOnePokemon["sprites"]["back_default"],
                      dataOnePokemon["sprites"]["front_shiny"],
                      dataOnePokemon["sprites"]["back_shiny"]
                    ],
                    listStats: null));
                emit(state.copyWitch(listPokemons: state.listPokemons));
              }
            }
            // Emit state final
            emit(state.copyWitch(listPokemons: state.listPokemons));
          } else {
            print('Error al obtener la lista de Pokémon.');
          }
        } catch (e) {
          print('Error en la solicitud de datos: $e');
        }
      } else {
        emit(state.copyWitch(listPokemons: state.listPokemons));
      }
    }, transformer: concurrent());
  }
  bool parseBool(String value) {
    return value.toLowerCase() == "true";
  }
}
