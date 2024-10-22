
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter/material.dart';
import 'package:pokeapi/domain/blocs/dataItems/data_item_bloc.dart';
import 'package:pokeapi/domain/blocs/dataPokemon/data_pokemon_bloc.dart';
import 'package:pokeapi/domain/cubit/connectivity/connectivity_cubit.dart';

import 'package:pokeapi/presentation/route/route.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});
  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
        providers: [
          BlocProvider(create: (context) => DataPokemonBloc()),
          BlocProvider(create: (context) => DataItemBloc()),
          BlocProvider(create: (context) => ConnectivityCubit()),
        ],
        child: MaterialApp.router(
          title: 'Poke api',
          theme: ThemeData(
            useMaterial3: true,
            scaffoldBackgroundColor: Colors.white,
            appBarTheme: AppBarTheme(
                color: Colors.white,
                surfaceTintColor: Colors.red,
                elevation: 0,
                foregroundColor: Colors.black,
                systemOverlayStyle: const SystemUiOverlayStyle(
                    systemNavigationBarContrastEnforced: true),
                shadowColor: Colors.black,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(20.0),
                )),
            fontFamily: 'Pokemon_Solid',
          ),
          routerConfig: router,
        ));
  }
}
