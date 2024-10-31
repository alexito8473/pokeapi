import 'package:animated_notch_bottom_bar/animated_notch_bottom_bar/animated_notch_bottom_bar.dart';
import 'package:awesome_snackbar_content/awesome_snackbar_content.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:pokeapi/domain/blocs/dataItems/data_item_bloc.dart';
import 'package:pokeapi/domain/blocs/dataPokemon/data_pokemon_bloc.dart';
import 'package:pokeapi/domain/cubit/changeMode/change_mode_cubit.dart';
import 'package:pokeapi/domain/cubit/expandFilters/expand_filter_cubit.dart';

class HomeScreen extends StatelessWidget {
  final Function changeView;
  final Widget view;
  final int currentIndex;
  final NotchBottomBarController controller;
  const HomeScreen(
      {super.key,
      required this.changeView,
      required this.view,
      required this.currentIndex,
      required this.controller});

  Color colorControllerAppBar() => controller.index == 0
      ? Colors.red
      : controller.index == 1
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
                      contentType: ContentType.failure),
                );
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
                    contentType: ContentType.failure,
                  ),
                );
                ScaffoldMessenger.of(context)
                  ..hideCurrentSnackBar()
                  ..showSnackBar(snackBar);
              } else if(state.isCorrectDataOnePokemon){
              }
            },
          )
        ],
        child: Scaffold(
            appBar: AppBar(
                surfaceTintColor: colorControllerAppBar(),
                automaticallyImplyLeading: false,
                actions: [
                  if (controller.index == 1)
                    IconButton(
                        onPressed: () => context
                            .read<ExpandFilterCubit>()
                            .changeExpandedFilter(),
                        icon: Icon(context
                            .watch<ExpandFilterCubit>()
                            .state
                            .getIcon())),
                  IconButton(
                      onPressed: () =>
                          context.read<ChangeModeCubit>().changeMode(),
                      icon: context.watch<ChangeModeCubit>().state.isDarkMode
                          ? const Icon(Icons.dark_mode)
                          : const Icon(Icons.light_mode)),
                ],
                toolbarHeight: 70,
                title: const Text("Poke Api",
                    style: TextStyle(fontSize: 26, letterSpacing: 3))),
            extendBody: true,
            bottomNavigationBar: AnimatedNotchBottomBar(
                color: Theme.of(context).brightness == Brightness.dark
                    ? Colors.grey[900]!
                    : Colors.grey[300]!,
                notchColor: Theme.of(context).brightness == Brightness.dark
                    ? Colors.grey[900]!
                    : Colors.grey[300]!,
                notchBottomBarController: controller,
                bottomBarItems: const [
                  BottomBarItem(
                      inActiveItem:
                          Icon(Icons.catching_pokemon, color: Colors.blueGrey),
                      activeItem: Icon(Icons.catching_pokemon_rounded,
                          color: Colors.red),
                      itemLabel: 'Pokemons'),
                  BottomBarItem(
                      inActiveItem:
                          Icon(Icons.backpack_outlined, color: Colors.blueGrey),
                      activeItem: Icon(Icons.backpack, color: Colors.blue),
                      itemLabel: 'Objects'),
                  BottomBarItem(
                      inActiveItem: Icon(Icons.calculate_outlined,
                          color: Colors.blueGrey),
                      activeItem: Icon(Icons.calculate, color: Colors.green),
                      itemLabel: 'Calculator'),
                ],
                onTap: (value) => changeView(value),
                kIconSize: 20,
                kBottomRadius: 35),
            body: view));
  }
}
