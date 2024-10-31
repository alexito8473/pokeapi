import 'package:animated_notch_bottom_bar/animated_notch_bottom_bar/animated_notch_bottom_bar.dart';
import 'package:flutter/material.dart';
import 'package:pokeapi/presentation/screens/calculator_screen.dart';
import 'package:pokeapi/presentation/screens/grid_pokemons_screen.dart';
import 'package:pokeapi/presentation/screens/home_screen.dart';
import 'package:pokeapi/presentation/screens/grid_items_screen.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  late List<Widget> _listWidget;
  late NotchBottomBarController _controller;
  double positionAnimation = 0;
  int position = 0;
  @override
  void initState() {
    _listWidget = [
      const GridPokemonsScreen(),
      const GridItemsScreen(),
      const CalculatorScreen(),
    ];
    _controller = NotchBottomBarController(index: position);
    super.initState();
    Future.delayed(const Duration(milliseconds: 600), () {
      setState(() {
        positionAnimation = -2;
      });
    });
  }

  void _changeView(int value) {
    if (position == value) return;
    setState(() {
      position = value;
    });
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.sizeOf(context);
    return PopScope(
        canPop: false,
        child: Stack(children: [
          Positioned.fill(
              child: HomeScreen(
                  changeView: _changeView,
                 // view: IndexedStack(index: position, children: _listWidget),
                  view: _listWidget[0],
                  currentIndex: position,
                  controller: _controller)),
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
        ]));
  }
}
