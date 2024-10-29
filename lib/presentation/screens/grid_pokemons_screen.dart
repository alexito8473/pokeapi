import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:pokeapi/data/model/pokemon.dart';
import 'package:pokeapi/domain/blocs/dataPokemon/data_pokemon_bloc.dart';
import 'package:pokeapi/presentation/widgets/pokemon_widget.dart';

class GridPokemonsScreen extends StatefulWidget {
  const GridPokemonsScreen({super.key});

  @override
  State<GridPokemonsScreen> createState() => _GridPokemonsScreenState();
}

class _GridPokemonsScreenState extends State<GridPokemonsScreen> {
  final TextEditingController _controller = TextEditingController();
  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.sizeOf(context);
    return BlocBuilder<DataPokemonBloc, DataPokemonState>(
        builder: (context, state) {
      List<Pokemon> listPokemon = state.listPokemons
          .where((element) => element.name.contains(_controller.value.text))
          .toList();
      return Stack(children: [
        Positioned.fill(
            child: CustomScrollView(
          slivers: [
            SliverPadding(
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
                  alignment: Alignment.center,
                  margin: const EdgeInsets.only(
                      top: 10, bottom: 10, left: 10, right: 10),
                  padding: const EdgeInsets.symmetric(horizontal: 10.0),
                  decoration: BoxDecoration(
                      color: Theme.of(context).brightness==Brightness.dark?Colors.grey[800]: Colors.grey[200],
                      borderRadius: BorderRadius.circular(30.0)),
                  child: TextField(
                    controller: _controller,
                    onChanged: (value) {
                      setState(() {
                        _controller.text = value;
                      });
                    },
                    decoration: const InputDecoration(
                      hintText: 'Search Pokémon...',
                      border: InputBorder.none,
                      focusColor: Colors.black,
                      hoverColor: Colors.black,

                      icon: Icon(Icons.search, color: Colors.blueAccent),
                    ),
                  ),
                ),
                collapseMode: CollapseMode.parallax,
              ),
            ),
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
                            const Text(
                              "No Pokemon found.",
                              style: TextStyle(fontSize: 20, letterSpacing: 1),
                            ),
                            SizedBox(
                              height: size.height * 0.1,
                            ),
                            Image.asset("assets/pokemon/charizarG"
                                "f.gif")
                          ],
                        ),
                      )
                    : SliverGrid.builder(
                        addRepaintBoundaries: true,
                        gridDelegate:
                            const SliverGridDelegateWithFixedCrossAxisCount(
                                crossAxisCount: 2,
                                mainAxisSpacing: 10,
                                crossAxisSpacing: 10.0,
                                childAspectRatio: 1),
                        itemCount: listPokemon.length,
                        itemBuilder: (context, index) {
                          return PokemonCardWidget(pokemon: listPokemon[index]);
                        }))
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
                        filterQuality: FilterQuality.high),
                  )))
      ]);
    });
  }
}
