import 'package:planets_data/model/planet_model.dart';
import 'package:planets_data/utils/network/planet_failure.dart';

class PlanetListState {

  PlanetListState({
    this.isLoading = false,
    this.failure,
    this.planets = const [],
    this.filteredPlanets = const [],
    this.favoritePlanets = const [], 
    this.selectedItem,
  });
  final bool isLoading;
  final PlanetFailure? failure;
  final List<Planet> planets;
  final List<Planet> filteredPlanets;
  final List<Planet> favoritePlanets; 
  final Planet? selectedItem;

  PlanetListState copyWith({
    bool? isLoading,
    PlanetFailure? failure,
    List<Planet>? planets,
    List<Planet>? filteredPlanets,
    List<Planet>? favoritePlanets,
    Planet? selectedItem,
  }) {
    return PlanetListState(
      isLoading: isLoading ?? this.isLoading,
      failure: failure ?? this.failure,
      planets: planets ?? this.planets,
      filteredPlanets: filteredPlanets ?? this.filteredPlanets,
      favoritePlanets: favoritePlanets ?? this.favoritePlanets,
      selectedItem: selectedItem ?? this.selectedItem,
    );
  }
}
