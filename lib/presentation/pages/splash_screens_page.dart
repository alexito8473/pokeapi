import 'package:animated_background/animated_background.dart';
import 'package:animated_text_kit/animated_text_kit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:pokeapi/data/model/item.dart';
import 'package:pokeapi/data/model/pokemon.dart';
import 'package:pokeapi/domain/blocs/dataItems/data_item_bloc.dart';
import 'package:pokeapi/domain/blocs/dataPokemon/data_pokemon_bloc.dart';
import 'package:pokeapi/domain/cubit/connectivity/connectivity_cubit.dart';
import 'package:pokeapi/domain/cubit/filterItems/filter_items_cubit.dart';
import 'package:pokeapi/domain/cubit/filterPokemon/filter_pokemons_cubit.dart';

class SplashScreensPage extends StatefulWidget {
  const SplashScreensPage({super.key});

  @override
  State<SplashScreensPage> createState() => _SplashScreensPageState();
}

class _SplashScreensPageState extends State<SplashScreensPage>
    with TickerProviderStateMixin {
  int positionAnimation = -1;
  @override
  void initState() {
    context.read<ConnectivityCubit>().listenConnectivity();
    super.initState();
    Future.delayed(const Duration(seconds: 3),
        () => setState(() => positionAnimation = 0));
  }

  void navigation() {
    context.go("/home");
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.sizeOf(context);

    return BlocListener<ConnectivityCubit, ConnectivityState>(
        listener: (context, state) {
          context.read<DataPokemonBloc>().add(DataAllPokemonEvent(
              haveWifi: state.haveWifi,
              generationPokemon:
                  context.read<FilterPokemonsCubit>().state.generationPokemon));
          context.read<DataItemBloc>().add(DataItemEvent(
              haveWifi: state.haveWifi,
              itemCategory:
                  context.read<FilterItemsCubit>().state.listItemCategory));
        },
        child: Scaffold(
            body: Stack(
          children: [
            Positioned.fill(
                child: AnimatedBackground(
                    behaviour: RandomParticleBehaviour(
                        options: ParticleOptions(
                            particleCount: 5,
                            spawnMaxRadius: 40,
                            spawnMinRadius: 20,
                            spawnMinSpeed: 40,
                            spawnMaxSpeed: 55,
                            maxOpacity: 0.8,
                            minOpacity: 0.3,
                            image:
                                Image.asset("assets/pokeball/pokeball.webp"))),
                    vsync: this,
                    child: SafeArea(
                        child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                          Center(
                              child: Image.asset("assets/splash/loading.gif",
                                  width: size.width * .6)),
                          Padding(
                              padding: EdgeInsets.only(
                                  top: MediaQuery.sizeOf(context).height * 0.1),
                              child: Center(
                                  child: !context
                                          .watch<ConnectivityCubit>()
                                          .state
                                          .haveWifi
                                      ? const Text(
                                          "You don't have internet connection")
                                      : AnimatedTextKit(
                                          repeatForever: true,
                                          animatedTexts: [
                                            TypewriterAnimatedText(
                                                'Charging ...',
                                                cursor: "",
                                                textStyle: const TextStyle(
                                                  fontSize: 20.0,
                                                  letterSpacing: 2,
                                                  fontWeight: FontWeight.bold,
                                                ),
                                                speed: const Duration(
                                                    milliseconds: 200)),
                                            TypewriterAnimatedText(
                                                'Connecting to the API...',
                                                cursor: "",
                                                textStyle: const TextStyle(
                                                  fontSize: 20.0,
                                                  letterSpacing: 2,
                                                  fontWeight: FontWeight.bold,
                                                ),
                                                speed: const Duration(
                                                    milliseconds: 200)),
                                            TypewriterAnimatedText(
                                                'Getting data...',
                                                cursor: "",
                                                textStyle: const TextStyle(
                                                    fontSize: 20.0,
                                                    letterSpacing: 2,
                                                    fontWeight:
                                                        FontWeight.bold),
                                                speed: const Duration(
                                                    milliseconds: 200))
                                          ],
                                          pause:
                                              const Duration(milliseconds: 100),
                                          displayFullTextOnTap: false,
                                          stopPauseOnTap: false)))
                        ])))),
            AnimatedPositioned(
                duration: const Duration(seconds: 1),
                bottom: size.height * 0.6 * positionAnimation,
                left: 0,
                onEnd: () => navigation(),
                child: Image.asset(
                  "assets/pokeball/pokeballBottom.png",
                  fit: BoxFit.fill,
                  width: size.width,
                  height: size.height * 0.6,
                )),
            AnimatedPositioned(
                top: size.height * 0.8 * positionAnimation,
                curve: Curves.easeIn,
                duration: const Duration(seconds: 1),
                child: Image.asset("assets/pokeball/pokeballTop.png",
                    fit: BoxFit.contain, width: size.width))
          ],
        )));
  }
}
