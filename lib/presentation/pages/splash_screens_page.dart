import 'package:animated_background/animated_background.dart';
import 'package:animated_text_kit/animated_text_kit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:pokeapi/domain/blocs/dataPokemon/data_pokemon_bloc.dart';

class SplashScreensPage extends StatefulWidget {
  const SplashScreensPage({super.key});

  @override
  State<SplashScreensPage> createState() => _SplashScreensPageState();
}

class _SplashScreensPageState extends State<SplashScreensPage>
    with TickerProviderStateMixin {
  @override
  void initState() {
     context.read<DataPokemonBloc>().add(DataPokemonEvent());
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.sizeOf(context);
    return BlocListener<DataPokemonBloc, DataPokemonState>(
        listener: (context, state) {
          if (state.listPokemons.length > 50) {

            context.go("/home");
          }
        },
        child: Scaffold(
            body: AnimatedBackground(
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
                child: Image.asset(
                  "assets/splash/loading.gif",
                  width: size.width * .6,
                ),
              ),
              Padding(
                  padding: EdgeInsets.only(
                      top: MediaQuery.sizeOf(context).height * 0.1),
                  child: Center(
                    child: AnimatedTextKit(
                      repeatForever: true,
                      animatedTexts: [
                        TypewriterAnimatedText(
                          'Cargando ...',
                          cursor: "",
                          textStyle: const TextStyle(
                            fontSize: 20.0,
                            fontWeight: FontWeight.bold,
                          ),
                          speed: const Duration(milliseconds: 200),
                        ),
                        TypewriterAnimatedText(
                          'Conectándose a la api ...',
                          cursor: "",
                          textStyle: const TextStyle(
                            fontSize: 20.0,
                            fontWeight: FontWeight.bold,
                          ),
                          speed: const Duration(milliseconds: 200),
                        ),
                        TypewriterAnimatedText(
                          'Obteniendo datos ...',
                          cursor: "",
                          textStyle: const TextStyle(
                            fontSize: 20.0,
                            fontWeight: FontWeight.bold,
                          ),
                          speed: const Duration(milliseconds: 200),
                        ),
                      ],
                      pause: const Duration(milliseconds: 100),
                      displayFullTextOnTap: false,
                      stopPauseOnTap: false,
                    ),
                  ))
            ],
          )),
        )));
  }
}
