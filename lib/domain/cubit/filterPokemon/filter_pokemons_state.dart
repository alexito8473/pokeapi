part of 'filter_pokemons_cubit.dart';

class FilterPokemonsState {
  final GenerationPokemon generationPokemon;
  const FilterPokemonsState({required this.generationPokemon});

  factory FilterPokemonsState.init({required SharedPreferences prefs}) {
    return FilterPokemonsState(
        generationPokemon: GenerationPokemon.obtainGenerationPokemon(
            prefs.getString(Constants.sharePreferenceGeneration)));
  }
}
