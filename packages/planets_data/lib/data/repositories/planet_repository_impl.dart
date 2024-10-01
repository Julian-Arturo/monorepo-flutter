import 'package:dartz/dartz.dart';
import 'package:injectable/injectable.dart';
import 'package:planets_data/data/data_source/planet_data_source.dart';
import 'package:planets_data/domain/repositories/planet_repository.dart';
import 'package:planets_data/model/http_services_response.dart';
import 'package:planets_data/model/planet_model.dart';
import 'package:planets_data/utils/network/planet_failure.dart';

/// `PlanetRepositoryImpl` es una implementación concreta de `PlanetRepository`.
///
/// Esta clase se encarga de obtener los datos de los planetas desde un
/// `PlanetDataSource` y gestionar la lógica para manejar los errores y
/// la transformación de datos.
@Injectable(as: PlanetRepository)
class PlanetRepositoryImpl implements PlanetRepository {
  /// Fuente de datos inyectada que proporciona acceso a la API de planetas.
  final PlanetDataSource dataSource;

  /// Constructor que recibe una instancia de `PlanetDataSource`.
  PlanetRepositoryImpl(this.dataSource);

  /// Método `getPlanets`:
  ///
  /// - Retorna: Un `Future` que contiene un `Either<PlanetFailure, List<Planet>>`.
  ///   - Si la solicitud es exitosa, devuelve una lista de objetos `Planet`.
  ///   - Si falla, devuelve una instancia de `PlanetFailure` con un mensaje de error.
  ///
  /// Este método realiza lo siguiente:
  /// 1. Llama a `dataSource.getPlanets()` para obtener la respuesta del servicio HTTP.
  /// 2. Comprueba si la respuesta fue exitosa:
  ///    - Si no, retorna un `PlanetFailure` con un mensaje de error.
  /// 3. Procesa los datos de los planetas:
  ///    - Si la lista de planetas no está vacía y no es del tipo esperado, la convierte a una lista de `Planet`.
  ///    - Si es del tipo esperado, la transforma utilizando `Planet.fromJson`.
  /// 4. Maneja cualquier excepción que pueda ocurrir durante el proceso.
  ///
  /// Ejemplo de uso:
  /// ```dart
  /// final result = await planetRepository.getPlanets();
  /// result.fold(
  ///   (failure) => print(failure.message), // Manejo del error
  ///   (planets) => print(planets), // Manejo de éxito
  /// );
  /// ```
  @override
  Future<Either<PlanetFailure, List<Planet>>> getPlanets() async {
    try {
      final HttpServiceResponse response = await dataSource.getPlanets();

      // Manejo de respuesta no exitosa
      if (!response.success) {
        return left(PlanetFailure(message: response.message ?? "serviceError"));
      }

      final planetsList = response.planets ?? []; 

      // Verificación del tipo de datos y mapeo de la lista de planetas
      if (planetsList.isNotEmpty && planetsList.first is! Map<String, dynamic>) {
        return right(planetsList.cast<Planet>());
      }

      final List<Planet> mappedPlanets = planetsList.map((planetJson) {
        return Planet.fromJson(planetJson as Map<String, dynamic>);
      }).toList();

      return right(mappedPlanets);
      
    } catch (e) {
      // Manejo de excepciones
      return left(PlanetFailure(message: 'Failed to fetch planets: $e'));
    }
  }
}
