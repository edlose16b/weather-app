import 'package:dartz/dartz.dart';
import 'package:weather_app/core/errors/failures.dart';
import 'package:weather_app/weather/infraestructure/dto/get_forecast_response.dart';
import 'package:weather_app/weather/infraestructure/dto/get_weather_response.dart';

abstract class WeatherRepository {
  Future<Either<Failure, GetWeatherResponse>> getWeather(String city);

  Future<Either<Failure, GetForeCastResponse>> getForecast({
    required double lat,
    required double lon,
  });

  Future<Either<Failure, List<String>>> getLastCities();
  Future<Either<Failure, void>> saveLastCity(String city);
}
