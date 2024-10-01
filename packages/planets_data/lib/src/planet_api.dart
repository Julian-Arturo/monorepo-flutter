import 'package:dio/dio.dart';
import 'package:planets_data/model/planet_response.dart';

/// Esta clase `PlanetsApi` es responsable de realizar solicitudes HTTP para obtener
/// una lista de planetas desde un servidor remoto.
class PlanetsApi {
  // Se crea una instancia de Dio para manejar las solicitudes HTTP.
  final Dio _dio = Dio();

  /// Método `getPlanets`: 
  /// Realiza una solicitud GET a la API para obtener una lista de planetas.
  /// 
  /// - Retorna: Una lista de objetos `PlanetResponse`.
  /// - Lanza una excepción si la solicitud falla.
  /// 
  /// Ejemplo de uso:
  /// ```dart
  /// final planets = await PlanetsApi().getPlanets();
  /// ```
  Future<List<PlanetResponse>> getPlanets() async {
    try {
      // Se realiza la solicitud HTTP a la API
      final response = await _dio.get('https://us-central1-a-academia-espacial.cloudfunctions.net/planets');
      
      // Si la respuesta es exitosa (código 200), se procesa la lista de planetas
      if (response.statusCode == 200) {
        final List<dynamic> planetsData = response.data['data'];
        
        // Se mapea cada entrada de JSON en un objeto PlanetResponse
        return planetsData.map((json) => PlanetResponse.fromJson(json)).toList();
      } else {
        // Si el código de estado no es 200, se lanza una excepción
        throw Exception('Failed to load planets');
      }
    } catch (e) {
      // Si ocurre un error durante la solicitud o procesamiento de datos, se lanza una excepción
      throw Exception('Error fetching planets: $e');
    }
  }
}
