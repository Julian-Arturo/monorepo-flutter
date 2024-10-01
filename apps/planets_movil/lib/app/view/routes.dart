import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:planets_movil/core/presentation/error_page.dart';
import 'package:planets_movil/feature/home/home_page.dart';
import 'package:planets_movil/feature/planets/presentation/planet_detail/planet_detail_page.dart';
import 'package:planets_movil/feature/planets/presentation/planets_list/planet_list_page.dart';
import 'package:planets_movil/feature/planets/presentation/planets_list/widget/favorite_planets_view.dart';

class Routes {
  static const String home = '/';
  static const String planets = '/planets';
  static const String planetDetails = '/planetsdetails/:planetName';
  static const String favoritePlanetsView = '/favorite-lanets-view';

  static const String errorPage = '/error';
}

final List<String> validPlanets = [
  'Mercury',
  'Venus',
  'Earth',
  'Mars',
  'Jupiter',
  'Saturn',
  'Uranus',
  'Neptune',
];

final router = GoRouter(
  routes: [
    // Ruta para la página principal
    GoRoute(
      path: Routes.home,
      pageBuilder: (context, state) =>
          page(state: state, child: const HomePage()),
    ),
    // Ruta para el listado de planetas
    GoRoute(
      path: Routes.planets,
      pageBuilder: (context, state) =>
          page(state: state, child: const PlanetListPage()),
    ),
    // Ruta dinámica para los detalles del planeta
    GoRoute(
      path: Routes.planetDetails,
      pageBuilder: (context, state) {
        final planetName = state.pathParameters['planetName']; 
        if (validPlanets.contains(planetName)) {
          return page(state: state, child: const PlanetDetailsPage());
        } else {
          return page(state: state, child: const ErrorPage());
        }
      },
    ),

      GoRoute(
      path: Routes.favoritePlanetsView,
      pageBuilder: (context, state) =>
          page(state: state, child: const FavoritePlanetsView()),
    ),
    // Ruta para la página de error
    GoRoute(
      path: Routes.errorPage,
      pageBuilder: (context, state) =>
          page(state: state, child: const ErrorPage()),
    ),
  ],
  // Redirigir a la página de error si la ruta no existe
  errorPageBuilder: (context, state) =>
      page(state: state, child: const ErrorPage()),
);

Page<void> page({required GoRouterState state, required Widget child}) {
  return NoTransitionPage<void>(
    key: state.pageKey,
    child: child,
  );
}
