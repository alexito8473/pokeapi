import 'dart:io';

import 'package:animated_notch_bottom_bar/animated_notch_bottom_bar/animated_notch_bottom_bar.dart';
import 'package:awesome_snackbar_content/awesome_snackbar_content.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:pokeapi/domain/blocs/dataItems/data_item_bloc.dart';
import 'package:pokeapi/domain/blocs/dataPokemon/data_pokemon_bloc.dart';
import 'package:pokeapi/domain/cubit/changeMode/change_mode_cubit.dart';
import 'package:pokeapi/domain/cubit/expandFilters/expand_filter_cubit.dart';
import 'package:pokeapi/presentation/screens/calculator_screen.dart';
import 'package:pokeapi/presentation/screens/grid_pokemons_screen.dart';
import 'package:pokeapi/presentation/screens/grid_items_screen.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  double positionAnimation = 0;
  int position = 0;
  late final NotchBottomBarController _controller =
      NotchBottomBarController(index: position);
  late ScrollController scrollControllerPokemonScreen = ScrollController();
  late ScrollController scrollControllerItemScreen = ScrollController();
  late ScrollController scrollControllerCalculatorScreen = ScrollController();
  late List<GlobalKey> listKeysMoveToUp = [
    GlobalKey(),
    GlobalKey(),
    GlobalKey()
  ];
  late final List<Widget> _listWidget = [
    GridPokemonsScreen(
        scrollControllerPokemonScreen: scrollControllerPokemonScreen,
        globalKey: listKeysMoveToUp[0]),
    GridItemsScreen(
        scrollController: scrollControllerItemScreen,
        globalKey: listKeysMoveToUp[1]),
    CalculatorScreen(
        scrollController: scrollControllerCalculatorScreen,
        globalKey: listKeysMoveToUp[2])
  ];

  @override
  void initState() {
    scrollControllerPokemonScreen.addListener(() => moveScroll);
    scrollControllerItemScreen.addListener(() => moveScroll);
    scrollControllerCalculatorScreen.addListener(() => moveScroll);
    super.initState();
    Future.delayed(const Duration(milliseconds: 800),
        () => setState(() => positionAnimation = -2));
  }

  @override
  void dispose() {
    scrollControllerPokemonScreen.removeListener(() => moveScroll);
    scrollControllerItemScreen.removeListener(() => moveScroll);
    scrollControllerCalculatorScreen.removeListener(() => moveScroll);
    scrollControllerPokemonScreen.dispose();
    super.dispose();
  }

  void moveScroll(GlobalKey globalKey) {
    Scrollable.ensureVisible(
      globalKey.currentContext!,
      duration: const Duration(milliseconds: 500),
      curve: Curves.linear,
    );
  }

  void _changeView(int value) {
    if (position == value) {
      moveScroll(listKeysMoveToUp[value]);
    } else {
      setState(() => position = value);
    }
  }

  Color colorControllerAppBar() => _controller.index == 0
      ? Colors.red
      : _controller.index == 1
          ? Colors.blue
          : Colors.green;

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.sizeOf(context);
    return MultiBlocListener(
        listeners: [
          BlocListener<DataItemBloc, DataItemState>(
            listener: (context, state) {
              if (state.isErrorObtainData) {
                TextStyle textStyle = TextStyle(
                    color: Theme.of(context).brightness == Brightness.dark
                        ? Colors.white
                        : Colors.black);
                var snackBar = SnackBar(
                    elevation: 0,
                    behavior: SnackBarBehavior.floating,
                    backgroundColor: Colors.transparent,
                    content: AwesomeSnackbarContent(
                        color: Colors.red,
                        titleTextStyle: textStyle,
                        messageTextStyle: textStyle,
                        title: 'Error obtain list items',
                        message: 'Could not get item data',
                        contentType: ContentType.failure));
                ScaffoldMessenger.of(context)
                  ..hideCurrentSnackBar()
                  ..showSnackBar(snackBar);
              }
            },
          ),
          BlocListener<DataPokemonBloc, DataPokemonState>(
            listener: (context, state) {
              if (state.isErrorObtainData) {
                TextStyle textStyle = TextStyle(
                    color: Theme.of(context).brightness == Brightness.dark
                        ? Colors.white
                        : Colors.black);
                var snackBar = SnackBar(
                    elevation: 0,
                    behavior: SnackBarBehavior.floating,
                    backgroundColor: Colors.transparent,
                    content: AwesomeSnackbarContent(
                        color: Colors.red,
                        titleTextStyle: textStyle,
                        messageTextStyle: textStyle,
                        title: 'Error',
                        message: 'Could not get pokemon data',
                        contentType: ContentType.failure));
                ScaffoldMessenger.of(context)
                  ..hideCurrentSnackBar()
                  ..showSnackBar(snackBar);
              }
            },
          )
        ],
        child: PopScope(
            canPop: false,
            child: Stack(children: [
              Positioned.fill(
                  child: Scaffold(
                      appBar: AppBar(
                          surfaceTintColor: colorControllerAppBar(),
                          automaticallyImplyLeading: false,
                          actions: [
                            if (_controller.index == 1)
                              IconButton(
                                  onPressed: () => context
                                      .read<ExpandFilterCubit>()
                                      .changeExpandedFilter(),
                                  icon: Icon(context
                                      .watch<ExpandFilterCubit>()
                                      .state
                                      .getIcon())),
                            IconButton(
                                onPressed: () => context
                                    .read<ChangeModeCubit>()
                                    .changeMode(),
                                icon: context
                                        .watch<ChangeModeCubit>()
                                        .state
                                        .isDarkMode
                                    ? const Icon(Icons.dark_mode)
                                    : const Icon(Icons.light_mode)),
                          ],
                          toolbarHeight: 70,
                          title: const Text("Poke Api",
                              style:
                                  TextStyle(fontSize: 26, letterSpacing: 3))),
                      extendBody: true,
                      bottomNavigationBar: AnimatedNotchBottomBar(
                          color: Theme.of(context).brightness == Brightness.dark
                              ? Colors.grey[900]!
                              : Colors.grey[300]!,
                          notchColor:
                              Theme.of(context).brightness == Brightness.dark
                                  ? Colors.grey[900]!
                                  : Colors.grey[300]!,
                          notchBottomBarController: _controller,
                          bottomBarItems: const [
                            BottomBarItem(
                                inActiveItem: Icon(Icons.catching_pokemon,
                                    color: Colors.blueGrey),
                                activeItem: Icon(Icons.catching_pokemon_rounded,
                                    color: Colors.red),
                                itemLabel: 'Pokemons'),
                            BottomBarItem(
                                inActiveItem: Icon(Icons.backpack_outlined,
                                    color: Colors.blueGrey),
                                activeItem:
                                    Icon(Icons.backpack, color: Colors.blue),
                                itemLabel: 'Objects'),
                            BottomBarItem(
                                inActiveItem: Icon(Icons.calculate_outlined,
                                    color: Colors.blueGrey),
                                activeItem:
                                    Icon(Icons.calculate, color: Colors.green),
                                itemLabel: 'Calculator'),
                          ],
                          onTap: (value) => _changeView(value),
                          kIconSize: 20,
                          kBottomRadius: 35),
                      body: IndexedStack(
                          index: position, children: _listWidget))),
              AnimatedPositioned(
                  duration: const Duration(seconds: 1),
                  bottom: size.height * 0.6 * positionAnimation,
                  left: 0,
                  curve: Curves.easeIn,
                  child: Image.asset("assets/pokeball/pokeballBottom.png",
                      fit: BoxFit.fill,
                      width: size.width,
                      height: size.height * 0.6)),
              AnimatedPositioned(
                  top: size.height * 0.8 * positionAnimation,
                  curve: Curves.easeIn,
                  duration: const Duration(seconds: 1),
                  child: Image.asset("assets/pokeball/pokeballTop.png",
                      fit: BoxFit.contain, width: size.width))
            ])));
  }
}
