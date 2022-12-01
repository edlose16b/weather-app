import 'package:dartz/dartz.dart';
import 'package:weather_app/core/errors/failures.dart';

abstract class WeatherRepository {
  Future<Either<Failure, dynamic>> getWeather(String city);
}
