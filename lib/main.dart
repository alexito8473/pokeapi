import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter/material.dart';
import 'package:pokeapi/domain/blocs/dataPokemon/data_pokemon_bloc.dart';

import 'package:pokeapi/presentation/route/route.dart';


void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
        providers: [BlocProvider(create: (context) => DataPokemonBloc())],
        child: MaterialApp.router(
          title: 'Poke api',
          theme: ThemeData(useMaterial3: true,fontFamily: "Pokemon_Solid"),
          routerConfig: router,
        ));
  }
}
