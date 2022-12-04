import 'package:weather_app/weather/domain/entities/wind.dart';

class WindModel extends Wind {
  WindModel({
    required super.speed,
    required super.deg,
    super.gust,
  });

  factory WindModel.fromJson(Map<String, dynamic> json) => WindModel(
        speed: double.parse(json['speed'].toString()),
        deg: json['deg'] as int,
        gust: double.tryParse(json['gust'].toString()),
      );

  Map<String, dynamic> toJson() => {
        'speed': speed,
        'deg': deg,
        'gust': gust,
      };
}
