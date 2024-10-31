import 'dart:developer';

import 'package:bloc/bloc.dart';
import 'package:flutter/cupertino.dart';
import 'package:go_router/go_router.dart';
import 'package:http/http.dart';
import 'package:pokeapi/data/model/pokemon.dart';
import 'package:pokeapi/data/model/typePokemon.dart';
import 'package:pokeapi/domain/Constants.dart';
import 'package:bloc_concurrency/bloc_concurrency.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
part 'data_pokemon_event.dart';
part 'data_pokemon_state.dart';

class DataPokemonBloc extends Bloc<DataPokemonEvent, DataPokemonState> {
  DataPokemonBloc() : super(DataPokemonState.init()) {
    on<DataPokemonResetValueEvent>(
      (event, emit) {
        emit(DataPokemonState(
            mapPokemons: state.mapPokemons,
            isErrorObtainData: false,
            isChangeDataOnePokemon: false,
            isCorrectDataOnePokemon: false,
            mapCanObtainData: state.mapCanObtainData));
      },
    );
    on<DataOnePokemonEvent>((event, emit) async {
      Pokemon pokemon = state.mapPokemons[event.generationPokemon]!
          .firstWhere((element) => element.id == event.id);
      if (pokemon.haveAllData) {
        emit(DataPokemonState(
            isChangeDataOnePokemon: false,
            mapPokemons: state.mapPokemons,
            isCorrectDataOnePokemon: false,
            isErrorObtainData: false,
            mapCanObtainData: state.mapCanObtainData));
        event.context.go("/home/DataPokemon", extra: pokemon);
      } else {
        Pokemon newPokemon;
        dynamic dataOnePokemon;
        dynamic dataAbility;
        Response responseDataAbility;
        String textFlavor = "No data";
        Response responseDataOnePokemon;
        List<Ability> listAbility = List.empty(growable: true);
        List<Move> listMovies = List.empty(growable: true);
        List<DetailMove> listDetailsMove = List.empty(growable: true);
        List<Stat> listStats = List.empty(growable: true);

        emit(DataPokemonState(
            isChangeDataOnePokemon: true,
            mapPokemons: state.mapPokemons,
            isCorrectDataOnePokemon: false,
            isErrorObtainData: false,
            mapCanObtainData: state.mapCanObtainData));

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
                  if (dataAbility["effect_entries"].isNotEmpty) {
                    textFlavor = dataAbility["effect_entries"].firstWhere(
                      (element) => element["language"]["name"] == "en",
                    )["effect"];
                  } else if (dataAbility["flavor_text_entries"].isNotEmpty) {
                    textFlavor = dataAbility["flavor_text_entries"].firstWhere(
                      (element) => element["language"]["name"] == "en",
                    )["flavor_text"];
                  }
                  listAbility.add(Ability(
                      effectEntries: textFlavor,
                      name: dataOnePokemon["abilities"][i]["ability"]["name"]
                          .replaceAll("-", " "),
                      whenAppeared: dataAbility["generation"]["name"]
                          .replaceAll("-", " "),
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
              newPokemon = pokemon.copyWitch(
                  weight: dataOnePokemon["weight"],
                  height: dataOnePokemon["height"],
                  haveAllData: true,
                  listAbilities: listAbility,
                  listStats: listStats,
                  listMoves: listMovies);
              state.mapPokemons[event.generationPokemon]!.remove(pokemon);
              state.mapPokemons[event.generationPokemon]!.add(newPokemon);
              state.mapPokemons[event.generationPokemon]!
                  .sort((a, b) => a.id!.compareTo(b.id!));
              event.context.go("/home/DataPokemon",
                  extra: newPokemon); //Navigation to DataPokemon
              emit(DataPokemonState(
                  isChangeDataOnePokemon: false,
                  mapPokemons: state.mapPokemons,
                  isCorrectDataOnePokemon: true,
                  isErrorObtainData: false,
                  mapCanObtainData: state.mapCanObtainData));
            }
          } catch (e) {
            log(e.toString());
            emit(DataPokemonState(
                isChangeDataOnePokemon: false,
                mapPokemons: state.mapPokemons,
                isCorrectDataOnePokemon: false,
                isErrorObtainData: true,
                mapCanObtainData: state.mapCanObtainData));
          }
        } else {
          log("Error");
          emit(DataPokemonState(
              isChangeDataOnePokemon: false,
              mapPokemons: state.mapPokemons,
              isCorrectDataOnePokemon: false,
              isErrorObtainData: true,
              mapCanObtainData: state.mapCanObtainData));
        }
      }
    }, transformer: concurrent());
    on<DataAllPokemonEvent>((event, emit) async {
      dynamic dataAllPokemon;
      dynamic dataOnePokemon;
      Response responseDataOnePokemon;
      List<TypePokemon> listTypePokemon;
      TypePokemon? typePokemon;
      List<String> listSprite;
      if (event.haveWifi) {
        String uri =
            "${Constants.urlObtainBasicDataAllPokemonGeneration}/${event.generationPokemon.number}/";
        try {
          Response responseDataAllPokemon = await http.get(Uri.parse(uri));

          if (responseDataAllPokemon.statusCode == 200) {
            dataAllPokemon = jsonDecode(responseDataAllPokemon.body);
            if (state.mapPokemons[event.generationPokemon]!.length <=
                dataAllPokemon["pokemon_species"].length) {
              if (state.mapCanObtainData[event.generationPokemon]!) {
                if (!state.mapPokemons[event.generationPokemon]!.any(
                    (element) =>
                        element.name ==
                        dataAllPokemon["pokemon_species"]["name"])) {
                  state.mapCanObtainData[event.generationPokemon] = false;
                  emit(state.copyWitch(
                      mapPokemons: state.mapPokemons,
                      listCanObtainData: state.mapCanObtainData));
                  for (int i =
                          state.mapPokemons[event.generationPokemon]!.length;
                      i < dataAllPokemon["pokemon_species"].length;
                      i++) {
                    responseDataOnePokemon = await http.get(Uri.parse(
                        "${Constants.urlObtainBasicDataAllPokemon}${dataAllPokemon["pokemon_species"][i]["url"].toString().split("/")[dataAllPokemon["pokemon_species"][i]["url"].toString().split("/").length - 2]}"));
                    if (responseDataOnePokemon.statusCode == 200) {
                      listTypePokemon = [];
                      listSprite = [];
                      dataOnePokemon = jsonDecode(responseDataOnePokemon.body);

                      for (int j = 0; j < dataOnePokemon["types"].length; j++) {
                        typePokemon = TypePokemon.obtainType(
                            dataOnePokemon["types"][j]["type"]["name"]);
                        if (typePokemon != null) {
                          listTypePokemon.add(typePokemon);
                        }
                      }
                      checkCanAddStringToList(
                          list: listSprite,
                          item: dataOnePokemon["sprites"]["front_default"]);
                      checkCanAddStringToList(
                          list: listSprite,
                          item: dataOnePokemon["sprites"]["back_default"]);
                      checkCanAddStringToList(
                          list: listSprite,
                          item: dataOnePokemon["sprites"]["front_shiny"]);
                      checkCanAddStringToList(
                          list: listSprite,
                          item: dataOnePokemon["sprites"]["back_shiny"]);
                      state.mapPokemons[event.generationPokemon]!.add(Pokemon(
                          name: dataOnePokemon["name"],
                          id: dataOnePokemon["id"],
                          listType: listTypePokemon,
                          sprites: listSprite,
                          listStats: null));
                      state.mapPokemons[event.generationPokemon]!.sort(
                        (a, b) => a.id!.compareTo(b.id!),
                      );
                      state.mapPokemons[event.generationPokemon]!
                          .toSet()
                          .toList();
                      emit(state.copyWitch(
                          mapPokemons: state.mapPokemons,
                          listCanObtainData: state.mapCanObtainData));
                    }
                  }
                }
                state.mapCanObtainData[event.generationPokemon] = true;
                // Emit state final
                emit(state.copyWitch(
                    mapPokemons: state.mapPokemons,
                    listCanObtainData: state.mapCanObtainData));
              }
            }
          }
        } catch (e) {
          state.mapCanObtainData[event.generationPokemon] = true;
        }
      }
      emit(state.copyWitch(
          mapPokemons: state.mapPokemons,
          listCanObtainData: state.mapCanObtainData));
    }, transformer: concurrent());
  }
  List<Pokemon> getLisPokemon({required GenerationPokemon generationPokemon}) {
    return state.mapPokemons[generationPokemon]!;
  }

  void checkCanAddStringToList({required List<dynamic> list, dynamic item}) {
    if (item != null) {
      list.add(item);
    }
  }

  bool parseBool(String value) {
    return value.toLowerCase() == "true";
  }
}
