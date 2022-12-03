import 'package:weather_app/weather/infraestructure/models/coord_model.dart';

class City {
  City({
    required this.id,
    required this.name,
    required this.coord,
    required this.country,
    required this.population,
    required this.timezone,
    required this.sunrise,
    required this.sunset,
  });

  final int id;
  final String name;
  final CoordModel coord;
  final String country;
  final int population;
  final int timezone;
  final int sunrise;
  final int sunset;
}
