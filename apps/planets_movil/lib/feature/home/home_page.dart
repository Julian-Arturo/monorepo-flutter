import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:planets_movil/app/view/routes.dart';
import 'package:planets_movil/feature/planets/presentation/planets_list/planet_list_controller.dart';
import 'package:planets_ui/planets_ui.dart';


class HomePage extends ConsumerWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final deviceType = context.deviceType;
    return SafeArea(
      child: Scaffold(
        body: Center(
          child: PlanetHomeLayout(
            deviceType: deviceType,
            onPressed: () => onTap(context, ref),
          ),
        ),
      ),
    );
  }

  Future<void> onTap(BuildContext context, WidgetRef ref) async {
    final controller = ref.read(planetListControllerProvider.notifier);
    await controller.fetchPlanets();
    if (context.mounted) {
      context.go(Routes.planets);
    }
  }
}
