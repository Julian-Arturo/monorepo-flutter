import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:planets_data/planets_data.dart';
import 'package:planets_movil/app/view/app.dart';
import 'package:planets_movil/bootstrap.dart';
void main() {
  configureDependencies();  
  runApp(
    ProviderScope(
      observers: [AppProviderObserver()],
      child: const App(),
    ),
  );
}
