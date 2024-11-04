import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:pokeapi/data/model/pokemon.dart';
import 'package:pokeapi/data/model/typePokemon.dart';
import 'package:pokeapi/domain/blocs/dataPokemon/data_pokemon_bloc.dart';
import 'package:pokeapi/domain/cubit/changeMode/change_mode_cubit.dart';
import 'package:pokeapi/domain/cubit/connectivity/connectivity_cubit.dart';
import 'package:pokeapi/domain/cubit/filterPokemon/filter_pokemons_cubit.dart';
import 'package:pokeapi/presentation/widgets/pokemon_widget.dart';

class GridPokemonsScreen extends StatefulWidget {
  final ScrollController scrollControllerPokemonScreen;
  final GlobalKey globalKey;
  const GridPokemonsScreen(
      {super.key,
      required this.globalKey,
      required this.scrollControllerPokemonScreen});
  @override
  State<GridPokemonsScreen> createState() => _GridPokemonsScreenState();
}

class _GridPokemonsScreenState extends State<GridPokemonsScreen> {
  final TextEditingController _controller = TextEditingController();
  bool isActiveFilter = false;
  late String currentMapKey;
  String typeAllPokemon = "All";
  late Map<String, Color> mapTypes;
  @override
  void initState() {
    mapTypes = Map();
    currentMapKey = typeAllPokemon;
    mapTypes.putIfAbsent(typeAllPokemon, () => Colors.white);
    for (TypePokemon typePokemon in TypePokemon.values) {
      mapTypes.putIfAbsent(typePokemon.getTitle(), () => typePokemon.color);
    }
    super.initState();
  }

  void _onSelectionFilterTypePokemon({String? value}) {
    if (value == null) return;
    setState(() {
      currentMapKey = value;
    });
  }

  void _logicDropMenu({GenerationPokemon? value}) {
    if (value != null) {
      context
          .read<FilterPokemonsCubit>()
          .changePokemon(generationPokemon: value);
      context.read<DataPokemonBloc>().add(DataAllPokemonEvent(
          generationPokemon: value,
          haveWifi: context.read<ConnectivityCubit>().state.haveWifi));
    }
  }

