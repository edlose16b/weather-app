import 'package:weather_app/weather/infraestructure/models/city_model.dart';
import 'package:weather_app/weather/infraestructure/models/clouds_model.dart';
import 'package:weather_app/weather/infraestructure/models/main_weather_data_model.dart';
import 'package:weather_app/weather/infraestructure/models/weather_model.dart';
import 'package:weather_app/weather/infraestructure/models/wind_model.dart';

class GetForeCastResponse {
  GetForeCastResponse({
    required this.cod,
    required this.message,
    required this.cnt,
    required this.list,
    required this.city,
  });
  factory GetForeCastResponse.fromJson(Map<String, dynamic> json) =>
      GetForeCastResponse(
        cod: json['cod'] as String,
        message: json['message'] as int,
        cnt: json['cnt'] as int,
        list: List<ForeCastItemResponse>.from(
          (json['list'] as List).map(
            (x) => ForeCastItemResponse.fromJson(x as Map<String, dynamic>),
          ),
        ),
        city: CityModel.fromJson(json['city'] as Map<String, dynamic>),
      );

  Map<String, dynamic> toJson() => {
        'cod': cod,
        'message': message,
        'cnt': cnt,
        'list': List<dynamic>.from(list.map((x) => x.toJson())),
        'city': city.toJson(),
      };

  final String cod;
  final int message;
  final int cnt;
  final List<ForeCastItemResponse> list;
  final CityModel city;
}

class ForeCastItemResponse {
  ForeCastItemResponse({
    required this.dt,
    required this.main,
    required this.weather,
    required this.clouds,
    required this.wind,
    required this.visibility,
    required this.pop,
    required this.sys,
    required this.dtTxt,
    this.snow,
  });
  factory ForeCastItemResponse.fromJson(Map<String, dynamic> json) =>
      ForeCastItemResponse(
        dt: json['dt'] as int,
        main:
            MainWeatherDataModel.fromJson(json['main'] as Map<String, dynamic>),
        weather: List<WeatherModel>.from(
          (json['weather'] as List).map(
            (x) => WeatherModel.fromJson(x as Map<String, dynamic>),
          ),
        ),
        clouds: CloudsModel.fromJson(json['clouds'] as Map<String, dynamic>),
        wind: WindModel.fromJson(json['wind'] as Map<String, dynamic>),
        visibility: json['visibility'] as int,
        pop: double.parse(json['pop'].toString()),
        sys: ForeCastSysResponse.fromJson(json['sys'] as Map<String, dynamic>),
        dtTxt: DateTime.parse(json['dt_txt'] as String),
        snow: json['snow'] == null
            ? null
            : Snow.fromJson(json['snow'] as Map<String, dynamic>),
      );

  Map<String, dynamic> toJson() => {
        'dt': dt,
        'main': main.toJson(),
        'weather': List<dynamic>.from(weather.map((x) => x.toJson())),
        'clouds': clouds.toJson(),
        'wind': wind.toJson(),
        'visibility': visibility,
        'pop': pop,
        'sys': sys.toJson(),
        'dt_txt': dtTxt.toIso8601String(),
        'snow': snow?.toJson(),
      };

  final int dt;
  final MainWeatherDataModel main;
  final List<WeatherModel> weather;
  final CloudsModel clouds;
  final WindModel wind;
  final int visibility;
  final double pop;
  final ForeCastSysResponse sys;
  final DateTime dtTxt;
  final Snow? snow;
}

class Snow {
  Snow({
    required this.the3H,
  });

  factory Snow.fromJson(Map<String, dynamic> json) => Snow(
        the3H: double.parse(json['3h'].toString()),
      );

  final double the3H;

  Map<String, dynamic> toJson() => {
        '3h': the3H,
      };
}

class ForeCastSysResponse {
  ForeCastSysResponse({
    required this.pod,
  });

  factory ForeCastSysResponse.fromJson(Map<String, dynamic> json) =>
      ForeCastSysResponse(
        pod: json['pod'] as String,
      );

  final String pod;

  Map<String, dynamic> toJson() => {
        'pod': pod,
      };
}
