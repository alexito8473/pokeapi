import 'package:auto_size_text/auto_size_text.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:pokeapi/data/model/pokemon.dart';
import 'package:pokeapi/domain/cubit/changeMode/change_mode_cubit.dart';
import 'package:pokeapi/presentation/widgets/pokemon_widget.dart';

class PokemonScreen extends StatefulWidget {
  final Pokemon pokemon;
  const PokemonScreen({super.key, required this.pokemon});

  @override
  State<PokemonScreen> createState() => _PokemonScreenState();
}

class _PokemonScreenState extends State<PokemonScreen>
    with SingleTickerProviderStateMixin {
  late final TabController _controller;
  late final List<Widget> listWidget;
  @override
  void initState() {
    _controller = TabController(length: 3, vsync: this);
    listWidget = [
      AboutMePokemon(pokemon: widget.pokemon),
      StatsPokemon(pokemon: widget.pokemon),
      MovePokemon(pokemon: widget.pokemon)
    ];
    super.initState();
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.sizeOf(context);
    return SizedBox(
        width: size.width,
        height: size.height,
        child: Container(
            width: size.width,
            height: size.height,
            decoration: BoxDecoration(
                gradient: LinearGradient(
                    begin: Alignment.topCenter,
                    end: Alignment.center,
                    colors: [
                      widget.pokemon.listType![0].color,
                      context.watch<ChangeModeCubit>().state.isDarkMode
                          ? Colors.black
                          : Colors.white
                    ])),
            child: Scaffold(
                backgroundColor: Colors.transparent,
                appBar: AppBar(
                    backgroundColor: Colors.transparent,
                    title: AutoSizeText(
                        (widget.pokemon.name
                            .substring(0, 1)
                            .toUpperCase() +
                            widget.pokemon.name.substring(1)).replaceAll("-", " "),
                        maxLines: 1,
                        style: const TextStyle(
                            letterSpacing: 2, fontSize: 25),
                   )),
                body: SizedBox(
                    width: size.width,
                    height: size.height,
                    child: Column(children: [
                      SizedBox(
                        width: size.width,
                        height: size.height * 0.35,
                        child: CarouselView(
                            itemSnapping: true,
                            backgroundColor: Colors.transparent,
                            itemExtent: size.width,
                            children: List.generate(
                                widget.pokemon.sprites.length,
                                    (index) => Hero(
                                    tag: widget.pokemon.sprites[index],
                                    child: CachedNetworkImage(
                                      imageUrl: widget.pokemon.sprites[index],
                                      width: size.width * 0.4,
                                      height: size.width * 0.4,
                                      filterQuality: FilterQuality.high,
                                      fit: BoxFit.contain,
                                      progressIndicatorBuilder:
                                          (context, url, downloadProgress) =>
                                          SizedBox(
                                              width: 95,
                                              child: Image.asset(
                                                "assets/pokeball/pokeball.gif",
                                                width: size.width * 0.1,
                                                height: size.width * 0.1,
                                                fit: BoxFit.contain,
                                                filterQuality:
                                                FilterQuality.high,
                                              )),
                                      errorWidget: (context, url, error) =>
                                      const Icon(Icons.error),
                                    )))),
                      ),
                      SizedBox(
                          width: size.width,
                          height: size.height * 0.1,
                          child: TabBar(
                              controller: _controller,
                              labelColor: widget.pokemon.listType![0].color,
                              dividerColor: Colors.transparent,
                              automaticIndicatorColorAdjustment: false,
                              enableFeedback: false,
                              indicatorColor: Colors.transparent,
                              tabs: const [
                                Tab(text: 'About me'),
                                Tab(text: 'Stats'),
                                Tab(text: 'Move')
                              ])),
                      Expanded(
                          child: TabBarView(
                              controller: _controller, children: listWidget))
                    ])))));
  }
}
