import 'package:weather_app/weather/domain/entities/wind.dart';

class WindModel extends Wind {
  WindModel({
    required super.speed,
    required super.deg,
  });

  factory WindModel.fromJson(Map<String, dynamic> json) => WindModel(
        speed: double.parse(json['speed'].toString()),
        deg: json['deg'] as int,
      );

  Map<String, dynamic> toJson() => {
        'speed': speed,
        'deg': deg,
      };
}
