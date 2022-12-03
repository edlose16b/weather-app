import 'package:dartz/dartz.dart';
import 'package:weather_app/core/errors/failures.dart';
import 'package:weather_app/weather/domain/repositories/weather_repository.dart';
import 'package:weather_app/weather/infraestructure/datasources/remote_weather_datasource.dart';
import 'package:weather_app/weather/infraestructure/dto/get_forecast_response.dart';
import 'package:weather_app/weather/infraestructure/dto/get_weather_response.dart';

class ApiWeatherRepository implements WeatherRepository {
  ApiWeatherRepository({
    required RemoteWeatherDataSource remoteWeatherDataSource,
  }) : _remoteWeatherDataSource = remoteWeatherDataSource;

  final RemoteWeatherDataSource _remoteWeatherDataSource;
  @override
  Future<Either<Failure, GetWeatherResponse>> getWeather(String city) async {
    try {
      final weather = await _remoteWeatherDataSource.getWeather(city);
      return Right(weather);
    } catch (e) {
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
}
