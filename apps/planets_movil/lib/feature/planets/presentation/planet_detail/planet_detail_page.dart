import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:image_network/image_network.dart';
import 'package:planets_movil/app/view/routes.dart';
import 'package:planets_movil/feature/planets/presentation/planets_list/planet_list_controller.dart';
import 'package:planets_ui/planets_ui.dart';


class PlanetDetailsPage extends ConsumerWidget {
  const PlanetDetailsPage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final state = ref.watch(planetListControllerProvider);
    final planet = state.selectedItem;

    if (planet == null) {
      Future.microtask(() => context.go(Routes.planets));
      return Container();
    }
    final controller = ref.read(planetListControllerProvider.notifier);
    final deviceType = context.deviceType;
    final desktop = deviceType == DeviceType.desktop;
    final talblet = deviceType == DeviceType.tablet;
    final mobile = deviceType == DeviceType.mobile;

    return Scaffold(
      body: Center(
        child: SingleChildScrollView(
          child: Column(
            children: [
              Stack(
                alignment: Alignment.topCenter,
                children: [
                  Positioned.directional(
                    textDirection: TextDirection.ltr,
                    child: Hero(
                      tag: 'planet-${planet.name}',
                      child: ImageNetwork(
                        borderRadius: BorderRadius.circular(300),
                        image: planet.image ?? '',
                        width: 500,
                        height: 500,
                        onError: Image.asset('assets/planet.webp'),
                      ),
                    ),
                  ),
                  Positioned(
                    child: Container(
                      width: context.width(),
                      height: context.height(.3),
                      decoration: const BoxDecoration(
                        color: secondaryBase,
                        borderRadius: BorderRadius.only(
                          bottomLeft: Radius.circular(20),
                          bottomRight: Radius.circular(20),
                        ),
                      ),
                      child: Center(
                        child: mobile
                            ? Column(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Flexible(
                                    child: Text(
                                      'Bienvenido a ${planet.name}',
                                      style: const TextStyle(
                                        fontSize: 40,
                                        fontWeight: FontWeight.bold,
                                        color: primaryBase,
                                      ),
                                      softWrap: true,
                                      maxLines: 2,
                                      overflow: TextOverflow.ellipsis,
                                    ),
                                  ),
                                  IconButton(
                                    icon: Icon(
                                      state.favoritePlanets.contains(planet)
                                          ? Icons.star
                                          : Icons.star_border,
                                      color: Colors.yellow,
                                      size: context.height(.05),
                                    ),
                                    onPressed: () {
                                      controller.toggleFavorite(planet);
                                    },
                                  ),
                                ],
                              )
                            : Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Flexible(
                                    child: Text(
                                      'Bienvenido a ${planet.name}',
                                      style: const TextStyle(
                                        fontSize: 40,
                                        fontWeight: FontWeight.bold,
                                        color: primaryBase,
                                      ),
                                      softWrap: true,
                                      maxLines: 2,
                                      overflow: TextOverflow.ellipsis,
                                    ),
                                  ),
                                  IconButton(
                                    icon: Icon(
                                      state.favoritePlanets.contains(planet)
                                          ? Icons.star
                                          : Icons.star_border,
                                      color: Colors.yellow,
                                      size: context.height(.05),
                                    ),
                                    onPressed: () {
                                      controller.toggleFavorite(planet);
                                    },
                                  ),
                                ],
                              ),
                      ),
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 16),
              // Recuadro para los detalles del planeta
              Container(
                margin: context.symmetric(.01, .04),
                padding: context.all(.02),
                width: talblet
                    ? context.width()
                    : desktop
                        ? context.width(.3)
                        : context.width(),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(12),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.grey.withOpacity(0.5),
                      spreadRadius: 2,
                      blurRadius: 5,
                      offset: const Offset(0, 3),
                    ),
                  ],
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Text(
                      'Detalles:',
                      style: TextStyle(
                        fontSize: 24,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    const SizedBox(height: 10),
                    Text('Distancia Orbital: ${planet.orbitalDistanceKm} km'),
                    Text('Radio Ecuatorial: ${planet.equatorialRadiusKm} km'),
                    Text('Masa: ${planet.massKg} kg'),
                    Text('Composición de la Atmósfera: ${planet.atmosphereComposition}'),
                    Text('Número de Lunas: ${planet.moons}'),
                    Text('Gravedad Superficial: ${planet.surfaceGravityMs2} m/s²'),
                    Text('Descripción: ${planet.description}'),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
