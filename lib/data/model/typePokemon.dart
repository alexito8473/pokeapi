import 'dart:ui';

import 'package:flutter/material.dart';

enum LevelResistance{
  SUPER_WEAK(title: "Super weak (4×)"),
  WEAK(title: "Weak (2×)"),
  NORMAL(title: "Normal (1×)"),
  RESISTANCE(title: "Resistance (0.5×)"),
  SUPER_RESISTANCE(title: "Super resistance (0.25×)"),
  INMUNE(title: "Inmune (0×)");
  final String title;
  const LevelResistance({required this.title});
}

enum TypePokemon {
  NORMAL(
      urlImageType: "assets/type/normal.png",
      urlImageBackground: "assets/backgroundPokemon/normal.jpg",
      color: Color.fromRGBO(159, 161, 159, 1)),
  FIGHTING(
      urlImageType: "assets/type/fighting.png",
      urlImageBackground: "assets/backgroundPokemon/fighting.jpg",
      color: Color.fromRGBO(254, 129, 0, 1)),
  FLYING(
      urlImageType: "assets/type/flying.png",
      urlImageBackground: "assets/backgroundPokemon/flying.jpg",
      color: Color.fromRGBO(128, 184, 239, 1)),
  POISON(
      urlImageType: "assets/type/poison.png",
      urlImageBackground: "assets/backgroundPokemon/poison.jpg",
      color: Color.fromRGBO(144, 65, 202, 1)),
  GROUND(
      urlImageType: "assets/type/ground.png",
      urlImageBackground: "assets/backgroundPokemon/ground.jpg",
      color: Color.fromRGBO(145, 80, 32, 1)),
  ROCK(
      urlImageType: "assets/type/rock.png",
      urlImageBackground: "assets/backgroundPokemon/rock.jpg",
      color: Color.fromRGBO(174, 168, 129, 1)),
  BUG(
      urlImageType: "assets/type/bug.png",
      urlImageBackground: "assets/backgroundPokemon/bug.jpg",
      color: Color.fromRGBO(144, 160, 25, 1)),
  GHOST(
      urlImageType: "assets/type/ghost.png",
      urlImageBackground: "assets/backgroundPokemon/ghost.jpg",
      color: Color.fromRGBO(113, 65, 113, 1)),
  STEEL(
      urlImageType: "assets/type/steel.png",
      urlImageBackground: "assets/backgroundPokemon/steel.jpg",
      color: Color.fromRGBO(97, 160, 184, 1)),
  FIRE(
      urlImageType: "assets/type/fire.png",
      urlImageBackground: "assets/backgroundPokemon/fire.jpg",
      color: Color.fromRGBO(230, 40, 41, 1)),
  WATER(
      urlImageType: "assets/type/water.png",
      urlImageBackground: "assets/backgroundPokemon/water.jpg",
      color: Color.fromRGBO(41, 128, 239, 1)),
  GRASS(
      urlImageType: "assets/type/grass.png",
      urlImageBackground: "assets/backgroundPokemon/grass.jpg",
      color: Color.fromRGBO(62, 160, 41, 1)),
  ELECTRIC(
      urlImageType: "assets/type/electric.png",
      urlImageBackground: "assets/backgroundPokemon/electric.jpg",
      color: Color.fromRGBO(250, 192, 0, 1)),
  PSYCHIC(
      urlImageType: "assets/type/pyshic.png",
      urlImageBackground: "assets/backgroundPokemon/pyshic.jpg",
      color: Color.fromRGBO(239, 64, 120, 1)),
  ICE(
      urlImageType: "assets/type/ice.png",
      urlImageBackground: "assets/backgroundPokemon/ice.jpg",
      color: Color.fromRGBO(62, 216, 254, 1)),
  DRAGON(
      urlImageType: "assets/type/dragon.png",
      urlImageBackground: "assets/backgroundPokemon/dragon.jpg",
      color: Color.fromRGBO(80, 97, 224, 1)),
  FAIRY(
      urlImageType: "assets/type/fairy.png",
      urlImageBackground: "assets/backgroundPokemon/fairy.jpg",
      color: Color.fromRGBO(238, 113, 239, 1)),
  STELLAR(
      urlImageType: "assets/type/stellar.png",
      urlImageBackground: "assets/backgroundPokemon/stellar.jpg",
      color: Colors.white),
  DARK(
      urlImageType: "assets/type/dark.png",
      urlImageBackground: "assets/backgroundPokemon/shadow.jpg",
      color: Color.fromRGBO(80, 64, 62, 1));

