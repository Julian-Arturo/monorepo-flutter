import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:image_network/image_network.dart';
import 'package:planets_data/model/planet_model.dart';
import 'package:planets_ui/planets_ui.dart';
import 'package:planets_webs/app/view/routes.dart';
import 'package:planets_webs/feature/planets/presentation/planets_list/planet_list_controller.dart';
import 'package:planets_webs/feature/planets/presentation/planets_list/planet_list_state.dart';

class FavoritePlanetsView extends ConsumerWidget {
  const FavoritePlanetsView({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final state = ref.watch(planetListControllerProvider);
    final controller = ref.read(planetListControllerProvider.notifier);
    final deviceType = context.deviceType;
    final desktop = deviceType == DeviceType.desktop;
    final talblet = deviceType == DeviceType.tablet;
    return Scaffold(
      appBar: AppBar(
        title: const Text('Planetas Favoritos'),
        leading: IconButton(
          icon: const Icon(Icons.arrow_back),
          onPressed: () {
            context.pop(); 
          },
        ),
      ),
      body: state.favoritePlanets.isEmpty
          ? const Center(child: Text('No tienes planetas en favoritos.'))
          : Center(
              child: Container(
                margin: context.symmetric(0, .05),
                width: talblet
                    ? context.width(.9)
                    : desktop
                        ? context.width(.8)
                        : context.width(),
                child: GridView.builder(
                  gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 3,
                  ),
                  itemCount: state.favoritePlanets.length,
                  itemBuilder: (context, index) {
                    final planet = state.favoritePlanets[index];
                    return _buildPlanetCard(planet, state, controller, context);
                  },
                ),
              ),
            ),
    );
  }

  Widget _buildPlanetCard(
    Planet planet,
    PlanetListState state,
    PlanetListController controller,
    BuildContext context,
  ) {
    final deviceType = context.deviceType;
    final desktop = deviceType == DeviceType.desktop;
    final talblet = deviceType == DeviceType.tablet;
    return Column(
      children: [
        ImageNetwork(
          borderRadius: BorderRadius.circular(100),
          image: planet.image ?? '',
          width: talblet
              ? 100
              : desktop
                  ? 200
                  : 60,
          height: talblet
              ? 100
              : desktop
                  ? 200
                  : 60,
          onError: Image.asset('assets/planet.webp'),
          onTap: () {
            controller.selectPlanet(planet);
            context.go(
              Routes.planetDetails.replaceFirst(
                ':planetName',
                planet.name ?? '',
              ),
            );
          },
        ),
        const SizedBox(height: 8),
        Text(
          planet.name ?? '',
          textAlign: TextAlign.center,
          style: const TextStyle(
            fontWeight: FontWeight.bold,
            fontSize: 20,
          ),
        ),
        IconButton(
          icon: Icon(
            state.favoritePlanets.contains(planet)
                ? Icons.star
                : Icons.star_border,
            color: Colors.yellow,
          ),
          onPressed: () {
            controller.toggleFavorite(planet);
          },
        ),
      ],
    );
  }
}
