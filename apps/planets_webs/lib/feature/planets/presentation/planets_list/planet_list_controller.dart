import 'dart:convert';

import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:planets_data/model/planet_model.dart';
import 'package:planets_data/planets_data.dart';
import 'package:planets_webs/feature/planets/presentation/planets_list/planet_list_state.dart';
import 'package:shared_preferences/shared_preferences.dart';

class PlanetListController extends StateNotifier<PlanetListState> {
  PlanetListController(this.planetUseCase) : super(PlanetListState()) {
    _loadFavorites();
    fetchPlanets();
  }

  final PlanetUseCase planetUseCase;

  Future<void> fetchPlanets() async {
    if (state.planets.isEmpty) {
      state = state.copyWith(isLoading: true);
      final result = await planetUseCase.getPlanets();
      result.fold(
        (failure) {
          state = state.copyWith(isLoading: false, failure: failure);
        },
        (planets) {
          state = state.copyWith(
            isLoading: false,
            planets: planets,
            filteredPlanets: planets,
          );
        },
      );
    }
  }

  void selectPlanet(Planet selec) {
    state = state.copyWith(selectedItem: selec);
  }

  // Función para filtrar planetas
  void filterPlanets(String query) {
    final filteredList = state.planets.where((planet) {
      if (query.isEmpty) return true;
      final lowerCaseQuery = query.toLowerCase();
      final fields = [
        planet.name?.toLowerCase(),
        planet.massKg.toString().toLowerCase(),
        planet.densityGcm3.toString().toLowerCase(),
        planet.description.toString().toLowerCase(),
        planet.orbitalDistanceKm.toString().toLowerCase(),
        /// Agregar según sea necesario
      ];
      return fields.any((field) => field?.contains(lowerCaseQuery) ?? false);
    }).toList();

    state = state.copyWith(filteredPlanets: filteredList);
  }

  // Método para agregar o quitar planetas de favoritos
  Future<void> toggleFavorite(Planet planet) async {
    final favorites = List<Planet>.from(state.favoritePlanets);

    if (!favorites.contains(planet)) {
      favorites.add(planet);
      final prefs = await SharedPreferences.getInstance();
      await prefs.setStringList(
        'favoritePlanets',
        favorites.map((Planet p) => jsonEncode(p.toJson())).toList(),
      );
      state = state.copyWith(favoritePlanets: favorites);
    } else {
      favorites.remove(planet);
      state = state.copyWith(favoritePlanets: favorites);
    }
  }

// Método para cargar favoritos desde SharedPreferences
  Future<void> _loadFavorites() async {
    final prefs = await SharedPreferences.getInstance();
    final favoritesJsonList = prefs.getStringList('favoritePlanets');
    if (favoritesJsonList != null && favoritesJsonList.isNotEmpty) {
      final favorites = favoritesJsonList.map((json) {
        return Planet.fromJson(jsonDecode(json) as Map<String, dynamic>);
      }).toList();
      state = state.copyWith(favoritePlanets: favorites);
    }
  }
}

final planetListControllerProvider =
    StateNotifierProvider<PlanetListController, PlanetListState>(
  (ref) => PlanetListController(
    getIt.get(),
  ),
);
