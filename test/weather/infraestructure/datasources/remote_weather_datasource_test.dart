import 'dart:io';

import 'package:dio/dio.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:weather_app/core/env/env.dart';
import 'package:weather_app/core/errors/exceptions.dart';
import 'package:weather_app/weather/infraestructure/datasources/remote_weather_datasource.dart';
import 'package:weather_app/weather/infraestructure/dto/get_forecast_response.dart';
import 'package:weather_app/weather/infraestructure/dto/get_weather_response.dart';

import '../../core/jsons.dart';

class MockDioClient extends Mock implements Dio {}

class MockEnv extends Mock implements Env {}

void main() {
  late Dio client;
  late Env env;
  late RemoteWeatherDataSource dataSource;

  setUp(() {
    client = MockDioClient();
    env = MockEnv();
    dataSource = OpenWeatherRemoteDataSource(client: client, env: env);

    when(() => env.openWeatherApiKey).thenReturn('123456789');
  });

  group('getWeather', () {
    test('should return [GetWeatherResponse] when status code is 200',
        () async {
      // arrange
      when(
        () => client.get<dynamic>(any()),
      ).thenAnswer(
        (_) async => Response(
          requestOptions: RequestOptions(path: ''),
          data: getWeatherJsonReponse,
          statusCode: HttpStatus.ok,
        ),
      );
      // act

      final response = await dataSource.getWeather('city');

      // assert
      expect(response, isA<GetWeatherResponse>());
      expect(response, equals(getWeatherResponseExampleModel));
    });

    test('should throw [ServerException] when status code is not 200',
        () async {
      // arrange
      when(
        () => client.get<dynamic>(any()),
      ).thenAnswer(
        (_) async => Response(
          requestOptions: RequestOptions(path: ''),
          statusCode: HttpStatus.badRequest,
        ),
      );
      // act

      // assert
      expect(
        () async => dataSource.getWeather('city'),
        throwsA(isA<ServerException>()),
      );
    });
  });

  group('getForecast', () {
    test('should return [GetForeCastResponse] when status code is 200',
        () async {
      // arrange
      when(
        () => client.get<dynamic>(any()),
      ).thenAnswer(
        (_) async => Response(
          requestOptions: RequestOptions(path: ''),
          data: getForeCastJsonResponse,
          statusCode: HttpStatus.ok,
        ),
      );
      // act

      final response = await dataSource.getForecast(lat: 0, lon: 0);

      // assert
      expect(response, isA<GetForeCastResponse>());
      expect(response, equals(getForeCastResponseExampleModel));
    });

    test('should throw [ServerException] when status code is not 200',
        () async {
      // arrange
      when(
        () => client.get<dynamic>(any()),
      ).thenAnswer(
        (_) async => Response(
          requestOptions: RequestOptions(path: ''),
          statusCode: HttpStatus.badRequest,
        ),
      );
      // act

      // assert
      expect(
        () async => dataSource.getForecast(lat: 0, lon: 0),
        throwsA(isA<ServerException>()),
      );
    });
  });
}
