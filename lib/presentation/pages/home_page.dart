import 'package:animated_notch_bottom_bar/animated_notch_bottom_bar/animated_notch_bottom_bar.dart';
import 'package:flutter/material.dart';
import 'package:pokeapi/presentation/screens/grid_pokemons_screen.dart';
import 'package:pokeapi/presentation/screens/home_screen.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  late List<Widget> _listWidget;
  late Widget _view;
  late NotchBottomBarController _controller;
  int position = 0;
  @override
  void initState() {
    _listWidget = [
      const GridPokemonsScreen(),
      Container(color: Colors.blue),
      Container(color: Colors.green),
    ];
    _view = _listWidget[position];
    _controller = NotchBottomBarController(index: position);
    super.initState();
  }

  void _changeView(int value) {
    if (position == value) return;
    setState(() {
      position = value;
      _view = _listWidget[position];
    });
  }

  @override
  Widget build(BuildContext context) {
    return PopScope(
        canPop: false,
        child: HomeScreen(
          changeView: _changeView,
          view: _view,
          currentIndex: position,
          controller: _controller,
        ));
  }
}