  final String urlImageType;
  final String urlImageBackground;
  final Color color;
  const TypePokemon(
      {required this.urlImageType,
        required this.color,
        required this.urlImageBackground});

  List<TypePokemon> getWeak() {
    switch (this) {
      case TypePokemon.NORMAL:
        return [TypePokemon.FIGHTING];
      case TypePokemon.FIGHTING:
        return [TypePokemon.FLYING, TypePokemon.PSYCHIC, TypePokemon.FAIRY];
      case TypePokemon.FLYING:
        return [TypePokemon.ROCK, TypePokemon.ELECTRIC, TypePokemon.ICE];
      case TypePokemon.POISON:
        return [TypePokemon.GROUND, TypePokemon.PSYCHIC];
      case TypePokemon.GROUND:
        return [TypePokemon.WATER, TypePokemon.GRASS, TypePokemon.ICE];
      case TypePokemon.ROCK:
        return [
          TypePokemon.FIGHTING,
          TypePokemon.GROUND,
          TypePokemon.STEEL,
          TypePokemon.WATER,
          TypePokemon.GRASS
        ];
      case TypePokemon.BUG:
        return [TypePokemon.FLYING, TypePokemon.ROCK, TypePokemon.FIRE];
      case TypePokemon.GHOST:
        return [TypePokemon.GHOST, TypePokemon.DARK];
      case TypePokemon.STEEL:
        return [TypePokemon.FIGHTING, TypePokemon.GROUND, TypePokemon.FIRE];
      case TypePokemon.FIRE:
        return [TypePokemon.GROUND, TypePokemon.ROCK, TypePokemon.WATER];
      case TypePokemon.WATER:
        return [TypePokemon.GRASS, TypePokemon.ELECTRIC];
      case TypePokemon.GRASS:
        return [
          TypePokemon.FLYING,
          TypePokemon.POISON,
          TypePokemon.BUG,
          TypePokemon.FIRE,
          TypePokemon.ICE
        ];
      case TypePokemon.ELECTRIC:
        return [TypePokemon.GROUND];
      case TypePokemon.PSYCHIC:
        return [TypePokemon.BUG, TypePokemon.GHOST, TypePokemon.DARK];
      case TypePokemon.ICE:
        return [
          TypePokemon.FIGHTING,
          TypePokemon.ROCK,
          TypePokemon.STEEL,
          TypePokemon.FIRE
        ];
      case TypePokemon.DRAGON:
        return [TypePokemon.DRAGON, TypePokemon.ICE, TypePokemon.FAIRY];
      case TypePokemon.FAIRY:
        return [TypePokemon.STEEL, TypePokemon.POISON];
      case TypePokemon.DARK:
        return [TypePokemon.FIGHTING, TypePokemon.BUG, TypePokemon.FAIRY];
      case TypePokemon.STELLAR:
        return [];
    }
  }

  List<TypePokemon> getResistance() {
    switch (this) {
      case TypePokemon.FAIRY:
        return [TypePokemon.FIGHTING, TypePokemon.BUG, TypePokemon.DARK];
      case TypePokemon.DARK:
        return [TypePokemon.GHOST, TypePokemon.DARK];
      case TypePokemon.DRAGON:
        return [
          TypePokemon.FIRE,
          TypePokemon.WATER,
          TypePokemon.GRASS,
          TypePokemon.ELECTRIC
        ];
      case TypePokemon.ICE:
        return [TypePokemon.ICE];
      case TypePokemon.PSYCHIC:
        return [TypePokemon.FIGHTING, TypePokemon.PSYCHIC];
      case TypePokemon.ELECTRIC:
        return [TypePokemon.FLYING, TypePokemon.STEEL, TypePokemon.ELECTRIC];
      case TypePokemon.GRASS:
        return [
          TypePokemon.GROUND,
          TypePokemon.WATER,
          TypePokemon.GRASS,
          TypePokemon.ELECTRIC
        ];
      case TypePokemon.WATER:
        return [
          TypePokemon.STEEL,
          TypePokemon.FIRE,
          TypePokemon.WATER,
          TypePokemon.ICE
        ];
      case TypePokemon.FIRE:
        return [
          TypePokemon.BUG,
          TypePokemon.STEEL,
          TypePokemon.FIRE,
          TypePokemon.GRASS,
          TypePokemon.ICE,
          TypePokemon.FAIRY
        ];
      case TypePokemon.STEEL:
        return [
          TypePokemon.NORMAL,
          TypePokemon.FLYING,
          TypePokemon.ROCK,
          TypePokemon.BUG,
          TypePokemon.STEEL,
          TypePokemon.GRASS,
          TypePokemon.PSYCHIC,
          TypePokemon.ICE,
          TypePokemon.DRAGON,
          TypePokemon.FAIRY
        ];
      case TypePokemon.GHOST:
        return [TypePokemon.POISON, TypePokemon.BUG];
      case TypePokemon.BUG:
        return [TypePokemon.FIGHTING, TypePokemon.GROUND, TypePokemon.GRASS];
      case TypePokemon.ROCK:
        return [
          TypePokemon.NORMAL,
          TypePokemon.FLYING,
          TypePokemon.POISON,
          TypePokemon.FIRE
        ];
      case TypePokemon.GROUND:
        return [TypePokemon.POISON, TypePokemon.ROCK];
      case TypePokemon.POISON:
        return [
          TypePokemon.FIGHTING,
          TypePokemon.POISON,
          TypePokemon.BUG,
          TypePokemon.GRASS,
          TypePokemon.FAIRY
        ];
      case TypePokemon.FLYING:
        return [TypePokemon.FIGHTING, TypePokemon.BUG, TypePokemon.GRASS];
      case TypePokemon.FIGHTING:
        return [
          TypePokemon.ROCK,
          TypePokemon.BUG,
          TypePokemon.DARK,
        ];
      case TypePokemon.NORMAL || TypePokemon.STELLAR:
        return [];
    }
  }

