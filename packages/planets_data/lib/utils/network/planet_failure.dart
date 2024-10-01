/// La clase `PlanetFailure` implementa una excepción personalizada para manejar
/// los errores relacionados con la obtención de datos de planetas.
class PlanetFailure implements Exception {
  /// Mensaje descriptivo del error.
  final String message;

  /// Constructor de `PlanetFailure`, requiere un mensaje que describa el error.
  PlanetFailure({required this.message});

  /// Sobrescribe el método `toString` para proporcionar una representación
  /// legible del error que incluye el mensaje.
  @override
  String toString() => 'PlanetFailure: $message';
}
