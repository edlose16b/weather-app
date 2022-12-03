import 'dart:io';

import 'package:dio/dio.dart';
import 'package:weather_app/core/env/env.dart';
import 'package:weather_app/core/errors/exceptions.dart';
import 'package:weather_app/weather/infraestructure/dto/get_forecast_response.dart';
import 'package:weather_app/weather/infraestructure/dto/get_weather_response.dart';

abstract class RemoteWeatherDataSource {
  Future<GetWeatherResponse> getWeather(String city);

  Future<GetForeCastResponse> getForecast({
    required double lat,
    required double lon,
  });
}

class OpenWeatherRemoteDataSource implements RemoteWeatherDataSource {
  OpenWeatherRemoteDataSource({
    required Dio client,
    required Env env,
  })  : _client = client,
        _env = env;

  final Dio _client;
  final Env _env;

  @override
  Future<GetWeatherResponse> getWeather(String city) async {
    try {
      final response = await _client.get<dynamic>(
        'weather?q=$city&appid=${_env.openWeatherApiKey}&lang=es&units=metric',
      );

      if (response.statusCode != HttpStatus.ok) throw ServerException();

      return GetWeatherResponse.fromJson(
        response.data as Map<String, dynamic>,
      );
    } catch (e) {
      throw ServerException();
    }
  }

  @override
  Future<GetForeCastResponse> getForecast({
    required double lat,
    required double lon,
  }) async {
    try {
      final response = await _client.get<dynamic>(
        'forecast?lat=$lat&lon=$lon&appid=${_env.openWeatherApiKey}&lang=es&'
        'units=metric&cnt=1',
      );

      if (response.statusCode != HttpStatus.ok) throw ServerException();

      return GetForeCastResponse.fromJson(
        response.data as Map<String, dynamic>,
      );
    } catch (e) {
      throw ServerException();
    }
  }
}
