import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:pokeapi/domain/blocs/dataPokemon/data_pokemon_bloc.dart';
import 'package:pokeapi/presentation/widgets/pokemon_widget.dart';

class GridPokemonsScreen extends StatelessWidget {
  const GridPokemonsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.sizeOf(context);
    return BlocBuilder<DataPokemonBloc, DataPokemonState>(
      builder: (context, state) {
        return Stack(
          children: [
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
                            "Una app que utiliza la PokéAPI para buscar y ver información detallada de Pokémon, como sus tipos, habilidades y estadísticas, con una interfaz sencilla e intuitiva.",
                            style: TextStyle(letterSpacing: 1, fontSize: 11),
                          ),
                          collapseMode: CollapseMode.parallax,
                        ))),
                SliverAppBar(
                  expandedHeight: 70.0, // Altura cuando está expandido
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
                          color: Colors.grey[300],
                          borderRadius: BorderRadius.circular(30.0)),
                      child: TextField(
                        onChanged: (value) {},
                        decoration: const InputDecoration(
                          hintText: 'Search Pokémon...',
                          border: InputBorder.none,
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
                    sliver: SliverGrid.builder(
                      addRepaintBoundaries: true,
                      gridDelegate:
                          const SliverGridDelegateWithFixedCrossAxisCount(
                              crossAxisCount: 2,
                              mainAxisSpacing: 10,
                              crossAxisSpacing: 10.0,
                              childAspectRatio: 1),
                      itemCount: state.listPokemons.length,
                      itemBuilder: (context, index) {
                        return PokemonCardWidget(
                            pokemon: state.listPokemons[index]);
                      },
                    )),
              ],
            )),
            if (state.isChangeDataOnePokemon)
              Positioned.fill(
                  child: Container(
                color: Colors.black.withOpacity(0.6),
                child: Center(
                  child: Image.asset(
                    "assets/pokeball/pokeballLoad.gif",
                    width: size.width * .3,
                    height: size.height * 0.3,
                    fit: BoxFit.contain,
                    filterQuality: FilterQuality.high,
                  ),
                ),
              ))
          ],
        );
      },
    );
  }
}
