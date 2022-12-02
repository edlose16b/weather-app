import 'package:weather_app/weather/domain/entities/main_weather_data.dart';

class MainWeatherDataModel extends MainWeatherData {
  MainWeatherDataModel({
    required super.temp,
    required super.feelsLike,
    required super.tempMin,
    required super.tempMax,
    required super.pressure,
    required super.humidity,
    super.seaLevel,
    super.grndLevel,
    super.tempKf,
  });

  factory MainWeatherDataModel.fromJson(Map<String, dynamic> json) =>
      MainWeatherDataModel(
        temp: double.parse(json['temp'].toString()),
        feelsLike: double.parse(json['feels_like'].toString()),
        tempMin: double.parse(json['temp_min'].toString()),
        tempMax: double.parse(json['temp_max'].toString()),
        pressure: json['pressure'] as int,
        seaLevel: json['sea_level'] as int?,
        grndLevel: json['grnd_level'] as int?,
        humidity: json['humidity'] as int,
        tempKf: double.tryParse(json['temp_kf'].toString()),
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
