import 'package:http/http.dart';
import 'package:pokeapi/data/model/pokemon.dart';
import 'package:pokeapi/domain/Constants.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

class ObtainDataPokemonsRepository {
  late final String urlObtainLowDataAllPokemon;
  final int maxPokemonObtain = 151;

  ObtainDataPokemonsRepository._({required this.urlObtainLowDataAllPokemon});
  factory ObtainDataPokemonsRepository.init() => ObtainDataPokemonsRepository._(
      urlObtainLowDataAllPokemon: Constants.urlObtainBasicDataAllPokemon);

  Future<List<Pokemon>> obtainDataAllPokemon() async {
    List<Pokemon> listPokemon = [];
    dynamic dataAllPokemon;
    dynamic dataOnePokemon;
    Response responseDataOnePokemon;
    Response responseDataAllPokemon = await http
        .get(Uri.parse("$urlObtainLowDataAllPokemon?limit=$maxPokemonObtain"));
    if (responseDataAllPokemon.statusCode == 200) {
      dataAllPokemon = jsonDecode(responseDataAllPokemon.body);
      for (int i = 0; i < maxPokemonObtain; i++) {
        responseDataOnePokemon =
            await http.get(Uri.parse(dataAllPokemon["results"][i]["url"]));
        if(responseDataOnePokemon.statusCode==200){
          dataOnePokemon= jsonDecode(responseDataOnePokemon.body);
          listPokemon.add(Pokemon(name: dataAllPokemon["results"][i]["name"],
              spriteBack: dataOnePokemon["sprites"]["back_default"],
          spriteFront: dataOnePokemon["sprites"]["back_default"]));
        }

      }
    }
    return listPokemon;
  }
}
