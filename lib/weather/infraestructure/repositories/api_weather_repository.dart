import 'package:dartz/dartz.dart';
import 'package:weather_app/core/errors/failures.dart';
import 'package:weather_app/weather/infraestructure/dto/get_forecast_response.dart';
import 'package:weather_app/weather/infraestructure/dto/get_weather_response.dart';
import 'package:weather_app/weather/domain/repositories/weather_repository.dart';

class ApiWeatherRepository implements WeatherRepository {
  @override
  Future<Either<Failure, GetWeatherResponse>> getWeather(String city) {
    // TODO: implement getWeather
    throw UnimplementedError();
  }

  @override
  Future<Either<Failure, GetForeCastResponse>> getForecast({
    required double lat,
    required double lon,
  }) {
    // TODO: implement getForecast
    throw UnimplementedError();
  }
}
