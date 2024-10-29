import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter/material.dart';
import 'package:pokeapi/domain/blocs/dataItems/data_item_bloc.dart';
import 'package:pokeapi/domain/blocs/dataPokemon/data_pokemon_bloc.dart';
import 'package:pokeapi/domain/cubit/changeMode/change_mode_cubit.dart';
import 'package:pokeapi/domain/cubit/connectivity/connectivity_cubit.dart';
import 'package:pokeapi/domain/cubit/expandFilters/expand_filter_cubit.dart';
import 'package:pokeapi/domain/cubit/filterItems/filter_items_cubit.dart';

import 'package:pokeapi/presentation/route/route.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  SystemChrome.setPreferredOrientations(
      [DeviceOrientation.portraitUp, DeviceOrientation.portraitDown]).then((_) {
    runApp(const MyApp());
  });
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
          BlocProvider(create: (context) => FilterItemsCubit()),
          BlocProvider(create: (context) => ExpandFilterCubit()),
          BlocProvider(create: (context) => ChangeModeCubit())
        ],
        child: BlocBuilder<ChangeModeCubit, ChangeModeState>(
          builder: (context, state) {
            return MaterialApp.router(
              title: 'Poke api',
              darkTheme: ThemeData(
                  useMaterial3: true,
                  scaffoldBackgroundColor: Colors.black,
                  brightness: Brightness.dark,
                  appBarTheme: const AppBarTheme(
                      color: Colors.black,
                      elevation: 0,
                      scrolledUnderElevation: 20,
                      foregroundColor: Colors.white,
                      systemOverlayStyle: SystemUiOverlayStyle(
                          systemNavigationBarContrastEnforced: true),
                      shadowColor: Colors.black,
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.only(
                              bottomLeft: Radius.circular(20),
                              bottomRight: Radius.circular(20)))),
                  fontFamily: 'Pokemon_Solid'),
              themeMode: state.isDarkMode ? ThemeMode.dark : ThemeMode.light,
              theme: ThemeData(
                  useMaterial3: true,
                  scaffoldBackgroundColor: Colors.white,
                  brightness: Brightness.light,
                  appBarTheme: const AppBarTheme(
                      color: Colors.white,
                      surfaceTintColor: Colors.red,
                      elevation: 0,
                      scrolledUnderElevation: 20,
                      foregroundColor: Colors.black,
                      systemOverlayStyle: SystemUiOverlayStyle(
                          systemNavigationBarContrastEnforced: true),
                      shadowColor: Colors.black,
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.only(
                              bottomLeft: Radius.circular(20),
                              bottomRight: Radius.circular(20)))),
                  fontFamily: 'Pokemon_Solid'),
              routerConfig: router,
            );
          },
        ));
  }
}
