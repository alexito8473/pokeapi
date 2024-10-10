import 'dart:ui';

enum TypePokemon {
  NORMAL(urlImage: "assets/type/normal.png",color: Color.fromRGBO(159, 161, 159, 1)),
  FIGHTING(urlImage: "assets/type/fighting.png",color: Color.fromRGBO(254,129,0, 1)),
  FLYING(urlImage: "assets/type/flying.png",color: Color.fromRGBO(128,184,239, 1)),
  POISON(urlImage: "assets/type/poison.png",color: Color.fromRGBO(144,65,202, 1)),
  GROUND(urlImage: "assets/type/ground.png",color: Color.fromRGBO(145,80,32, 1)),
  ROCK(urlImage: "assets/type/rock.png",color: Color.fromRGBO(174,168,129, 1)),
  BUG(urlImage: "assets/type/bug.png",color: Color.fromRGBO(144,160,25, 1)),
  GHOST(urlImage: "assets/type/ghost.png",color: Color.fromRGBO(113,65,113, 1)),
  STEEL(urlImage: "assets/type/steel.png",color: Color.fromRGBO(97,160,184, 1)),
  FIRE(urlImage: "assets/type/fire.png",color: Color.fromRGBO(230,40,41, 1)),
  WATER(urlImage: "assets/type/water.png",color: Color.fromRGBO(41,128,239, 1)),
  GRASS(urlImage: "assets/type/grass.png",color: Color.fromRGBO(62,160,41, 1)),
  ELECTRIC(urlImage: "assets/type/electric.png",color: Color.fromRGBO(250,192,0, 1)),
  PSYCHIC(urlImage: "assets/type/pyshic.png",color: Color.fromRGBO(239,64,120, 1)),
  ICE(urlImage: "assets/type/ice.png",color: Color.fromRGBO(62,216,254, 1)),
  DRAGON(urlImage: "assets/type/dragon.png",color: Color.fromRGBO(80,97,224, 1)),
  FAIRY(urlImage: "assets/type/fairy.png",color: Color.fromRGBO(238,113,239, 1)),
  STELLAR(urlImage: "assets/type/stellar.png",color: Color.fromRGBO(254,255,254, 1)),
  SHADOW(urlImage: "assets/type/dark.png",color: Color.fromRGBO(80,64,62, 1));

  final String urlImage;
  final Color color;
  const TypePokemon({required this.urlImage, required this.color});
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
