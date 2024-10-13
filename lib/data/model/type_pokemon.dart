import 'dart:ui';

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
      color: Color.fromRGBO(254, 255, 254, 1)),
  SHADOW(
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
      case TypePokemon.SHADOW:
        return "Shadow";
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
    if (nameType == "shadow") return TypePokemon.SHADOW;
    return null;
  }
}
