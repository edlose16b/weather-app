import 'package:flutter_test/flutter_test.dart';
import 'package:weather_app/weather/domain/entities/main_weather_data.dart';
import 'package:weather_app/weather/infraestructure/models/main_weather_data_model.dart';

void main() {
  test('should be a subclass of MainWeatherData entity', () {
    final model = MainWeatherDataModel(
      temp: 1,
      feelsLike: 1,
      tempMin: 1,
      tempMax: 1,
      pressure: 1,
      humidity: 1,
      grndLevel: 1,
      seaLevel: 1,
      tempKf: 2,
    );

    expect(model, isA<MainWeatherData>());
  });

  group('from json', () {
    Map<String, dynamic>? jsonMap;

    setUp(() {
      jsonMap = <String, dynamic>{
        'temp': 1,
        'feels_like': 1,
        'temp_min': 1,
        'temp_max': 1,
        'pressure': 1,
        'humidity': 1,
        'grnd_level': 1,
        'sea_level': 1,
        'temp_kf': 2,
      };
    });

    test('should return a valid model', () {
      // arrange

      // act
      final result = MainWeatherDataModel.fromJson(jsonMap!);

      // assert
      expect(result, isA<MainWeatherDataModel>());
    });

    test('should return a model with correct fields', () {
      final model = MainWeatherDataModel.fromJson(jsonMap!);

      expect(model.temp, 1);
      expect(model.feelsLike, 1);
      expect(model.tempMin, 1);
      expect(model.tempMax, 1);
      expect(model.pressure, 1);
      expect(model.humidity, 1);
      expect(model.grndLevel, 1);
      expect(model.seaLevel, 1);
      expect(model.tempKf, 2);
    });

    test('should return a valid model when the JSON contains an extra field',
        () {
      // arrange
      jsonMap!['extra'] = 'extra';

      // act
      final result = MainWeatherDataModel.fromJson(jsonMap!);
      // assert
      expect(result, isA<MainWeatherDataModel>());
    });

    test(
        'should throw a [FormatException] when the JSON contains a null value '
        ' in double field', () {
      // arrange
      jsonMap!['temp'] = null;

      expect(
        //act
        () => MainWeatherDataModel.fromJson(jsonMap!),

        // assert
        throwsA(isA<FormatException>()),
      );
    });
  });

  group('to json', () {
    test('should return a JSON map containing the proper data', () {
      // arrange
      final model = MainWeatherDataModel(
        temp: 1,
        feelsLike: 1,
        tempMin: 1,
        tempMax: 1,
        pressure: 1,
        humidity: 1,
        grndLevel: 1,
        seaLevel: 1,
        tempKf: 2,
      );

      // act
      final result = model.toJson();

      // assert
      final expectedJsonMap = <String, dynamic>{
        'temp': 1,
        'feels_like': 1,
        'temp_min': 1,
        'temp_max': 1,
        'pressure': 1,
        'humidity': 1,
        'grnd_level': 1,
        'sea_level': 1,
        'temp_kf': 2,
      };

      expect(result, expectedJsonMap);
    });
  });
}
