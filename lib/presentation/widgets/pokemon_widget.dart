import 'dart:developer';

import 'package:auto_size_text/auto_size_text.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:pokeapi/data/model/pokemon.dart';
import 'package:pokeapi/domain/blocs/dataPokemon/data_pokemon_bloc.dart';
import 'package:pokeapi/presentation/utils/calculator_type_pokemon.dart';

class PokemonCardWidget extends StatelessWidget {
  final Pokemon pokemon;
  const PokemonCardWidget({super.key, required this.pokemon});

  Widget listWidgetTypePokemon() {
    return pokemon.listType == null || pokemon.listType!.isEmpty
        ? const SizedBox()
        : Expanded(
            child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: List.generate(pokemon.listType!.length, (index) {
                  return Container(
                      decoration: const BoxDecoration(boxShadow: [
                        BoxShadow(
                            color: Colors.black12,
                            blurRadius: 1,
                            spreadRadius: 1,
                            offset: Offset(2, 2))
                      ]),
                      child: Image.asset(pokemon.listType![index].urlImageType,
                          width: 30));
                })));
  }

  BoxDecoration _boxDecoration({required bool isDarkMode}) {
    return pokemon.listType == null || pokemon.listType!.isEmpty
        ? BoxDecoration(
            color: Colors.grey[200], borderRadius: BorderRadius.circular(20))
        : BoxDecoration(
            image: DecorationImage(
                fit: BoxFit.cover,
                alignment: Alignment.bottomLeft,
                filterQuality: FilterQuality.none,
                colorFilter:
                    const ColorFilter.mode(Colors.black45, BlendMode.darken),
                image: AssetImage(pokemon.listType![0].urlImageBackground)),
            boxShadow: [
              BoxShadow(
                  offset: const Offset(3, 3),
                  color: isDarkMode ? Colors.white12 : Colors.black38,
                  blurRadius: 2,
                  spreadRadius: 2)
            ],
            borderRadius: BorderRadius.circular(20));
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.sizeOf(context);
    return GestureDetector(
        onTap: () => {
              context.read<DataPokemonBloc>().add(DataOnePokemonEvent(
                  haveWifi: true, id: pokemon.id!, context: context))
            },
        child: Container(
            decoration: _boxDecoration(
                isDarkMode: Theme.of(context).brightness == Brightness.dark),
            padding: const EdgeInsets.all(10),
            child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  Text(
                      pokemon.name.substring(0, 1).toUpperCase() +
                          pokemon.name.substring(1, pokemon.name.length),
                      style: const TextStyle(fontSize: 19, letterSpacing: 2)),
                  Expanded(
                      child: Row(
                    children: [
                      listWidgetTypePokemon(),
                      Hero(
                          tag: pokemon.sprites[0],
                          child: CachedNetworkImage(
                            imageUrl: pokemon.sprites[0],
                            progressIndicatorBuilder:
                                (context, url, downloadProgress) => SizedBox(
                                    width: 95,
                                    child: Image.asset(
                                        "assets/pokeball/pokeball.gif",
                                        width: 100)),
                            errorWidget: (context, url, error) =>
                                const Icon(Icons.error),
                          )),
                    ],
                  )),
                  Container(
                      width: size.width,
                      alignment: Alignment.bottomRight,
                      child: Text('#${pokemon.id.toString()}'))
                ])));
  }
}

class StatsPokemon extends StatelessWidget {
  final Pokemon pokemon;
  const StatsPokemon({super.key, required this.pokemon});

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.sizeOf(context);
    String convertName({required String nameSpecial}) {
      if (nameSpecial.startsWith("spec")) {
        return "sp ${nameSpecial.split("-")[1].substring(0, 3)}";
      } else {
        return nameSpecial;
      }
    }