  List<DropdownMenuEntry<String>> _generateListMapTypePokemon() {
    return mapTypes.entries.map(
      (entry) {
        return DropdownMenuEntry<String>(
            label: entry.key,
            value: entry.key,
            style: ButtonStyle(
                shape: WidgetStateProperty.all(RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(20)))));
      },
    ).toList();
  }

  void _changeModeFilter() => setState(() => isActiveFilter = !isActiveFilter);

  List<Pokemon> _filterListPokemon({required List<Pokemon> listPokemon}) {
    return typeAllPokemon == currentMapKey
        ? listPokemon
            .where((element) => element.name.contains(_controller.value.text))
            .toList()
        : listPokemon
            .where((element) =>
                element.name.contains(_controller.value.text) &&
                element.listType!
                    .contains(TypePokemon.obtainType(currentMapKey.toLowerCase())))
            .toList();
  }
  @override
  Widget build(BuildContext context) {
    bool isDarkMode = context.watch<ChangeModeCubit>().state.isDarkMode;
    Size size = MediaQuery.sizeOf(context);
    return BlocBuilder<DataPokemonBloc, DataPokemonState>(
        builder: (context, state) {
      List<Pokemon> listPokemon = _filterListPokemon(
          listPokemon: state.getLisPokemon(
              generationPokemon: context
                  .watch<FilterPokemonsCubit>()
                  .state
                  .generationPokemon));
      return Stack(children: [
        Positioned.fill(
            child: CustomScrollView(
          controller: widget.scrollControllerPokemonScreen,
          slivers: [
            SliverPadding(
                key: widget.globalKey,
                padding: EdgeInsets.symmetric(
                    horizontal: size.width * 0.05, vertical: 10),
                sliver: const SliverAppBar(
                    expandedHeight: 60.0,
                    automaticallyImplyLeading: false,
                    flexibleSpace: FlexibleSpaceBar(
                        background: Text(
                            "An app that uses the PokéAPI to search and view detailed information about Pokémon, such as their types, abilities, and stats, with a simple and intuitive interface.",
                            style: TextStyle(letterSpacing: 1, fontSize: 11)),
                        collapseMode: CollapseMode.parallax))),
            SliverAppBar(
                expandedHeight: 70.0,
                floating: true,
                pinned: true,
                automaticallyImplyLeading: false,
                backgroundColor: Colors.transparent,
                scrolledUnderElevation: 0,
                flexibleSpace: FlexibleSpaceBar(
                    background: Container(
                        margin: EdgeInsets.symmetric(
                            horizontal: size.width * 0.05,
                            vertical: size.height * 0.012),
                        child: Container(
                            padding: const EdgeInsets.only(left: 10),
                            decoration: BoxDecoration(
                                color: Theme.of(context).brightness ==
                                        Brightness.dark
                                    ? Colors.grey[800]
                                    : Colors.grey[200],
                                borderRadius: BorderRadius.circular(30.0)),
                            width: size.width * .6,
                            child: Row(
                              children: [
                                Expanded(
                                    child: TextField(
                                        controller: _controller,
                                        onChanged: (value) => setState(
                                            () => _controller.text = value),
                                        decoration: const InputDecoration(
                                            hintText: 'Search Pokémon...',
                                            border: InputBorder.none,
                                            focusColor: Colors.black,
                                            hoverColor: Colors.black,
                                            icon: Icon(Icons.search,
                                                color: Colors.blueAccent)))),
                                IconButton(
                                    onPressed: () => _changeModeFilter(),
                                    icon: isActiveFilter
                                        ? const Icon(Icons.arrow_upward)
                                        : const Icon(Icons.arrow_downward))
                              ],
                            ))),
                    collapseMode: CollapseMode.parallax)),
            SliverToBoxAdapter(
                child: AnimatedOpacity(
                    opacity: isActiveFilter ? 1 : 0,
                    duration: const Duration(milliseconds: 500),
                    child: AnimatedContainer(
                        duration: const Duration(milliseconds: 700),
                        height: isActiveFilter ? size.height * 0.1 : 0,
                        padding:
                            EdgeInsets.symmetric(horizontal: size.width * 0.05),
                        alignment: Alignment.centerLeft,
                        child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              DropMenuPokemon(
                                  filledColor: Colors.red[600]!,
                                  onSelected: (value) =>
                                      _logicDropMenu(value: value),
                                  listDropdownMenu: List.generate(
                                      GenerationPokemon.values.length,
                                      (index) => DropdownMenuEntry<
                                              GenerationPokemon>(
                                          label: GenerationPokemon
                                              .values[index].title,
                                          value:
                                              GenerationPokemon.values[index],
                                          style: ButtonStyle(
                                              shape: WidgetStateProperty.all(
                                                  RoundedRectangleBorder(
                                                      borderRadius:
                                                          BorderRadius.circular(
                                                              20)))))),
                                  initialSelection: context
                                      .read<FilterPokemonsCubit>()
                                      .state
                                      .generationPokemon,
                                  backgroundMenuStyle: Colors.red[200]!,
                                  size: size,
                                  icon: Icons.catching_pokemon,
                                  isDarkMode: isDarkMode),
                              DropMenuPokemon(
                                  filledColor: mapTypes[currentMapKey]!,
                                  onSelected: (value) =>
                                      _onSelectionFilterTypePokemon(
                                          value: value),
                                  listDropdownMenu:
                                      _generateListMapTypePokemon(),
                                  initialSelection: currentMapKey,
                                  backgroundMenuStyle: mapTypes[currentMapKey]!,
                                  size: size,
                                  icon: Icons.list,
                                  isDarkMode: isDarkMode)
                            ])))),
            SliverPadding(
                padding: EdgeInsets.only(
                    top: MediaQuery.sizeOf(context).height * 0.01,
                    bottom: MediaQuery.sizeOf(context).height * 0.15,
                    left: MediaQuery.sizeOf(context).width * 0.05,
                    right: MediaQuery.sizeOf(context).width * 0.05),
                sliver: listPokemon.isEmpty
                    ? SliverFillRemaining(
                        hasScrollBody: false,
                        fillOverscroll: false,
                        child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              const Text("No Pokemon found.",
                                  style: TextStyle(
                                      fontSize: 20, letterSpacing: 1)),
                              SizedBox(height: size.height * 0.1),
                              Image.asset("assets/pokemon/charizarGf.gif")
                            ]))
                    : SliverGrid.builder(
                        addRepaintBoundaries: true,
                        gridDelegate:
                            const SliverGridDelegateWithFixedCrossAxisCount(
                                crossAxisCount: 2,
                                mainAxisSpacing: 10,
                                crossAxisSpacing: 10.0,
                                childAspectRatio: 1),
                        itemCount: listPokemon.length,
                        itemBuilder: (context, index) =>
                            PokemonCardWidget(pokemon: listPokemon[index])))
          ],
        )),
        if (state.isChangeDataOnePokemon)
          Positioned.fill(
              child: Container(
                  color: Colors.black.withOpacity(0.6),
                  child: Center(
                      child: Image.asset("assets/pokeball/pokeballLoad.gif",
                          width: size.width * .3,
                          height: size.height * 0.3,
                          fit: BoxFit.contain,
                          filterQuality: FilterQuality.high))))
      ]);
    });
  }
}
