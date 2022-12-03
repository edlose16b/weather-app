// ignore_for_file: avoid_dynamic_calls

import 'package:flutter_test/flutter_test.dart';
import 'package:weather_app/weather/domain/entities/clouds.dart';
import 'package:weather_app/weather/domain/entities/main_weather_data.dart';
import 'package:weather_app/weather/domain/entities/weather.dart';
import 'package:weather_app/weather/domain/entities/wind.dart';
import 'package:weather_app/weather/infraestructure/dto/get_weather_response.dart';
import 'package:weather_app/weather/infraestructure/models/coord_model.dart';

import '../../core/jsons.dart';

void main() {
  group('fromJson', () {
    Map<String, dynamic>? jsonMap;

    setUp(() {
      jsonMap = getWeatherJsonReponse;
    });

    test('should return a valid model', () {
      // arrange

      // act
      final result = GetWeatherResponse.fromJson(jsonMap!);

      // assert
      expect(result, isA<GetWeatherResponse>());
      expect(result.coord, isA<CoordModel>());
      expect(result.weather, isA<List<Weather>>());
      expect(result.base, isA<String>());
      expect(result.main, isA<MainWeatherData>());
      expect(result.visibility, isA<int>());
      expect(result.wind, isA<Wind>());
      expect(result.clouds, isA<Clouds>());
      expect(result.dt, isA<int>());
      expect(result.sys, isA<Sys>());
      expect(result.timezone, isA<int>());
      expect(result.id, isA<int>());
      expect(result.name, isA<String>());
      expect(result.cod, isA<int>());
    });

    test('should return a valid model with correct values', () {
      // arrange

      // act
      final result = GetWeatherResponse.fromJson(jsonMap!);

      // assert

      expect(result.coord.lat, getWeatherJsonReponse['coord']['lat']);
      expect(result.coord.lon, getWeatherJsonReponse['coord']['lon']);
      expect(result.weather[0].id, getWeatherJsonReponse['weather'][0]['id']);
      expect(
        result.weather[0].main,
        getWeatherJsonReponse['weather'][0]['main'],
      );
      expect(
        result.weather[0].description,
        getWeatherJsonReponse['weather'][0]['description'],
      );
      expect(
        result.weather[0].icon,
        getWeatherJsonReponse['weather'][0]['icon'],
      );
      expect(result.base, getWeatherJsonReponse['base']);
      expect(result.main.temp, getWeatherJsonReponse['main']['temp']);
      expect(
        result.main.feelsLike,
        getWeatherJsonReponse['main']['feels_like'],
      );
      expect(result.main.tempMin, getWeatherJsonReponse['main']['temp_min']);
      expect(result.main.tempMax, getWeatherJsonReponse['main']['temp_max']);
      expect(result.main.pressure, getWeatherJsonReponse['main']['pressure']);
      expect(result.main.humidity, getWeatherJsonReponse['main']['humidity']);
      expect(result.visibility, getWeatherJsonReponse['visibility']);
      expect(result.wind.speed, getWeatherJsonReponse['wind']['speed']);
    });

    test('should return a valid model when the JSON contains an extra field',
        () {
      // arrange
      jsonMap!['extra'] = 'extra';

      // act
      final result = GetWeatherResponse.fromJson(jsonMap!);
      // assert
      expect(result, isA<GetWeatherResponse>());
    });

    test(
        'should throw a [TypeError] when the JSON contains a null required '
        'value ', () {
      // arrange
      jsonMap!['weather'] = null;

      expect(
        //act
        () => GetWeatherResponse.fromJson(jsonMap!),

        // assert
        throwsA(isA<TypeError>()),
      );
    });
  });

  group('toJson', () {
    test('should return a valid json', () {
      // act
      final result = getWeatherResponseExampleModel.toJson();

      // assert
      expect(result, isA<Map<String, dynamic>>());
    });

    test('should return a json with correct values', () {
      // act
      final result = getWeatherResponseExampleModel.toJson();

      // assert
      expect(result['coord']['lat'], getWeatherResponseExampleModel.coord.lat);
      expect(result['coord']['lon'], getWeatherResponseExampleModel.coord.lon);
      expect(
        result['weather'][0]['id'],
        getWeatherResponseExampleModel.weather[0].id,
      );
      expect(
        result['weather'][0]['main'],
        getWeatherResponseExampleModel.weather[0].main,
      );
      expect(
        result['weather'][0]['description'],
        getWeatherResponseExampleModel.weather[0].description,
      );
      expect(
        result['weather'][0]['icon'],
        getWeatherResponseExampleModel.weather[0].icon,
      );
      expect(result['base'], getWeatherResponseExampleModel.base);
      expect(result['main']['temp'], getWeatherResponseExampleModel.main.temp);
      expect(
        result['main']['feels_like'],
        getWeatherResponseExampleModel.main.feelsLike,
      );
      expect(
        result['main']['temp_min'],
        getWeatherResponseExampleModel.main.tempMin,
      );
      expect(
        result['main']['temp_max'],
        getWeatherResponseExampleModel.main.tempMax,
      );
      expect(
        result['main']['pressure'],
        getWeatherResponseExampleModel.main.pressure,
      );
      expect(
        result['main']['humidity'],
        getWeatherResponseExampleModel.main.humidity,
      );
    });
  });
}
