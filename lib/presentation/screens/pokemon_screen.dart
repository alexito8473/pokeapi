import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:pokeapi/data/model/pokemon.dart';

class PokemonScreen extends StatefulWidget {
  final Pokemon pokemon;
  const PokemonScreen({super.key, required this.pokemon});

  @override
  State<PokemonScreen> createState() => _PokemonScreenState();
}

class _PokemonScreenState extends State<PokemonScreen>
    with SingleTickerProviderStateMixin {
  late final TabController _controller;
  @override
  void initState() {
    _controller = TabController(length: 2, vsync: this);
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
    return Container(
        width: size.width,
        height: size.height,
        color: Colors.white,
        child: Container(
            width: size.width,
            height: size.height,
            decoration: BoxDecoration(
                gradient: LinearGradient(
                    begin: Alignment.topCenter,
                    end: Alignment.center,
                    stops: const [
                  0,
                  0.3,
                  1
                ],
                    colors: [
                  widget.pokemon.listType![0].color,
                  widget.pokemon.listType![0].color.withOpacity(0.8),
                  Colors.white
                ])),
            child: Scaffold(
                backgroundColor: Colors.transparent,
                appBar: AppBar(
                  backgroundColor: Colors.transparent,
                ),
                body: SizedBox(
                    width: size.width,
                    height: size.height,
                    child: Column(children: [
                      SizedBox(
                        width: size.width,
                        height: size.height * 0.4,
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
                            labelColor: Colors.blueGrey,
                            dividerColor: Colors.transparent,
                            automaticIndicatorColorAdjustment: false,
                            enableFeedback: false,

                            indicatorColor: Colors.transparent,
                            tabs: const [
                              Tab(text: 'Sobre mi'),
                              Tab(text: 'Tab 2'),
                            ]),
                      ),
                      Expanded(
                          child: TabBarView(controller: _controller, children: [
                            _AboutMePokemon(pokemon: widget.pokemon,),
                        Container(
                          color: Colors.blue,
                        )
                      ]))
                    ])))));
  }
}

class _AboutMePokemon extends StatelessWidget {
  final Pokemon pokemon;
  const _AboutMePokemon({super.key, required this.pokemon});

  @override
  Widget build(BuildContext context) {
    return  Column(
        children: [
          Text(pokemon.weight.toString())
        ],
      );
  }
}

