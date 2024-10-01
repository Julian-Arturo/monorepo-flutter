import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:planets_webs/app/view/routes.dart';

class ErrorPage extends StatelessWidget {
  const ErrorPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Error - Planeta no encontrado')),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Text(
              'Lo sentimos, el planeta que buscas no existe.',
              style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 20),
            ElevatedButton(
              onPressed: () {
                context.go(Routes.planets); 
              },
              child: const Text('Volver a la lista de planetas'),
            ),
          ],
        ),
      ),
    );
  }
}
