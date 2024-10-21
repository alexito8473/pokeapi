import 'dart:convert';

import 'package:bloc/bloc.dart';
import 'package:http/http.dart';
import 'package:meta/meta.dart';
import 'package:http/http.dart' as http;
import 'package:pokeapi/data/model/item.dart';
import 'package:bloc_concurrency/bloc_concurrency.dart';
import 'package:pokeapi/domain/Constants.dart';
part 'data_item_event.dart';
part 'data_item_state.dart';

class DataItemBloc extends Bloc<DataItemEvent, DataItemState> {
  DataItemBloc() : super(DataItemState.init()) {
    on<DataItemEvent>((event, emit) async {
      dynamic dataAllPokemon;
      dynamic dataOneItem;
      Response responseDataOneItem;
      Response responseDataAllPokemon = await http.get(
          Uri.parse("${Constants.urlObtainBasicDataAllItems}?limit=100000"));
      if (responseDataAllPokemon.statusCode == 200) {
        dataAllPokemon = jsonDecode(responseDataAllPokemon.body);
        for (int i = 0; i < dataAllPokemon["results"].length; i++) {
          responseDataOneItem =
              await http.get(Uri.parse(dataAllPokemon["results"][i]["url"]));
          if (responseDataOneItem.statusCode == 200) {
            dataOneItem = jsonDecode(responseDataOneItem.body);

            state.listItems.add(Item(
                name: dataAllPokemon["results"][i]["name"],
                cost: dataOneItem["cost"],
                sprite: dataOneItem["sprites"]["default"],
                descriptionEs: dataOneItem["flavor_text_entries"]
                    .where(
                      (element) =>
                          element["version_group"]["name"] == "sword-shield" &&
                          element["language"]["name"] == "es",
                    )
                    .toList()[0]["text"]??"",
                descriptionEn: dataOneItem["flavor_text_entries"]
                    .where(
                      (element) =>
                          element["version_group"]["name"] == "sword-shield" &&
                          element["language"]["name"] == "en",
                    )
                    .toList()[0]["text"]??""));
            // emit(state.copyWitch(listPokemons: state.listPokemons));
          }
        }
      }
      emit(state.copyWith(listItems: state.listItems));
    }, transformer: concurrent());
  }
}
