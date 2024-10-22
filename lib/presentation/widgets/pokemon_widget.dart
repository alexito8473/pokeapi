import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:pokeapi/data/model/pokemon.dart';
import 'package:pokeapi/domain/blocs/dataPokemon/data_pokemon_bloc.dart';
import 'package:pokeapi/presentation/pages/splash_screens_page.dart';
import 'package:pokeapi/presentation/screens/pokemon_screen.dart';

class PokemonCardWidget extends StatelessWidget {
  final Pokemon pokemon;
  const PokemonCardWidget({super.key, required this.pokemon});

  Widget listWidgetTypePokemon() {
    return pokemon.listType == null || pokemon.listType!.isEmpty
        ? const SizedBox()
        : Expanded(
            child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: List.generate(
              pokemon.listType!.length,
              (index) {
                return Container(
                  decoration: const BoxDecoration(boxShadow: [
                    BoxShadow(
                        color: Colors.black12,
                        blurRadius: 1,
                        spreadRadius: 1,
                        offset: Offset(2, 2))
                  ]),
                  child: Image.asset(pokemon.listType![index].urlImageType,
                      width: 30),
                );
              },
            ),
          ));
  }

  BoxDecoration _boxDecoration() {
    return pokemon.listType == null || pokemon.listType!.isEmpty
        ? BoxDecoration(
            color: Colors.grey[200], borderRadius: BorderRadius.circular(20))
        : BoxDecoration(
            image: DecorationImage(
                fit: BoxFit.cover,
                alignment: Alignment.bottomLeft,
                filterQuality: FilterQuality.none,
                colorFilter:
                    const ColorFilter.mode(Colors.black38, BlendMode.darken),
                image: AssetImage(pokemon.listType![0].urlImageBackground)),
            boxShadow: const [
              BoxShadow(
                  offset: Offset(3, 3),
                  color: Colors.black38,
                  blurRadius: 2,
                  spreadRadius: 2)
            ],
            borderRadius: BorderRadius.circular(20));
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.sizeOf(context);
    return  GestureDetector(
        onTap: () => {
          context.read<DataPokemonBloc>().add( DataOnePokemonEvent(haveWifi: true, id: pokemon.id!, context: context))
        //  Navigator.push(context, MaterialPageRoute(builder: (context) => PokemonScreen(pokemon: pokemon),))

          // context.go("/home/DataPokemon",extra: pokemon)
        },
        child: Container(
            decoration: _boxDecoration(),
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
