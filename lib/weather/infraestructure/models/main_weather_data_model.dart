import 'package:weather_app/weather/domain/entities/main_weather_data.dart';

class MainWeatherDataModel extends MainWeatherData {
  MainWeatherDataModel({
    required super.temp,
    required super.feelsLike,
    required super.tempMin,
    required super.tempMax,
    required super.pressure,
    required super.seaLevel,
    required super.grndLevel,
    required super.humidity,
    required super.tempKf,
  });

  factory MainWeatherDataModel.fromJson(Map<String, dynamic> json) =>
      MainWeatherDataModel(
        temp: double.parse(json['temp'] as String),
        feelsLike: double.parse(json['feels_like'] as String),
        tempMin: double.parse(json['temp_min'] as String),
        tempMax: double.parse(json['temp_max'] as String),
        pressure: json['pressure'] as int,
        seaLevel: json['sea_level'] as int,
        grndLevel: json['grnd_level'] as int,
        humidity: json['humidity'] as int,
        tempKf: double.parse(json['temp_kf'] as String),
      );

  Map<String, dynamic> toJson() => {
        'temp': temp,
        'feels_like': feelsLike,
        'temp_min': tempMin,
        'temp_max': tempMax,
        'pressure': pressure,
        'sea_level': seaLevel,
        'grnd_level': grndLevel,
        'humidity': humidity,
        'temp_kf': tempKf,
      };
}
