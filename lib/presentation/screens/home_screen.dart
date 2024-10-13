import 'package:animated_notch_bottom_bar/animated_notch_bottom_bar/animated_notch_bottom_bar.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

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
    return Scaffold(
        appBar: AppBar(
            actions: [
              IconButton(onPressed: () {}, icon: const Icon(Icons.settings))
            ],
            automaticallyImplyLeading: false,
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
                  activeItem:
                      Icon(Icons.catching_pokemon_rounded, color: Colors.red),
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
        body: view);
  }
}
