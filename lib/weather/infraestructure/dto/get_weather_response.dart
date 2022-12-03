import 'package:equatable/equatable.dart';
import 'package:weather_app/weather/infraestructure/models/clouds_model.dart';
import 'package:weather_app/weather/infraestructure/models/coord_model.dart';
import 'package:weather_app/weather/infraestructure/models/main_weather_data_model.dart';
import 'package:weather_app/weather/infraestructure/models/weather_model.dart';
import 'package:weather_app/weather/infraestructure/models/wind_model.dart';

class GetWeatherResponse extends Equatable {
  const GetWeatherResponse({
    required this.coord,
    required this.weather,
    required this.base,
    required this.main,
    required this.visibility,
    required this.wind,
    required this.clouds,
    required this.dt,
    required this.sys,
    required this.timezone,
    required this.id,
    required this.name,
    required this.cod,
  });

  factory GetWeatherResponse.fromJson(Map<String, dynamic> json) =>
      GetWeatherResponse(
        coord: CoordModel.fromJson(
          Map<String, dynamic>.from(json['coord'] as Map),
        ),
        weather: List<WeatherModel>.from(
          List<Map<String, dynamic>>.from(json['weather'] as List)
              .map(WeatherModel.fromJson),
        ),
        base: json['base'] as String,
        main:
            MainWeatherDataModel.fromJson(json['main'] as Map<String, dynamic>),
        visibility: json['visibility'] as int,
        wind: WindModel.fromJson(json['wind'] as Map<String, dynamic>),
        clouds: CloudsModel.fromJson(json['clouds'] as Map<String, dynamic>),
        dt: json['dt'] as int,
        sys: Sys.fromJson(json['sys'] as Map<String, dynamic>),
        timezone: json['timezone'] as int,
        id: json['id'] as int,
        name: json['name'] as String,
        cod: json['cod'] as int,
      );

  final CoordModel coord;
  final List<WeatherModel> weather;
  final String base;
  final MainWeatherDataModel main;
  final int visibility;
  final WindModel wind;
  final CloudsModel clouds;
  final int dt;
  final Sys sys;
  final int timezone;
  final int id;
  final String name;
  final int cod;

  Map<String, dynamic> toJson() => {
        'coord': coord.toJson(),
        'weather': List<dynamic>.from(weather.map((x) => x.toJson())),
        'base': base,
        'main': main.toJson(),
        'visibility': visibility,
        'wind': wind.toJson(),
        'clouds': clouds.toJson(),
        'dt': dt,
        'sys': sys.toJson(),
        'timezone': timezone,
        'id': id,
        'name': name,
        'cod': cod,
      };

  @override
  List<Object?> get props => [
        coord,
        weather,
        base,
        main,
        visibility,
        wind,
        clouds,
        dt,
        sys,
        timezone,
        id,
        name,
        cod,
      ];
}

class Sys extends Equatable {
  const Sys({
    required this.type,
    required this.id,
    required this.country,
    required this.sunrise,
    required this.sunset,
  });

  factory Sys.fromJson(Map<String, dynamic> json) => Sys(
        type: json['type'] as int,
        id: json['id'] as int,
        country: json['country'] as String,
        sunrise: json['sunrise'] as int,
        sunset: json['sunset'] as int,
      );

  final int type;
  final int id;
  final String country;
  final int sunrise;
  final int sunset;

  Map<String, dynamic> toJson() => {
        'type': type,
        'id': id,
        'country': country,
        'sunrise': sunrise,
        'sunset': sunset,
      };

  @override
  List<Object?> get props => [
        type,
        id,
        country,
        sunrise,
        sunset,
      ];
}