    return Padding(
        padding: EdgeInsets.symmetric(horizontal: size.width * 0.05),
        child: SingleChildScrollView(
            child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: List.generate(
            pokemon.listStats!.length,
            (index) {
              return Padding(
                  padding: const EdgeInsets.symmetric(vertical: 10),
                  child: Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      SizedBox(
                          width: size.width * 0.3,
                          child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Text(
                                    convertName(
                                        nameSpecial:
                                            pokemon.listStats![index].name),
                                    style: const TextStyle(
                                        fontSize: 18, letterSpacing: 1)),
                                Text(
                                    pokemon.listStats![index].number.toString(),
                                    style: const TextStyle(
                                        fontSize: 18, letterSpacing: 1))
                              ])),
                      RatingBar(
                          ignoreGestures: true,
                          itemCount: 10,
                          initialRating:
                              ((100 * pokemon.listStats![index].number) / 255) *
                                  0.1,
                          allowHalfRating: true,
                          ratingWidget: RatingWidget(
                              full: Container(
                                  decoration: BoxDecoration(
                                      border: Border.all(
                                          color: Colors.black.withOpacity(0.1)),
                                      borderRadius: BorderRadius.circular(20),
                                      color: Colors.orange),
                                  width: 10,
                                  height: 20,
                                  margin: const EdgeInsets.only(right: 10)),
                              half: Container(
                                  decoration: BoxDecoration(
                                      border: Border.all(
                                          color: Colors.black.withOpacity(0.1)),
                                      gradient: const LinearGradient(
                                          begin: Alignment.centerLeft,
                                          end: Alignment.centerRight,
                                          colors: [Colors.orange, Colors.grey]),
                                      borderRadius: BorderRadius.circular(20),
                                      color: Colors.orange),
                                  width: 10,
                                  height: 20,
                                  margin: const EdgeInsets.only(right: 10)),
                              empty: Container(
                                  decoration: BoxDecoration(
                                      color: Colors.grey,
                                      border: Border.all(color: Colors.black.withOpacity(0.1)),
                                      borderRadius: BorderRadius.circular(20)),
                                  width: 10,
                                  height: 20,
                                  margin: const EdgeInsets.only(right: 10))),
                          itemSize: 18,
                          onRatingUpdate: (double value) {})
                    ],
                  ));
            },
          ),
        )));
  }
}

class AboutMePokemon extends StatelessWidget {
  final Pokemon pokemon;
  const AboutMePokemon({super.key, required this.pokemon});

  Widget getColumn({required String up, required String down}) {
    return Expanded(
        child: Column(mainAxisAlignment: MainAxisAlignment.center, children: [
      Text(up.toString(), style: const TextStyle(letterSpacing: 1)),
      const SizedBox(height: 5),
      Text(down.toString(),
          style: TextStyle(color: Colors.black.withOpacity(0.4)))
    ]));
  }

