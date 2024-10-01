import 'package:planets_data/model/planet_model.dart';

/// Clase que modela la respuesta del servicio HTTP
class HttpServiceResponse {
  final bool success; // Indica si la petición fue exitosa o no
  final String? message; // Mensaje opcional de la respuesta
  final List<Planet>? planets; // Lista opcional de planetas recibidos

  /// Constructor de la clase [HttpServiceResponse].
  HttpServiceResponse({
    required this.success,
    this.message,
    this.planets,
  });
}
