import 'package:weather_app/weather/domain/entities/weather.dart';

class WeatherModel extends Weather {
  WeatherModel({
    required super.id,
    required super.main,
    required super.description,
    required super.icon,
  });

  factory WeatherModel.fromJson(Map<String, dynamic> json) => WeatherModel(
        id: json['id'] as int,
        main: json['main'] as String,
        description: json['description'] as String,
        icon: json['icon'] as String,
      );

  Map<String, dynamic> toJson() => {
        'id': id,
        'main': main,
        'description': description,
        'icon': icon,
      };
}
