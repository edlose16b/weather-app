import 'package:flutter_test/flutter_test.dart';
import 'package:weather_app/weather/domain/entities/wind.dart';
import 'package:weather_app/weather/infraestructure/models/wind_model.dart';

void main() {
  test('should be a subclass of Wind entity', () {
    final model = WindModel(
      speed: 1.2,
      deg: 1,
    );

    expect(model, isA<Wind>());
  });

  group('from json', () {
    Map<String, dynamic>? jsonMap;

    setUp(() {
      jsonMap = <String, dynamic>{
        'speed': 1.2,
        'deg': 1,
      };
    });

    test('should return a valid model', () {
      // arrange

      // act
      final result = WindModel.fromJson(jsonMap!);

      // assert
      expect(result, isA<WindModel>());
    });

    test('should return a model with correct fields', () {
      final model = WindModel.fromJson(jsonMap!);

      expect(model.speed, 1.2);
      expect(model.deg, 1);
    });

    test('should return a valid model when the JSON contains an extra field',
        () {
      // arrange
      jsonMap!['extra'] = 'extra';

      // act
      final result = WindModel.fromJson(jsonMap!);
      // assert
      expect(result, isA<WindModel>());
    });

    test(
        'should throw a [FormatException] when the JSON contains a null value '
        ' in double field', () {
      // arrange
      jsonMap!['speed'] = null;

      expect(
        // act
        () => WindModel.fromJson(jsonMap!),
        // assert
        throwsA(isA<FormatException>()),
      );
    });

    test(
        'should throw a [TypeError] when the JSON contains a null value '
        ' in int field', () {
      // arrange
      jsonMap!['deg'] = null;

      expect(
        // act
        () => WindModel.fromJson(jsonMap!),
        // assert
        throwsA(isA<TypeError>()),
      );
    });
  });

  group('to json', () {
    test('should return a JSON map containing the proper data', () {
      // arrange
      final model = WindModel(
        speed: 1.2,
        deg: 1,
      );

      // act
      final result = model.toJson();

      // assert
      final expectedJsonMap = <String, dynamic>{
        'speed': 1.2,
        'deg': 1,
      };

      expect(result, expectedJsonMap);
    });
  });
}
