import 'package:dartz/dartz.dart';
import 'package:logger/logger.dart';
import 'package:weather_app/core/errors/failures.dart';
import 'package:weather_app/weather/domain/repositories/weather_repository.dart';
import 'package:weather_app/weather/infraestructure/datasources/local_weather_datasource.dart';
import 'package:weather_app/weather/infraestructure/datasources/remote_weather_datasource.dart';
import 'package:weather_app/weather/infraestructure/dto/get_forecast_response.dart';
import 'package:weather_app/weather/infraestructure/dto/get_weather_response.dart';

class AppWeatherRepository implements WeatherRepository {
  AppWeatherRepository({
    required RemoteWeatherDataSource remoteWeatherDataSource,
    required LocalWeatherDataSource localWeatherDataSource,
  })  : _remoteWeatherDataSource = remoteWeatherDataSource,
        _localWeatherDataSource = localWeatherDataSource;

  final RemoteWeatherDataSource _remoteWeatherDataSource;
  final LocalWeatherDataSource _localWeatherDataSource;

  @override
  Future<Either<Failure, GetWeatherResponse>> getWeather(String city) async {
    try {
      final weather = await _remoteWeatherDataSource.getWeather(city);
      return Right(weather);
    } catch (e) {
      Logger().e(e);
      return Left(ServerFailure());
    }
  }

  @override
  Future<Either<Failure, GetForeCastResponse>> getForecast({
    required double lat,
    required double lon,
  }) async {
    try {
      final forecast = await _remoteWeatherDataSource.getForecast(
        lat: lat,
        lon: lon,
      );
      return Right(forecast);
    } catch (e) {
      return Left(ServerFailure());
    }
  }

  @override
  Future<Either<Failure, List<String>>> getLastCities() async {
    try {
      final cities = await _localWeatherDataSource.getLastCities();
      return Right(cities);
    } catch (e) {
      return Left(CacheFailure());
    }
  }

  @override
  Future<Either<Failure, void>> saveLastCity(String city) async {
    try {
      await _localWeatherDataSource.saveLastCity(city);
      return const Right(null);
    } catch (e) {
      return Left(CacheFailure());
    }
  }
}
