import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:pokeapi/data/model/item.dart';
import 'package:pokeapi/data/model/pokemon.dart';
import 'package:pokeapi/data/model/typePokemon.dart';
import 'package:pokeapi/presentation/utils/calculator_type_pokemon.dart';

class CalculatorScreen extends StatefulWidget {
  final ScrollController scrollController;
  final GlobalKey globalKey;
  const CalculatorScreen(
      {super.key, required this.scrollController, required this.globalKey});

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

  Widget _getImageWitchToolTip({required TypePokemon type}) {
    return Tooltip(
        message: type.getTitle(),
        child:
            Image.asset(type.urlImageType, filterQuality: FilterQuality.high));
  }

  void _logicAddTypeToListResult({required TypePokemon type}) {
    if (listTypePokemonResult.length < 2 &&
        !listTypePokemonResult.contains(type)) {
      listTypePokemonResult.add(type);
      listTypePokemonFirst.remove(type);
      setState(() {
        mapLevelResistance.clear();
        mapLevelResistance.addAll(
            CalculatorTypePokemon.calculateListTypePokemonWeakAndResistance(
                listTypePokemon: listTypePokemonResult));
      });
    }
  }

  void _logicReturnTypeToListTypes({required TypePokemon type}) {
    listTypePokemonFirst.add(type);
    listTypePokemonResult.remove(type);
    setState(() {
      listTypePokemonFirst.sort((a, b) => a.index.compareTo(b.index));
      mapLevelResistance.clear();
      mapLevelResistance.addAll(
          CalculatorTypePokemon.calculateListTypePokemonWeakAndResistance(
              listTypePokemon: listTypePokemonResult));
    });
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.sizeOf(context);
    return CustomScrollView(controller: widget.scrollController, slivers: [
      SliverToBoxAdapter(
          key: widget.globalKey,
          child: SizedBox(
              width: size.width,
              child: Wrap(
                  runSpacing: 10,
                  spacing: 10,
                  alignment: WrapAlignment.center,
                  children: List.generate(
                      listTypePokemonFirst.length,
                      (index) => Draggable<TypePokemon>(
                          onDragCompleted: () => _logicAddTypeToListResult(
                              type: listTypePokemonFirst[index]),
                          feedback: Image.asset(
                              listTypePokemonFirst[index].urlImageType,
                              filterQuality: FilterQuality.high),
                          child: GestureDetector(
                              onTap: () => _logicAddTypeToListResult(
                                  type: listTypePokemonFirst[index]),
                              child: _getImageWitchToolTip(
                                  type: listTypePokemonFirst[index]))))))),
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
                      builder: (context, candidateData, rejectedData) => Wrap(
                          alignment: WrapAlignment.center,
                          runAlignment: WrapAlignment.center,
                          spacing: size.width * 0.05,
                          children: List.generate(
                            listTypePokemonResult.length,
                            (index) => GestureDetector(
                                onTap: () => _logicReturnTypeToListTypes(
                                    type: listTypePokemonResult[index]),
                                child: _getImageWitchToolTip(
                                    type: listTypePokemonResult[index])),
                          )))))),
      if (listTypePokemonResult.isNotEmpty)
        SliverPadding(
            padding: EdgeInsets.only(
                top: size.height * 0.05, left: size.width * 0.1, bottom: 10),
            sliver: const SliverToBoxAdapter(
                child: Text("Results",
                    style: TextStyle(fontSize: 30, letterSpacing: 2)))),
      if (listTypePokemonResult.isNotEmpty)
        SliverPadding(
            padding: EdgeInsets.only(
                bottom: size.height * 0.15,
                left: size.width * 0.1,
                right: size.width * 0.1),
            sliver: SliverList.builder(
                itemCount: mapLevelResistance.keys.length,
                itemBuilder: (context, index) => Card(
                    child: Container(
                        padding:
                            EdgeInsets.symmetric(vertical: size.height * 0.02),
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
                                      (index2) => _getImageWitchToolTip(
                                          type: mapLevelResistance.values
                                              .toList()[index][index2]))))
                        ])))))
    ]);
  }
}
