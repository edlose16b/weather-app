import 'package:envied/envied.dart';

part 'env.g.dart';

abstract class Env {
  late String openWeatherApiUrl;
  late String openWeatherApiKey;
}

@Envied(path: '.env.dev')
class DevEnv implements Env {
  @override
  @EnviedField(varName: 'OPEN_WEATHER_API_KEY', obfuscate: true)
  String openWeatherApiKey = _DevEnv.openWeatherApiKey;

  @override
  @EnviedField(varName: 'OPEN_WEATHER_API_URL', obfuscate: true)
  String openWeatherApiUrl = _DevEnv.openWeatherApiUrl;
}

@Envied(path: '.env')
class ProdEnv implements Env {
  @override
  @EnviedField(varName: 'OPEN_WEATHER_API_URL', obfuscate: true)
  String openWeatherApiKey = _DevEnv.openWeatherApiKey;

  @override
  @EnviedField(varName: 'OPEN_WEATHER_API_URL', obfuscate: true)
  String openWeatherApiUrl = _DevEnv.openWeatherApiUrl;
}
