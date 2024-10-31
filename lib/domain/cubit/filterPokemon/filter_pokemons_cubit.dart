import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';
import 'package:pokeapi/data/model/pokemon.dart';
import 'package:pokeapi/domain/Constants.dart';
import 'package:shared_preferences/shared_preferences.dart';

part 'filter_pokemons_state.dart';

class FilterPokemonsCubit extends Cubit<FilterPokemonsState> {
  final SharedPreferences prefs;
  FilterPokemonsCubit({required this.prefs})
      : super(FilterPokemonsState.init(prefs: prefs));

  void changePokemon({required GenerationPokemon generationPokemon}) async {
    await prefs.setString(
        Constants.sharePreferenceGeneration, generationPokemon.title);
    emit(FilterPokemonsState(generationPokemon: generationPokemon));
  }
}
