import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:pokeapi/data/model/item.dart';
import 'package:pokeapi/data/model/pokemon.dart';
import 'package:pokeapi/data/model/typePokemon.dart';
import 'package:pokeapi/presentation/utils/calculator_type_pokemon.dart';

class CalculatorScreen extends StatefulWidget {
  const CalculatorScreen({super.key});

  @override
  State<CalculatorScreen> createState() => _CalculatorScreenState();
}

class _CalculatorScreenState extends State<CalculatorScreen> {
  late final List<TypePokemon> listTypePokemonFirst =
      List.empty(growable: true);
  late final List<TypePokemon> listTypePokemonResult =
      List.empty(growable: true);
  Map<LevelResistance, List<TypePokemon>> mapLevelResistance = {};
  @override
  void initState() {
    listTypePokemonFirst.addAll(TypePokemon.values
        .toList()
        .where((element) => element != TypePokemon.STELLAR));
    listTypePokemonFirst.sort((a, b) => a.index.compareTo(b.index));
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.sizeOf(context);
    return CustomScrollView(slivers: [
      SliverToBoxAdapter(
        child: SizedBox(
            width: size.width,
            child: Wrap(
                runSpacing: 10,
                spacing: 10,
                alignment: WrapAlignment.center,
                children: List.generate(
                  listTypePokemonFirst.length,
                  (index) {
                    return Draggable<TypePokemon>(
                        onDragCompleted: () {
                          if (listTypePokemonResult.length < 2 &&
                              !listTypePokemonResult
                                  .contains(listTypePokemonFirst[index])) {
                            listTypePokemonResult
                                .add(listTypePokemonFirst[index]);
                            listTypePokemonFirst
                                .remove(listTypePokemonFirst[index]);
                            setState(() {
                              mapLevelResistance.clear();
                              mapLevelResistance.addAll(CalculatorTypePokemon
                                  .calculateListTypePokemonWeakAndResistance(
                                      listTypePokemon: listTypePokemonResult));
                            });
                          }
                        },
                        feedback: Image.asset(
                            listTypePokemonFirst[index].urlImageType,
                            filterQuality: FilterQuality.high),
                        child: Image.asset(
                            listTypePokemonFirst[index].urlImageType,
                            filterQuality: FilterQuality.high));
                  },
                ))),
      ),
      SliverToBoxAdapter(
          child: Card(
              margin: EdgeInsets.only(
                  top: size.height * 0.05,
                  left: size.width * 0.2,
                  right: size.width * 0.2),
              child: SizedBox(
                height: size.height * 0.1,
                width: size.width * .4,
                child: DragTarget(
                  builder: (context, candidateData, rejectedData) {
                    return Wrap(
                        alignment: WrapAlignment.center,
                        runAlignment: WrapAlignment.center,
                        spacing: size.width * 0.05,
                        children: List.generate(
                          listTypePokemonResult.length,
                          (index) {
                            return GestureDetector(
                                onTap: () => setState(() {
                                      listTypePokemonFirst
                                          .add(listTypePokemonResult[index]);
                                      listTypePokemonResult
                                          .remove(listTypePokemonResult[index]);
                                      listTypePokemonFirst.sort(
                                          (a, b) => a.index.compareTo(b.index));
                                      mapLevelResistance.clear();
                                      mapLevelResistance.addAll(
                                          CalculatorTypePokemon
                                              .calculateListTypePokemonWeakAndResistance(
                                                  listTypePokemon:
                                                      listTypePokemonResult));
                                    }),
                                child: Image.asset(
                                    listTypePokemonResult[index].urlImageType));
                          },
                        ));
                  },
                ),
              ))),
      if (listTypePokemonResult.isNotEmpty)
        SliverPadding(
            padding: EdgeInsets.only(
                top: size.height * 0.05, left: size.width * 0.1, bottom: 10),
            sliver: SliverToBoxAdapter(
                child: Text(
              "Results",
              style: TextStyle(fontSize: 30, letterSpacing: 2),
            ))),
      if (listTypePokemonResult.isNotEmpty)
        SliverPadding(
            padding: EdgeInsets.only(
                bottom: size.height * 0.15,
                left: size.width * 0.1,
                right: size.width * 0.1),
            sliver: SliverList.builder(
                itemCount: mapLevelResistance.keys.length,
                itemBuilder: (context, index) {
                  return Card(
                      child: Container(
                          padding: EdgeInsets.symmetric(
                              vertical: size.height * 0.02),
                          child: Column(children: [
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
                                    )))
                          ])));
                }))
    ]);
  }
}

class ImageTypePokemon extends StatefulWidget {
  final TypePokemon typePokemon;
  const ImageTypePokemon({super.key, required this.typePokemon});

  @override
  State<ImageTypePokemon> createState() => _ImageTypePokemonState();
}

class _ImageTypePokemonState extends State<ImageTypePokemon> {
  @override
  Widget build(BuildContext context) {
    return const Placeholder();
  }
}
