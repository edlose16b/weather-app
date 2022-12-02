import 'package:dartz/dartz.dart';
import 'package:weather_app/core/errors/failures.dart';
import 'package:weather_app/weather/infraestructure/dto/get_weather_response.dart';
import 'package:weather_app/weather/infraestructure/repositories/weather_repository.dart';

class ApiWeatherRepository implements WeatherRepository {
  @override
  Future<Either<Failure, GetWeatherResponse>> getWeather(String city) {
    // TODO: implement getWeather
    throw UnimplementedError();
  }

  @override
  Future<Either<Failure, dynamic>> getForecast({
    required double lat,
    required double lon,
  }) {
    // TODO: implement getForecast
    throw UnimplementedError();
  }
}
