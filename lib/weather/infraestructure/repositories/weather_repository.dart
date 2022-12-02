import 'package:dartz/dartz.dart';
import 'package:weather_app/core/errors/failures.dart';
import 'package:weather_app/weather/infraestructure/dto/get_weather_response.dart';

abstract class WeatherRepository {
  Future<Either<Failure, GetWeatherReponse>> getWeather(String city);

  Future<Either<Failure, dynamic>> getForecast({
    required double lat,
    required double lon,
  });
}
