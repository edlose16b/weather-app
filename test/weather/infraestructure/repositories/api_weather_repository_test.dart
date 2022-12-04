import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:weather_app/core/errors/failures.dart';
import 'package:weather_app/weather/domain/repositories/weather_repository.dart';
import 'package:weather_app/weather/infraestructure/datasources/local_weather_datasource.dart';
import 'package:weather_app/weather/infraestructure/datasources/remote_weather_datasource.dart';
import 'package:weather_app/weather/infraestructure/repositories/weather_repository.dart';

import '../../core/jsons.dart';

class MockRemoteWeatherDataSource extends Mock
    implements RemoteWeatherDataSource {}

class MockLocalWeatherDataSource extends Mock
    implements LocalWeatherDataSource {}

void main() {
  late RemoteWeatherDataSource dataSource;
  late LocalWeatherDataSource localDataSource;
  late WeatherRepository repository;

  setUp(() {
    dataSource = MockRemoteWeatherDataSource();
    localDataSource = MockLocalWeatherDataSource();
    repository = AppWeatherRepository(
      remoteWeatherDataSource: dataSource,
      localWeatherDataSource: localDataSource,
    );
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

  group('getLastCities', () {
    test('should return a list of cities', () async {
      // arrange
      when(() => localDataSource.getLastCities()).thenAnswer(
        (_) async => ['London', 'Madrid'],
      );

      // act
      final result = await repository.getLastCities();

      result.fold((l) => null, (r) {
        // assert
        expect(r, ['London', 'Madrid']);
      });
    });

    test('should return a ServerFailure when it fails', () async {
      // arrange
      when(() => localDataSource.getLastCities()).thenThrow(Exception());
      // act
      final result = await repository.getLastCities();
      // assert
      expect(result, Left(CacheFailure()));
    });
  });
}
