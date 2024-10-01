import 'package:dartz/dartz.dart';
import 'package:injectable/injectable.dart';
import 'package:planets_data/domain/repositories/planet_repository.dart';
import 'package:planets_data/model/planet_model.dart';
import 'package:planets_data/utils/network/planet_failure.dart';

/// `PlanetUseCase` se encarga de orquestar la lógica de obtención de planetas.
/// Esta clase usa un patrón de caso de uso para aislar la lógica de negocio del repositorio.
///
/// Usa el paquete `injectable` para la inyección de dependencias, lo que facilita
/// la prueba y gestión de la instancia de `PlanetRepository`.
@injectable
class PlanetUseCase {
  /// Constructor de `PlanetUseCase`, que recibe una instancia de `PlanetRepository`.
  PlanetUseCase(this.repository);

  /// Repositorio inyectado que contiene la lógica para obtener los datos de los planetas.
  final PlanetRepository repository;

  /// Método `getPlanets`:
  ///
  /// - Retorna: Un `Future` que contiene un `Either<PlanetFailure, List<Planet>>`.
  ///   - Si es exitoso, devuelve una lista de objetos `Planet`.
  ///   - Si hay un fallo, devuelve una instancia de `PlanetFailure` con un mensaje de error.
  ///
  /// Ejemplo de uso:
  /// ```dart
  /// final result = await planetUseCase.getPlanets();
  /// result.fold(
  ///   (failure) => print(failure.message), // Manejo del error
  ///   (planets) => print(planets), // Manejo del éxito
  /// );
  /// ```
  Future<Either<PlanetFailure, List<Planet>>> getPlanets() {
    return repository.getPlanets();
  }
}
