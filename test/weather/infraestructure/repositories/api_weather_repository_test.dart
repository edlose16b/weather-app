import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:weather_app/core/errors/failures.dart';
import 'package:weather_app/weather/domain/repositories/weather_repository.dart';
import 'package:weather_app/weather/infraestructure/datasources/remote_weather_datasource.dart';
import 'package:weather_app/weather/infraestructure/repositories/api_weather_repository.dart';

import '../../core/jsons.dart';

class MockRemoteWeatherDataSource extends Mock
    implements RemoteWeatherDataSource {}

void main() {
  late RemoteWeatherDataSource dataSource;
  late WeatherRepository repository;

  setUp(() {
    dataSource = MockRemoteWeatherDataSource();
    repository = ApiWeatherRepository(remoteWeatherDataSource: dataSource);
  });

  group('getWeather', () {
    test('should return a WeatherResponse when it is success', () async {
      // arrange
      when(() => dataSource.getWeather(any())).thenAnswer(
        (_) async => getWeatherResponseExampleModel,
      );
      // act
      final result = await repository.getWeather('London');
      // assert
      expect(result, Right(getWeatherResponseExampleModel));
    });

    test('should return a ServerFailure when it fails', () async {
      // arrange
      when(() => dataSource.getWeather(any())).thenThrow(Exception());
      // act
      final result = await repository.getWeather('London');
      // assert
      expect(result, Left(ServerFailure()));
    });
  });

  group('getForecast', () {
    test('should return a WeatherResponse when it is success', () async {
      // arrange
      when(
        () => dataSource.getForecast(
          lat: any(named: 'lat'),
          lon: any(named: 'lon'),
        ),
      ).thenAnswer(
        (_) async => getForeCastResponseExampleModel,
      );
      // act
      final result = await repository.getForecast(lat: 1, lon: 1);
      // assert
      expect(result, Right(getForeCastResponseExampleModel));
    });

    test('should return a ServerFailure when it fails', () async {
      // arrange
      when(
        () => dataSource.getForecast(
          lat: any(named: 'lat'),
          lon: any(named: 'lon'),
        ),
      ).thenThrow(Exception());
      // act
      final result = await repository.getForecast(lat: 1, lon: 1);
      // assert
      expect(result, Left(ServerFailure()));
    });
  });
}
