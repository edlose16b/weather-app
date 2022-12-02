import 'package:weather_app/weather/infraestructure/dto/get_weather_response.dart';
import 'package:weather_app/weather/infraestructure/models/clouds_model.dart';
import 'package:weather_app/weather/infraestructure/models/coord_model.dart';
import 'package:weather_app/weather/infraestructure/models/main_weather_data_model.dart';
import 'package:weather_app/weather/infraestructure/models/weather_model.dart';
import 'package:weather_app/weather/infraestructure/models/wind_model.dart';

Map<String, dynamic> getWeatherJsonReponse = {
  'coord': {'lon': -77.0536, 'lat': -11.93},
  'weather': [
    {'id': 801, 'main': 'Clouds', 'description': 'algo de nubes', 'icon': '02n'}
  ],
  'base': 'stations',
  'main': {
    'temp': 18.35,
    'feels_like': 18.38,
    'temp_min': 18.35,
    'temp_max': 18.35,
    'pressure': 1013,
    'humidity': 82
  },
  'visibility': 10000,
  'wind': {'speed': 3.6, 'deg': 170},
  'clouds': {'all': 20},
  'dt': 1669954216,
  'sys': {
    'type': 1,
    'id': 8682,
    'country': 'PE',
    'sunrise': 1669890863,
    'sunset': 1669936833
  },
  'timezone': -18000,
  'id': 3936456,
  'name': 'Comas',
  'cod': 200
};

GetWeatherResponse getWeatherResponseExampleModel = GetWeatherResponse(
  coord: CoordModel(lat: -11.93, lon: -77.0536),
  weather: [
    WeatherModel(
      id: 801,
      main: 'Clouds',
      description: 'algo de nubes',
      icon: '02n',
    ),
  ],
  base: 'stations',
  main: MainWeatherDataModel(
    temp: 18.35,
    feelsLike: 18.38,
    tempMin: 18.35,
    tempMax: 18.35,
    pressure: 1013,
    humidity: 82,
  ),
  visibility: 10000,
  wind: WindModel(speed: 3.6, deg: 170),
  clouds: CloudsModel(all: 20),
  dt: 1669954216,
  sys: Sys(
    type: 1,
    id: 8682,
    country: 'PE',
    sunrise: 1669890863,
    sunset: 1669936833,
  ),
  timezone: -18000,
  id: 3936456,
  name: 'Comas',
  cod: 200,
);
