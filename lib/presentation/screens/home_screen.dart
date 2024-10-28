import 'package:animated_notch_bottom_bar/animated_notch_bottom_bar/animated_notch_bottom_bar.dart';
import 'package:awesome_snackbar_content/awesome_snackbar_content.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:pokeapi/domain/blocs/dataItems/data_item_bloc.dart';
import 'package:pokeapi/domain/blocs/dataPokemon/data_pokemon_bloc.dart';
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
  @override
  Widget build(BuildContext context) {
    return MultiBlocListener(
        listeners: [
          BlocListener<DataItemBloc,DataItemState>(listener: (context, state) {
            if (state.isErrorObtainData) {
              const snackBar = SnackBar(
                elevation: 0,
                behavior: SnackBarBehavior.floating,
                backgroundColor: Colors.transparent,
                content: AwesomeSnackbarContent(
                  title: 'Error obtain list items',
                  message:
                  '',
                  contentType: ContentType.failure,
                ),
              );
              ScaffoldMessenger.of(context)
                ..hideCurrentSnackBar()
                ..showSnackBar(snackBar);
            }
          },),
          BlocListener<DataPokemonBloc, DataPokemonState>(
            listener: (context, state) {
              if (state.isErrorObtainData) {
                const snackBar = SnackBar(
                  elevation: 0,
                  behavior: SnackBarBehavior.floating,
                  backgroundColor: Colors.transparent,
                  content: AwesomeSnackbarContent(
                    title: 'On Snap!',
                    message:
                        'This is an example error message that will be shown in the body of snackbar!',
                    contentType: ContentType.failure,
                  ),
                );
                ScaffoldMessenger.of(context)
                  ..hideCurrentSnackBar()
                  ..showSnackBar(snackBar);
              }
            },
          )
        ],
        child: Scaffold(
            appBar: AppBar(
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
                  IconButton(onPressed: () {}, icon: const Icon(Icons.settings))
                ],
                toolbarHeight: 70,
                title: const Text("Poke Api",
                    style: TextStyle(fontSize: 26, letterSpacing: 3))),
            extendBody: true,
            bottomNavigationBar: AnimatedNotchBottomBar(
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
                      inActiveItem: Icon(Icons.movie_creation_outlined,
                          color: Colors.blueGrey),
                      activeItem: Icon(Icons.movie, color: Colors.green),
                      itemLabel: 'Movie'),
                ],
                onTap: (value) => changeView(value),
                kIconSize: 20,
                kBottomRadius: 35),
            body: view));
  }
}
