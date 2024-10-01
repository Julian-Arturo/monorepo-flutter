import 'package:injectable/injectable.dart';
import 'package:planets_data/model/http_services_response.dart';
import 'package:planets_data/utils/network/api_config.dart';

/// `PlanetDataSource` es una clase abstracta que define el contrato para obtener
/// los datos de los planetas desde una fuente remota.
abstract class PlanetDataSource {
  /// Método `getPlanets`:
  /// 
  /// - Retorna: Un `Future<HttpServiceResponse>` que contiene la respuesta del servicio HTTP.
  ///   Esta respuesta puede incluir los datos de los planetas en formato JSON o
  ///   algún mensaje de error si la solicitud falla.
  Future<HttpServiceResponse> getPlanets();
}

/// `MessageModalDataSourceImpl` es la implementación concreta de `PlanetDataSource`.
///
/// Esta clase utiliza un servicio HTTP inyectado para realizar la solicitud a la API
/// de planetas. El uso de la anotación `@Injectable` permite que esta clase se integre
/// fácilmente en el contenedor de dependencias.
@Injectable(as: PlanetDataSource)
class MessageModalDataSourceImpl extends PlanetDataSource {
  /// Servicio HTTP inyectado que maneja las solicitudes a la API.
  final HttpService httpService;

  /// Constructor que recibe el servicio HTTP necesario para realizar la solicitud.
  MessageModalDataSourceImpl(this.httpService);

  /// Método `getPlanets`:
  /// 
  /// - Retorna: Un `Future<HttpServiceResponse>` que contiene los datos de los planetas
  ///   obtenidos desde el servicio remoto.
  ///
  /// Este método delega la solicitud al servicio HTTP que está configurado para
  /// realizar la llamada a la API.
  @override
  Future<HttpServiceResponse> getPlanets() {
    return httpService.get("planets");
  }
}
