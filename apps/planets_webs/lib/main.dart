import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:planets_data/planets_data.dart';
import 'package:planets_webs/app/app.dart';
import 'package:planets_webs/observer.dart';
void main() {
  configureDependencies();  
  runApp(
    ProviderScope(
      observers: [AppProviderObserver()],
      child: const App(),
    ),
  );
}
