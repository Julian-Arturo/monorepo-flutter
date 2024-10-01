import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:image_network/image_network.dart';
import 'package:planets_data/model/planet_model.dart';
import 'package:planets_ui/planets_ui.dart';
import 'package:planets_webs/app/view/routes.dart';
import 'package:planets_webs/feature/planets/presentation/planets_list/planet_list_controller.dart';
import 'package:planets_webs/feature/planets/presentation/planets_list/planet_list_state.dart';

class PlanetListPage extends ConsumerWidget {
  const PlanetListPage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final state = ref.watch(planetListControllerProvider);
    final controller = ref.read(planetListControllerProvider.notifier);
    final deviceType = context.deviceType;
    final desktop = deviceType == DeviceType.desktop;
    final talblet = deviceType == DeviceType.tablet;


    return Scaffold(
      body: state.isLoading
          ? const Center(child: CircularProgressIndicator())
          : state.failure != null
              ? Center(child: Text('Error: ${state.failure?.message}'))
              : Center(
                  child: SizedBox(
                    width: talblet ? context.width(.8) : desktop ? context.width(.6) : context.width(),
                    child: Column(
                      children: [
                        Padding(
                          padding: const EdgeInsets.all(8),
                          child: Row(
                            children: [
                              Expanded(
                                child: Container(
                                  decoration: const BoxDecoration(
                                    color: secondaryBase,
                                    borderRadius: BorderRadius.all(Radius.circular(10)),
                                  ),
                                  child: TextField(
                                    style: const TextStyle(color: primaryBase),
                                    decoration: const InputDecoration(
                                      labelText: 'Buscar Planetas',
                                      labelStyle: TextStyle(color: primaryBase),
                                      hintStyle: TextStyle(color: primaryBase),
                                      prefixIcon: Icon(Icons.search, color: primaryBase),
                                      enabledBorder: InputBorder.none,
                                      disabledBorder: InputBorder.none,
                                      focusedBorder: InputBorder.none,
                                    ),
                                    onChanged: controller.filterPlanets,
                                  ),
                                ),
                              ),
                              Container(
                                margin: context.symmetric(.05, 0),
                                decoration: const BoxDecoration(
                                  color: secondaryBase,
                                  borderRadius:
                                      BorderRadius.all(Radius.circular(10)),
                                ),
                                child: TextButton(
                                  child: const Text(
                                    'Favoritos',
                                    style: TextStyle(color: primaryBase),
                                  ),
                                  onPressed: () {
                                    context.push(Routes.favoritePlanetsView);
                                  },
                                ),
                              ),
                            ],
                          ),
                        ),
                        const SizedBox(height: 16),

                        // GridView de planetas
                        Expanded(
                          child: GridView.builder(
                            gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                              crossAxisCount: talblet ? 3 : desktop ? 3 : 2,
                              crossAxisSpacing: 16,
                              mainAxisSpacing: 16,
                            ),
                            itemCount: state.filteredPlanets.length,
                            itemBuilder: (context, index) {
                              final planet = state.filteredPlanets[index];
                              return _buildPlanetCard(planet, state, controller, context);
                            },
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
      floatingActionButton: FloatingActionButton(
        onPressed: controller.fetchPlanets,
        child: const Icon(Icons.refresh),
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
        Hero(
          tag: 'planet-${planet.name}',
          child: ImageNetwork(
            borderRadius: BorderRadius.circular(100),
            image: planet.image ?? '',
            width: talblet ? 100 : desktop ? 150 : 100,
            height: talblet ? 100 : desktop ? 150 : 100,
            onError: Image.asset('assets/planet.webp'),
            onTap: () {
              controller.selectPlanet(planet);
              context.push(
                Routes.planetDetails.replaceFirst(
                  ':planetName',
                  planet.name ?? '',
                ),
              );
            },
          ),
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
