import 'package:weather_app/weather/domain/entities/city.dart';
import 'package:weather_app/weather/infraestructure/models/coord_model.dart';

class CityModel extends City {
  CityModel({
    required super.id,
    required super.name,
    required super.coord,
    required super.country,
    required super.population,
    required super.timezone,
    required super.sunrise,
    required super.sunset,
  });

  factory CityModel.fromJson(Map<String, dynamic> json) => CityModel(
        id: json['id'] as int,
        name: json['name'] as String,
        coord: CoordModel.fromJson(json['coord'] as Map<String, dynamic>),
        country: json['country'] as String,
        population: json['population'] as int,
        timezone: json['timezone'] as int,
        sunrise: json['sunrise'] as int,
        sunset: json['sunset'] as int,
      );

  Map<String, dynamic> toJson() => {
        'id': id,
        'name': name,
        'coord': coord.toJson(),
        'country': country,
        'population': population,
        'timezone': timezone,
        'sunrise': sunrise,
        'sunset': sunset,
      };
}
