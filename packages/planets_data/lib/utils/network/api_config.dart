import 'dart:async';
import 'dart:convert';
import 'dart:io';
import 'package:http/http.dart' as http;
import 'package:injectable/injectable.dart';
import 'package:planets_data/model/http_services_response.dart';
import 'package:planets_data/model/planet_model.dart';

/// Configuración de la API, donde se define la URL base del servicio
class ApiConfig {
  static const String baseUrl = 'https://us-central1-a-academia-espacial.cloudfunctions.net/';
}

/// Servicio HTTP que se encarga de realizar las peticiones al servidor
@Injectable()
class HttpService {
  final String url = ApiConfig.baseUrl; // URL base de la API

  String timeoutMessage = 'Latencia'; // Mensaje para el tiempo de espera excedido
  String errorInternet = 'Sin internet'; // Mensaje para errores de conexión a internet

  /// Método para realizar una petición GET al servidor.
  /// [endpoint] es el endpoint específico al que se quiere acceder.
  Future<HttpServiceResponse> get(String endpoint) async {
    try {
      // Realiza la petición GET a la API
      final response = await http.get(Uri.parse("$url/$endpoint"));

      // Valida la respuesta recibida
      return _validateResponse(response);
    } on SocketException {
      // Retorna un mensaje de error en caso de no haber conexión a internet
      return HttpServiceResponse(success: false, message: errorInternet);
    } on TimeoutException {
      // Retorna un mensaje de error en caso de que la petición exceda el tiempo límite
      return HttpServiceResponse(success: false, message: timeoutMessage);
    } catch (e) {
      // Retorna un mensaje de error genérico en caso de alguna excepción no controlada
      return HttpServiceResponse(success: false, message: "Error: $e");
    }
  }

  /// Método para validar la respuesta HTTP recibida
  /// [response] es la respuesta del servidor después de la petición GET.
  HttpServiceResponse _validateResponse(http.Response response) {
    if (response.statusCode == 200 || response.statusCode == 201) {
      // Si la respuesta es exitosa, se parsea el cuerpo del mensaje
      final body = json.decode(response.body);
      final msg = body['msg'] ?? 'Sin mensaje'; // Mensaje opcional de respuesta
      final List<dynamic> planetsData = body['data'] ?? []; // Lista de datos de los planetas

      // Se mapea la lista de planetas desde el JSON a objetos de tipo Planet
      final planets = planetsData.map((planet) => Planet.fromJson(planet)).toList();

      // Retorna una respuesta exitosa con la lista de planetas
      return HttpServiceResponse(
        success: true,
        message: msg,
        planets: planets,
      );
    } else {
      // Si el código de estado no es exitoso, se retorna un error con el código de estado
      return HttpServiceResponse(
        success: false,
        message: 'Error: ${response.statusCode}',
      );
    }
  }
}