  List<TypePokemon> getImmune() {
    switch (this) {
      case TypePokemon.NORMAL:
        return [TypePokemon.GHOST];
      case TypePokemon.FLYING:
        return [TypePokemon.GROUND];
      case TypePokemon.STEEL:
        return [TypePokemon.POISON];
      case TypePokemon.GHOST:
        return [TypePokemon.NORMAL, TypePokemon.FIGHTING];
      case TypePokemon.GROUND:
        return [TypePokemon.ELECTRIC];
      case TypePokemon.DARK:
        return [TypePokemon.PSYCHIC];
      case TypePokemon.FAIRY:
        return [TypePokemon.DRAGON];
      default:
        return [];
    }
  }

  String getTitle() {
    switch (this) {
      case TypePokemon.NORMAL:
        return "Normal";
      case TypePokemon.FIGHTING:
        return "Fighting";
      case TypePokemon.FLYING:
        return "Flying";
      case TypePokemon.POISON:
        return "Poison";
      case TypePokemon.GROUND:
        return "Ground";
      case TypePokemon.ROCK:
        return "Rock";
      case TypePokemon.BUG:
        return "Bug";
      case TypePokemon.GHOST:
        return "Ghost";
      case TypePokemon.STEEL:
        return "Steel";
      case TypePokemon.FIRE:
        return "Fire";
      case TypePokemon.WATER:
        return "Water";
      case TypePokemon.GRASS:
        return "Grass";
      case TypePokemon.ELECTRIC:
        return "Electric";
      case TypePokemon.PSYCHIC:
        return "Psychic";
      case TypePokemon.ICE:
        return "Ice";
      case TypePokemon.DRAGON:
        return "Dragon";
      case TypePokemon.FAIRY:
        return "Fairy";
      case TypePokemon.STELLAR:
        return "Stellar";
      case TypePokemon.DARK:
        return "Dark";
    }
  }

  static TypePokemon? obtainType(String nameType) {
    if (nameType == "normal") return TypePokemon.NORMAL;
    if (nameType == "fighting") return TypePokemon.FIGHTING;
    if (nameType == "flying") return TypePokemon.FLYING;
    if (nameType == "poison") return TypePokemon.POISON;
    if (nameType == "ground") return TypePokemon.GROUND;
    if (nameType == "rock") return TypePokemon.ROCK;
    if (nameType == "bug") return TypePokemon.BUG;
    if (nameType == "ghost") return TypePokemon.GHOST;
    if (nameType == "steel") return TypePokemon.STEEL;
    if (nameType == "fire") return TypePokemon.FIRE;
    if (nameType == "water") return TypePokemon.WATER;
    if (nameType == "electric") return TypePokemon.ELECTRIC;
    if (nameType == "grass") return TypePokemon.GRASS;
    if (nameType == "psychic") return TypePokemon.PSYCHIC;
    if (nameType == "ice") return TypePokemon.ICE;
    if (nameType == "dragon") return TypePokemon.DRAGON;
    if (nameType == "fairy") return TypePokemon.FAIRY;
    if (nameType == "stellar") return TypePokemon.STELLAR;
    if (nameType == "dark") return TypePokemon.DARK;
    return null;
  }
}