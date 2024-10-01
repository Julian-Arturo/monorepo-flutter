import 'package:planets_data/model/planet_model.dart';

class PlanetResponse {
  final String msg;
  final List<Planet> data;

  PlanetResponse({
    required this.msg,
    required this.data,
  });

  factory PlanetResponse.fromJson(Map<String, dynamic> json) {
    return PlanetResponse(
      msg: json['msg'] ?? 'No message provided',
      data: List<Planet>.from(
        (json['data'] ?? []).map((planet) => Planet.fromJson(planet)),
      ),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'msg': msg,
      'data': data.map((planet) => planet.toJson()).toList(),
    };
  }
}
