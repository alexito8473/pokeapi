import 'dart:convert';
import 'dart:developer';

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

      String textFlavor = "No have data";
      if (event.haveWifi) {
        try {
          responseOneCategory = await http.get(Uri.parse(
              "${Constants.urlObtainBasicDataAllItems}/${event.itemCategory.id}"));
          if (responseOneCategory.statusCode == 200) {
            dataOnePocket = jsonDecode(responseOneCategory.body);
            if (state.mapCategory[event.itemCategory]!.length <
                dataOnePocket["items"].length) {
              initIndex = state.mapCategory[event.itemCategory]!.length;
            } else if (state.mapCategory[event.itemCategory]!.length >=
                dataOnePocket["items"].length) {
              completeListItem = true;
            }
            if (!completeListItem) {
              if (state.mapCanObtainData[event.itemCategory]!) {
                state.mapCanObtainData[event.itemCategory] != false;
                emit(state.copyWith(
                    mapCategory: state.mapCategory,
                    isErrorObtainData: false,
                    mapCanObtainData: state.mapCanObtainData));
                for (int i = initIndex;
                    i < dataOnePocket["items"].length;
                    i++) {
                  responseOneItem = await http
                      .get(Uri.parse(dataOnePocket["items"][i]["url"]));

                  if (responseOneItem.statusCode == 200) {
                    dataOneItem = jsonDecode(responseOneItem.body);
                    if (!state.mapCategory[event.itemCategory]!.any((element) =>
                        element.name ==
                        (event.itemCategory == ListItemCategory.Z_CRYSTALS
                            ? dataOnePocket["items"][i]["name"]
                                .toString()
                                .replaceAll("-", " ")
                                .replaceFirst("held", "")
                                .trim()
                            : dataOnePocket["items"][i]["name"]))) {
                      if (dataOneItem["flavor_text_entries"].isNotEmpty) {
                        textFlavor = dataOneItem["flavor_text_entries"]
                            .firstWhere((element) =>
                                element["language"]["name"] == "en")["text"];
                      }
                      state.mapCategory[event.itemCategory]!.add(Item(
                          name:
                              event.itemCategory == ListItemCategory.Z_CRYSTALS
                                  ? dataOnePocket["items"][i]["name"]
                                      .toString()
                                      .replaceAll("-", " ")
                                      .replaceFirst("held", "")
                                      .trim()
                                  : dataOnePocket["items"][i]["name"],
                          cost: dataOneItem["cost"],
                          sprite: dataOneItem["sprites"]["default"] ??
                              "assets/item/itemNull.png",
                          descriptionEn: textFlavor));
                    }
                  }
                  emit(state.copyWith(
                      mapCategory: state.mapCategory,
                      isErrorObtainData: false,
                      mapCanObtainData: state.mapCanObtainData));
                }
              }
            }
          }
          state.mapCanObtainData[event.itemCategory] != true;
          emit(state.copyWith(
              mapCategory: state.mapCategory,
              isErrorObtainData: false,
              mapCanObtainData: state.mapCanObtainData));
        } catch (e) {
          log("Error " + dataOneItem.toString());
          log(e.toString());
          state.mapCanObtainData[event.itemCategory] != true;
          emit(state.copyWith(
              mapCategory: state.mapCategory,
              isErrorObtainData: true,
              mapCanObtainData: state.mapCanObtainData));
        }
      } else {
        emit(state.copyWith(
            mapCategory: state.mapCategory,
            isErrorObtainData: true,
            mapCanObtainData: state.mapCanObtainData));
      }
    }, transformer: concurrent());
  }
  List<Item>? getItems({required ListItemCategory clave}) {
    return state.mapCategory[clave];
  }
}
