import 'package:weather_app/core/errors/failures.dart';
import 'package:dartz/dartz.dart';
import 'package:weather_app/weather/infraestructure/repositories/weather_repository.dart';

class ApiWeatherRepository implements WeatherRepository {
  @override
  Future<Either<Failure, dynamic>> getWeather(String city) {
    // TODO: implement getWeather
    throw UnimplementedError();
  }
}
