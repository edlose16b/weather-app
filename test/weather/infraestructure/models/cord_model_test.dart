import 'package:flutter_test/flutter_test.dart';
import 'package:weather_app/weather/domain/entities/weather.dart';
import 'package:weather_app/weather/infraestructure/models/weather_model.dart';

void main() {
  test('should be a subclass of Weather entity', () {
    final model = WeatherModel(
      id: 1,
      main: 'main',
      description: 'description',
      icon: 'icon',
    );

    expect(model, isA<Weather>());
  });

  group('from json', () {
    Map<String, dynamic>? jsonMap;

    setUp(() {
      jsonMap = <String, dynamic>{
        'id': 1,
        'main': 'main',
        'description': 'description',
        'icon': 'icon',
      };
    });

    test('should return a valid model', () {
      // arrange

      // act
      final result = WeatherModel.fromJson(jsonMap!);

      // assert
      expect(result, isA<WeatherModel>());
    });

    test('should return a model with correct fields', () {
      final model = WeatherModel.fromJson(jsonMap!);

      expect(model.id, 1);
      expect(model.main, 'main');
      expect(model.description, 'description');
      expect(model.icon, 'icon');
    });

    test('should return a valid model when the JSON contains an extra field',
        () {
      // arrange
      jsonMap!['extra'] = 'extra';

      // act
      final result = WeatherModel.fromJson(jsonMap!);
      // assert
      expect(result, isA<WeatherModel>());
    });

    test('should throw a [TypeError] when the JSON contains a null field', () {
      // arrange
      jsonMap!['id'] = null;

      expect(
        //act
        () => WeatherModel.fromJson(jsonMap!),

        // assert
        throwsA(isA<TypeError>()),
      );
    });
  });

  group('toJson', () {
    test('should return a JSON map containing the proper data', () {
      // arrange
      final model = WeatherModel(
        id: 1,
        main: 'main',
        description: 'description',
        icon: 'icon',
      );

      // act
      final result = model.toJson();

      // assert
      final expectedJsonMap = <String, dynamic>{
        'id': 1,
        'main': 'main',
        'description': 'description',
        'icon': 'icon',
      };

      expect(result, expectedJsonMap);
    });
  });
}
