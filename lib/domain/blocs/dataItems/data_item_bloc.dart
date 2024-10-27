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
      List<Item> listItem = state.getSpecificListItem(event.itemAttribute);
      if (event.itemAttribute.maxCount == listItem.length) return;
      dynamic dataAllPokemon;
      dynamic dataOneItem;
      Response responseDataOneItem;
      Response responseDataAllPokemon;
      if (event.haveWifi) {
        try {
          responseDataAllPokemon = await http.get(Uri.parse(
              "${Constants.urlObtainBasicDataAllItems}/${event.itemAttribute.id}"));
        print("event${event.itemAttribute.name}");
          if (responseDataAllPokemon.statusCode == 200) {
            dataAllPokemon = jsonDecode(responseDataAllPokemon.body);
            print(
                "${event.itemAttribute.name} tamaño: ${dataAllPokemon["items"].length}");
            for (int i = 0; i < dataAllPokemon["items"].length; i++) {
              responseDataOneItem =
                  await http.get(Uri.parse(dataAllPokemon["items"][i]["url"]));
              if (responseDataOneItem.statusCode == 200) {
                dataOneItem = jsonDecode(responseDataOneItem.body);
                try {
                  listItem.add(Item(
                      name: dataAllPokemon["items"][i]["name"],
                      cost: dataOneItem["cost"],
                      sprite: dataOneItem["sprites"]["default"],
                      descriptionEn: dataOneItem["flavor_text_entries"]
                              .where(
                                (element) =>
                                    element["language"]["name"] == "en",
                              )
                              .toList()
                              .reversed
                              .toList()[0]["text"] ??
                          ""));
                } catch (e) {
                  print("Position=${i} Error: " + "\n ${e}");
                }
                emit(state.copyWith(
                    listItemsCountable:
                        ItemAttribute.COUNTABLE == event.itemAttribute
                            ? listItem
                            : state.listItemsCountable,
                    listItemsConsumable:
                        ItemAttribute.CONSUMABLE == event.itemAttribute
                            ? listItem
                            : state.listItemsConsumable,
                    listItemsUsableOverWorld:
                        ItemAttribute.USABLE_OVERWORLD == event.itemAttribute
                            ? listItem
                            : state.listItemsUsableOverWorld,
                    listItemsHoldable: ItemAttribute.HOLDABLE == event.itemAttribute
                        ? listItem
                        : state.listItemsHoldable,
                    listItemsHoldableActive:
                        ItemAttribute.HOLDABLE_ACTIVE == event.itemAttribute
                            ? listItem
                            : state.listItemsHoldableActive,
                    listItemsUnderGround:
                        ItemAttribute.UNDERGROUND == event.itemAttribute
                            ? listItem
                            : state.listItemsUnderGround,
                    listItemsUsableInBattle:
                        ItemAttribute.USABLE_IN_BATTLE == event.itemAttribute
                            ? listItem
                            : state.listItemsUsableInBattle,
                    currentAttribute: event.itemAttribute));
              }
            }
          }
        } catch (e) {
          print("Error" + e.toString());
        }
      } else {
        emit(state.copyWith(
            listItemsCountable: ItemAttribute.COUNTABLE == event.itemAttribute
                ? listItem
                : state.listItemsCountable,
            listItemsConsumable: ItemAttribute.CONSUMABLE == event.itemAttribute
                ? listItem
                : state.listItemsConsumable,
            listItemsUsableOverWorld:
                ItemAttribute.USABLE_OVERWORLD == event.itemAttribute
                    ? listItem
                    : state.listItemsUsableOverWorld,
            listItemsHoldable: ItemAttribute.HOLDABLE == event.itemAttribute
                ? listItem
                : state.listItemsHoldable,
            listItemsHoldableActive:
                ItemAttribute.HOLDABLE_ACTIVE == event.itemAttribute
                    ? listItem
                    : state.listItemsHoldableActive,
            listItemsUnderGround:
                ItemAttribute.UNDERGROUND == event.itemAttribute
                    ? listItem
                    : state.listItemsUnderGround,
            listItemsUsableInBattle:
                ItemAttribute.USABLE_IN_BATTLE == event.itemAttribute
                    ? listItem
                    : state.listItemsUsableInBattle,
            currentAttribute: event.itemAttribute));
      }
    }, transformer: concurrent());
  }
  List<Item> currentListItem() {
    switch (state.currentAttribute) {
      case ItemAttribute.COUNTABLE:
        return state.listItemsCountable;
      case ItemAttribute.CONSUMABLE:
        return state.listItemsConsumable;
      case ItemAttribute.USABLE_OVERWORLD:
        return state.listItemsUsableOverWorld;
      case ItemAttribute.USABLE_IN_BATTLE:
        return state.listItemsUsableInBattle;
      case ItemAttribute.HOLDABLE:
        return state.listItemsHoldable;
      case ItemAttribute.HOLDABLE_ACTIVE:
        return state.listItemsHoldableActive;
      case ItemAttribute.UNDERGROUND:
        return state.listItemsUnderGround;
    }
  }
}
