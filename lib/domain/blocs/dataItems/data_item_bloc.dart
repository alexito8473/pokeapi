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
      dynamic dataOnePocket;
      dynamic dataOneItem;
      Response responseOneCategory;
      Response responseOneItem;
      int initIndex = 0;
      bool completeListItem = false;
      List<Item> listItems = List.empty(growable: true);
      if (event.haveWifi) {
        try {
          responseOneCategory = await http.get(Uri.parse(
              "${Constants.urlObtainBasicDataAllItems}/${event.itemCategory.id}"));
          if (responseOneCategory.statusCode == 200) {
            dataOnePocket = jsonDecode(responseOneCategory.body);
            if (state.mapCategory[event.itemCategory.name] != null) {
              if (state.mapCategory[event.itemCategory.name]!.length <
                  dataOnePocket["items"].length) {
                initIndex =
                    state.mapCategory[event.itemCategory.name]!.length - 1;
              } else if (state.mapCategory[event.itemCategory.name]!.length >=
                  dataOnePocket["items"].length) {
                completeListItem = true;
              }
              listItems.addAll(state.mapCategory[event.itemCategory.name]!);
            }
            if (!completeListItem) {
              for (int i = initIndex; i < dataOnePocket["items"].length; i++) {
                responseOneItem =
                    await http.get(Uri.parse(dataOnePocket["items"][i]["url"]));

                if (responseOneItem.statusCode == 200) {
                  dataOneItem = jsonDecode(responseOneItem.body);
                  listItems.add(Item(
                      name: event.itemCategory == ListItemCategory.Z_CRYSTALS
                          ? dataOnePocket["items"][i]["name"]
                              .toString()
                              .replaceAll("-", " ")
                              .replaceFirst("held", "")
                              .trim()
                          : dataOnePocket["items"][i]["name"],
                      cost: dataOneItem["cost"],
                      sprite: dataOneItem["sprites"]["default"] ??
                          "assets/item/itemNull.png",
                      descriptionEn: dataOneItem["flavor_text_entries"]
                          .firstWhere((element) =>
                              element["language"]["name"] == "en")["text"]));
                  addOrUpdate(
                      clave: event.itemCategory.name,
                      currentListItems: listItems,
                      emit: emit);
                }
              }
            }
          }
          addOrUpdate(
              clave: event.itemCategory.name,
              currentListItems: listItems,
              emit: emit);
        } catch (e) {
          emit(state.copyWith(
              mapCategory: state.mapCategory, isErrorObtainData: true));
        }
      } else {
        emit(state.copyWith(
            mapCategory: state.mapCategory, isErrorObtainData: true));
      }
    }, transformer: concurrent());
  }
  List<Item>? getItems({required String clave}) {
    return state.mapCategory[clave];
  }

  void addOrUpdate(
      {required String clave,
      required List<Item> currentListItems,
      required Emitter<DataItemState> emit}) {
    state.mapCategory[clave] = currentListItems;
    emit(state.copyWith(
        mapCategory: state.mapCategory, isErrorObtainData: false));
  }
}
