import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:pokeapi/data/model/type_pokemon.dart';
import 'package:pokeapi/domain/blocs/dataPokemon/data_pokemon_bloc.dart';
import 'package:pokeapi/presentation/widgets/pokemon_widget.dart';

class GridPokemonsScreen extends StatelessWidget {
  const GridPokemonsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return  BlocBuilder<DataPokemonBloc, DataPokemonState>(
      builder: (context, state) {
        return GridView.builder(
          padding: EdgeInsets.symmetric(
              horizontal: 10,
              vertical: MediaQuery.sizeOf(context).height * 0.1),
          gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
            mainAxisSpacing: 10,
              crossAxisCount: 3, crossAxisSpacing: 10.0, childAspectRatio: 0.7),
          itemCount: state.listPokemons.length,
          itemBuilder: (context, index) {
            return PokemonWidget(pokemon: state.listPokemons[index]);
          },
        );
      },
    );
  }
}
