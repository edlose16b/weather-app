// ignore_for_file: avoid_dynamic_calls

import 'package:flutter_test/flutter_test.dart';
import 'package:weather_app/weather/domain/entities/city.dart';
import 'package:weather_app/weather/infraestructure/dto/get_forecast_response.dart';

import '../../core/jsons.dart';

void main() {
  group('fromJson', () {
    Map<String, dynamic>? jsonMap;

    setUp(() {
      jsonMap = getForeCastJsonResponse;
    });

    test('should return a valid model', () {
      // arrange

      // act
      final result = GetForeCastResponse.fromJson(jsonMap!);

      // assert
      expect(result, isA<GetForeCastResponse>());
      expect(result.cod, isA<String>());
      expect(result.message, isA<int>());
      expect(result.cnt, isA<int>());
      expect(result.list, isA<List<ForeCastItemResponse>>());
      expect(result.city, isA<City>());
    });

    test('should return a valid model with correct values', () {
      // arrange

      // act
      final result = GetForeCastResponse.fromJson(jsonMap!);

      // assert
      expect(
        result.cod,
        getForeCastJsonResponse['cod'],
      );
      expect(
        result.message,
        getForeCastJsonResponse['message'],
      );
      expect(
        result.cnt,
        getForeCastJsonResponse['cnt'],
      );
      expect(
        result.list[0].dt,
        getForeCastJsonResponse['list'][0]['dt'],
      );
      expect(
        result.list[0].main.temp,
        getForeCastJsonResponse['list'][0]['main']['temp'],
      );
      expect(
        result.list[0].main.feelsLike,
        getForeCastJsonResponse['list'][0]['main']['feels_like'],
      );
      expect(
        result.list[0].main.tempMin,
        getForeCastJsonResponse['list'][0]['main']['temp_min'],
      );
      expect(
        result.list[0].main.tempMax,
        getForeCastJsonResponse['list'][0]['main']['temp_max'],
      );
      expect(
        result.list[0].main.pressure,
        getForeCastJsonResponse['list'][0]['main']['pressure'],
      );
      expect(
        result.list[0].main.seaLevel,
        getForeCastJsonResponse['list'][0]['main']['sea_level'],
      );
      expect(
        result.list[0].main.grndLevel,
        getForeCastJsonResponse['list'][0]['main']['grnd_level'],
      );
      expect(
        result.list[0].main.humidity,
        getForeCastJsonResponse['list'][0]['main']['humidity'],
      );
      expect(
        result.list[0].main.tempKf,
        getForeCastJsonResponse['list'][0]['main']['temp_kf'],
      );
      expect(
        result.list[0].weather[0].id,
        getForeCastJsonResponse['list'][0]['weather'][0]['id'],
      );
      expect(
        result.list[0].weather[0].main,
        getForeCastJsonResponse['list'][0]['weather'][0]['main'],
      );
      expect(
        result.list[0].weather[0].description,
        getForeCastJsonResponse['list'][0]['weather'][0]['description'],
      );
      expect(
        result.list[0].weather[0].icon,
        getForeCastJsonResponse['list'][0]['weather'][0]['icon'],
      );
      expect(
        result.list[0].clouds.all,
        getForeCastJsonResponse['list'][0]['clouds']['all'],
      );
    });

    test('should return a valid model when the JSON contains an extra field',
        () {
      // arrange
      jsonMap!['extra'] = 'extra';

      // act
      final result = GetForeCastResponse.fromJson(jsonMap!);
      // assert
      expect(result, isA<GetForeCastResponse>());
    });

    test(
        'should throw a [TypeError] when the JSON contains a null required '
        'value ', () {
      // arrange
      jsonMap!['list'] = null;

      expect(
        //act
        () => GetForeCastResponse.fromJson(jsonMap!),

        // assert
        throwsA(isA<TypeError>()),
      );
    });
  });

  group('toJson', () {
    test('should return a valid json', () {
      // act
      final result = getForeCastResponseExampleModel.toJson();

      // assert
      expect(result, isA<Map<String, dynamic>>());
    });

    test('should return a valid json with correct values', () {
      // act
      final result = getForeCastResponseExampleModel.toJson();

      // assert
      expect(result['cod'], getForeCastResponseExampleModel.cod);
      expect(result['message'], getForeCastResponseExampleModel.message);
      expect(result['cnt'], getForeCastResponseExampleModel.cnt);
      expect(
        result['list'][0]['dt'],
        getForeCastResponseExampleModel.list[0].dt,
      );
      expect(
        result['list'][0]['main']['temp'],
        getForeCastResponseExampleModel.list[0].main.temp,
      );
      expect(
        result['list'][0]['main']['feels_like'],
        getForeCastResponseExampleModel.list[0].main.feelsLike,
      );
      expect(
        result['list'][0]['main']['temp_min'],
        getForeCastResponseExampleModel.list[0].main.tempMin,
      );
      expect(
        result['list'][0]['main']['temp_max'],
        getForeCastResponseExampleModel.list[0].main.tempMax,
      );
      expect(
        result['list'][0]['main']['pressure'],
        getForeCastResponseExampleModel.list[0].main.pressure,
      );
      expect(
        result['list'][0]['main']['sea_level'],
        getForeCastResponseExampleModel.list[0].main.seaLevel,
      );
      expect(
        result['list'][0]['main']['grnd_level'],
        getForeCastResponseExampleModel.list[0].main.grndLevel,
      );
      expect(
        result['list'][0]['main']['humidity'],
        getForeCastResponseExampleModel.list[0].main.humidity,
      );
      expect(
        result['list'][0]['main']['temp_kf'],
        getForeCastResponseExampleModel.list[0].main.tempKf,
      );
      expect(
        result['list'][0]['weather'][0]['id'],
        getForeCastResponseExampleModel.list[0].weather[0].id,
      );
      expect(
        result['list'][0]['weather'][0]['main'],
        getForeCastResponseExampleModel.list[0].weather[0].main,
      );
    });
  });
}