  Widget getColumnList(
      {required List<String> up,
      required String down,
      bool isListImage = false}) {
    return Column(mainAxisAlignment: MainAxisAlignment.center, children: [
      Wrap(
          runAlignment: WrapAlignment.center,
          children: List.generate(
              up.length,
              (index) => isListImage
                  ? Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 5),
                      child: Image.asset(up[index], width: 30))
                  : Text(up[index]))),
      const SizedBox(height: 5),
      Text(down.toString(),
          style: TextStyle(color: Colors.black.withOpacity(0.4)))
    ]);
  }

  Widget _getContainerData(
      {required Size size, required Widget left, required Widget right,required BuildContext context}) {
    return Container(
        margin: const EdgeInsets.all(10),
        padding: const EdgeInsets.all(10),
        constraints: const BoxConstraints(minHeight: 80),
        width: size.width * 0.8,
        decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(20),
            color: Colors.grey.withOpacity(.4)),
        child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [left, Container(color: Theme.of(context).dividerColor, width: 1,height: size.height*0.08,), right]));
  }

  void _showBottomSheetListAbilities(
      {required BuildContext context, required Size size}) {
    showModalBottomSheet(
        context: context,
        builder: (BuildContext context) {
          return Container(
              padding: const EdgeInsets.all(20),
              height: size.height * 0.5, // Set your desired height
              child: ListView.builder(
                  itemCount: pokemon.listAbilities!.length,
                  itemBuilder: (context, index) {
                    List<String> listContain = pokemon
                        .listAbilities![index].effectEntries
                        .split("\n")
                        .where((element) => element.trim().isNotEmpty)
                        .toList();
                    return Card(
                        color: Colors.orange.withOpacity(0.6),
                        child: Container(
                            padding: const EdgeInsets.all(10),
                            constraints: const BoxConstraints(minHeight: 300),
                            decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(20)),
                            height: size.height * 0.3,
                            child: Column(children: [
                              Padding(
                                  padding: EdgeInsets.only(
                                      bottom: size.height * 0.005,
                                      top: size.height * 0.005),
                                  child: Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceBetween,
                                      children: [
                                        Text(pokemon.listAbilities![index].name,
                                            style:
                                                const TextStyle(fontSize: 20)),
                                        Text(pokemon
                                            .listAbilities![index].whenAppeared)
                                      ])),
                              Expanded(
                                  child: SingleChildScrollView(
                                      scrollDirection: Axis.horizontal,
                                      child: Row(
                                          children: List.generate(
                                              listContain.length, (index2) {
                                        return Container(
                                            margin:
                                                const EdgeInsets.only(left: 10),
                                            padding: EdgeInsets.only(
                                                right: size.width * 0.05,
                                                top: size.height * 0.01,
                                                bottom: size.height * 0.01),
                                            decoration: BoxDecoration(
                                                border: Border(
                                                    right: BorderSide(
                                                        color:
                                                            listContain.length -
                                                                        1 ==
                                                                    index2
                                                                ? Colors
                                                                    .transparent
                                                                : Colors
                                                                    .black))),
                                            width: size.width * 0.7,
                                            child: AutoSizeText(
                                                listContain[index2],
                                                minFontSize: 10,
                                                textAlign: TextAlign.justify,
                                                style: const TextStyle(
                                                    letterSpacing: 1)));
                                      })))),
                              SizedBox(
                                  height: 20,
                                  child: AutoSizeText(
                                      "Is hidden: ${pokemon.listAbilities![index].isHidden}",
                                      textAlign: TextAlign.justify,
                                      style: const TextStyle(letterSpacing: 1)))
                            ])));
                  }));
        });
  }

  void _showBottomSheetListTypes(
      {required BuildContext context, required Size size}) {
    Map<LevelResistance, List<TypePokemon>> mapLevelResistance =
        CalculatorTypePokemon.calculateListTypePokemonWeakAndResistance(
            pokemon: pokemon);

    showModalBottomSheet(
        context: context,
        builder: (BuildContext context) {
          return Container(
              width: size.width,
              height: size.height,
              padding: EdgeInsets.symmetric(horizontal: size.width * 0.1),
              child: ListView.builder(
                padding: EdgeInsets.symmetric(vertical: size.height * 0.05),
                itemCount: mapLevelResistance.keys.length,
                itemBuilder: (context, index) {
                  return Card(
                      color: pokemon.listType![0].color.withOpacity(0.3),
                      child: Container(
                        padding:
                            EdgeInsets.symmetric(vertical: size.height * 0.02),
                        child: Column(
                          children: [
                            AutoSizeText(
                                mapLevelResistance.keys.toList()[index].title,
                                maxLines: 1,
                                style: const TextStyle(
                                    fontSize: 20, letterSpacing: 1)),
                            const SizedBox(height: 10),
                            Align(
                                alignment: Alignment.center,
                                child: Wrap(
                                  spacing: 10,
                                  runSpacing: 10,
                                  alignment: WrapAlignment.center,
                                  children: List.generate(
                                    mapLevelResistance.values
                                        .toList()[index]
                                        .length,
                                    (index2) {
                                      return Image.asset(mapLevelResistance
                                          .values
                                          .toList()[index][index2]
                                          .urlImageType);
                                    },
                                  ),
                                ))
                          ],
                        ),
                      ));
                },
              ));
        });
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.sizeOf(context);
    return Column(
      children: [
        _getContainerData(
            size: size,
            right: getColumn(
                up: "${(pokemon.weight! * 0.1).toStringAsFixed(2)} Kg",
                down: "Weight"),
            left: getColumn(
                up: "${(pokemon.height! * 0.1).toStringAsFixed(2)} m",
                down: "Height"), context: context),
        _getContainerData(
            size: size,
            right: Expanded(
                child: InkWell(
                    onTap: () =>
                        _showBottomSheetListTypes(context: context, size: size),
                    child: getColumnList(
                        up: pokemon.listType!
                            .map((e) => e.urlImageType)
                            .toList(),
                        isListImage: true,
                        down: "Type"))),
            left: Expanded(
                child: InkWell(
                    onTap: () => _showBottomSheetListAbilities(
                        context: context, size: size),
                    child: getColumn(
                        up: pokemon.listAbilities!
                            .map((e) => "${e.name.replaceAll("-", " ")} ")
                            .toList().join(", "),
                        down: "Abilities"))), context: context)
      ],
    );
  }
}

class MovePokemon extends StatelessWidget {
  final Pokemon pokemon;
  const MovePokemon({super.key, required this.pokemon});

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.sizeOf(context);
    return ListView.builder(
        itemCount: pokemon.listMoves!.length,
        itemBuilder: (context, index) {
          return Card(
              color: pokemon.listType![0].color.withOpacity(0.3),
              child: ExpansionTile(
                  shape: const Border(),
                  title:
                      Text(pokemon.listMoves![index].name.replaceAll("-", " ")),
                  children: List.generate(
                      pokemon.listMoves![index].detailsMoves.length, (index2) {
                    return Card(
                        color: Theme.of(context).brightness == Brightness.dark
                            ? Colors.black.withOpacity(0.4)
                            : Colors.white.withOpacity(0.4),
                        child: Padding(
                            padding: EdgeInsets.all(size.width * 0.015),
                            child: Column(
                                crossAxisAlignment: CrossAxisAlignment.stretch,
                                children: [
                                  AutoSizeText(
                                      "Version game obtain: ${pokemon.listMoves![index].detailsMoves[index2].game}",
                                      style: const TextStyle(letterSpacing: 1)),
                                  AutoSizeText(
                                      "Method obtain: ${pokemon.listMoves![index].detailsMoves[index2].method}",
                                      style: const TextStyle(letterSpacing: 1)),
                                  AutoSizeText(
                                      "Level obtain: ${pokemon.listMoves![index].detailsMoves[index2].level}",
                                      style: const TextStyle(letterSpacing: 1))
                                ])));
                  })));
        });
  }
}
