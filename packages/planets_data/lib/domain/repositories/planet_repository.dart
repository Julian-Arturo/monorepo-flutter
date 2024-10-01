import 'package:planets_data/model/planet_model.dart';
import 'package:planets_data/utils/network/planet_failure.dart';
import 'package:dartz/dartz.dart';

/// `PlanetRepository` es una clase abstracta que define un contrato para obtener
/// los datos de los planetas.
///
/// El uso de `Either` del paquete `dartz` permite manejar de forma segura 
/// el éxito y el fallo en la operación.
abstract class PlanetRepository {
  /// Método `getPlanets`:
  /// 
  /// - Retorna: Un `Future` que contiene un `Either<PlanetFailure, List<Planet>>`.
  ///   - Si la operación es exitosa, se retorna una lista de objetos `Planet`.
  ///   - Si ocurre un error, se retorna una instancia de `PlanetFailure` con un mensaje descriptivo.
  /// 
  /// Ejemplo de uso:
  /// ```dart
  /// final result = await planetRepository.getPlanets();
  /// result.fold(
  ///   (failure) => print(failure.message), // Manejo del error
  ///   (planets) => print(planets), // Manejo de éxito
  /// );
  /// ```
  Future<Either<PlanetFailure, List<Planet>>> getPlanets();
}
