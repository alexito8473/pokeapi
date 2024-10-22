import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:pokeapi/data/model/pokemon.dart';
import 'package:pokeapi/presentation/pages/home_page.dart';
import 'package:pokeapi/presentation/pages/splash_screens_page.dart';
import 'package:pokeapi/presentation/screens/pokemon_screen.dart';

final GoRouter router = GoRouter(routes: <RouteBase>[
  GoRoute(
      path: '/',
      builder: (BuildContext context, GoRouterState state) {
        return const SplashScreensPage();
      },
      routes: [
        GoRoute(
            path: '/home',
            builder: (context, state) => const HomePage(),
            routes: [
              GoRoute(
                path: "/DataPokemon",
                builder: (context, state) {
                  return PokemonScreen(pokemon: state.extra as Pokemon);
                },
              )
            ])
      ])
]);
