import 'package:flutter_test/flutter_test.dart';
import 'package:planets_data/model/planet_response.dart';
import 'package:planets_data/src/planet_api.dart';

void main() {
  group('PlanetsApi', () {
    test('can be instantiated', () {
      final planetsApi = PlanetsApi();
      expect(planetsApi, isNotNull);
    });

    test('returns a list of planets when the response is successful', () async {
      final planetsApi = PlanetsApi();
      final planets = await planetsApi.getPlanets();
      
      expect(planets, isA<List<PlanetResponse>>());
      expect(planets.isNotEmpty, true); 
    });

    test('throws an exception when the response is unsuccessful', () async {
      final planetsApi = PlanetsApi();
      try {
        await planetsApi.getPlanets();
      } catch (e) {
        expect(e, isA<Exception>());
      }
    });
  });
}
