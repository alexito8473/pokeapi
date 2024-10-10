import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:pokeapi/data/model/pokemon.dart';
import 'package:pokeapi/data/model/type_pokemon.dart';

class PokemonWidget extends StatelessWidget {
  final Pokemon pokemon;
  const PokemonWidget({super.key, required this.pokemon});

  Widget listWidgetTypePokemon() {
    return pokemon.listType == null || pokemon.listType!.isEmpty
        ? const SizedBox()
        : Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: List.generate(
              pokemon.listType!.length,
              (index) {
                return Image.asset(
                  pokemon.listType![index].urlImage,
                  width: 30,
                );
              },
            ),
          );
  }

  BoxDecoration _boxDecoration() {
    return pokemon.listType == null || pokemon.listType!.isEmpty
        ? BoxDecoration(
            color: Colors.grey[200], borderRadius: BorderRadius.circular(10))
        : pokemon.listType!.length == 1
            ? BoxDecoration(
                color: pokemon.listType![0].color.withOpacity(0.3),
                borderRadius: BorderRadius.circular(10))
            : BoxDecoration(
                gradient: LinearGradient(
                    colors: List.generate(
                        pokemon.listType!.length,
                        (index) =>
                            pokemon.listType![index].color.withOpacity(0.3))),
                borderRadius: BorderRadius.circular(10));
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: _boxDecoration(),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        children: <Widget>[
          CachedNetworkImage(
            imageUrl: pokemon.spriteFront!,
            progressIndicatorBuilder: (context, url, downloadProgress) =>
                SizedBox(
                    width: 95,
                    child: Image.asset("assets/pokeball/pokeball.gif",
                        width: 100)),
            errorWidget: (context, url, error) => const Icon(Icons.error),
          ),
          Padding(
              padding: EdgeInsets.symmetric(
                  vertical: MediaQuery.sizeOf(context).height * 0.01),
              child: Text(
                  pokemon.name.substring(0, 1).toUpperCase() +
                      pokemon.name.substring(1, pokemon.name.length),
                  style: const TextStyle(fontSize: 15,))),
          listWidgetTypePokemon()
        ],
      ),
    );
  }
}
