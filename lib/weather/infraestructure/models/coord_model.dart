import 'package:weather_app/weather/domain/entities/coord.dart';

class CoordModel extends Coord {
  CoordModel({
    required super.lon,
    required super.lat,
  });

  factory CoordModel.fromJson(Map<String, dynamic> json) => CoordModel(
        lon: double.parse(json['lon'] as String),
        lat: double.parse(json['lat'] as String),
      );

  Map<String, dynamic> toJson() => {
        'lon': lon,
        'lat': lat,
      };
}
