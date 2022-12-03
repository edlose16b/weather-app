import 'package:weather_app/weather/domain/entities/city.dart';
import 'package:weather_app/weather/infraestructure/dto/get_forecast_response.dart';
import 'package:weather_app/weather/infraestructure/dto/get_weather_response.dart';
import 'package:weather_app/weather/infraestructure/models/city_model.dart';
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

Map<String, dynamic> getForeCastJsonResponse = {
  'cod': '200',
  'message': 0,
  'cnt': 1,
  'list': [
    {
      'dt': 1670036400,
      'main': {
        'temp': -22.17,
        'feels_like': -22.17,
        'temp_min': -22.17,
        'temp_max': -22.17,
        'pressure': 985,
        'sea_level': 985,
        'grnd_level': 746,
        'humidity': 100,
        'temp_kf': 0
      },
      'weather': [
        {'id': 804, 'main': 'Clouds', 'description': 'nubes', 'icon': '04d'}
      ],
      'clouds': {'all': 100},
      'wind': {'speed': 0.74, 'deg': 53, 'gust': 0.7},
      'visibility': 3796,
      'pop': 0,
      'sys': {'pod': 'd'},
      'dt_txt': '2022-12-03 03:00:00'
    }
  ],
  'city': {
    'id': 0,
    'name': '',
    'coord': {'lat': -77.0282, 'lon': -12.0432},
    'country': '',
    'population': 0,
    'timezone': 0,
    'sunrise': 0,
    'sunset': 0
  }
};

GetForeCastResponse getForeCastResponseExampleModel = GetForeCastResponse(
  cod: '200',
  message: 0,
  cnt: 1,
  list: [
    ForeCastItemResponse(
      dt: 1670036400,
      main: MainWeatherDataModel(
        temp: -22.17,
        feelsLike: -22.17,
        tempMin: -22.17,
        tempMax: -22.17,
        pressure: 985,
        humidity: 100,
      ),
      weather: [
        WeatherModel(
          id: 804,
          main: 'Clouds',
          description: 'nubes',
          icon: '04d',
        ),
      ],
      clouds: CloudsModel(all: 100),
      wind: WindModel(speed: 0.74, deg: 53, gust: 0.7),
      visibility: 3796,
      pop: 0,
      sys: ForeCastSysResponse(pod: 'd'),
      dtTxt: DateTime.now(),
    )
  ],
  city: CityModel(
    id: 0,
    name: '',
    coord: CoordModel(lat: -77.0282, lon: -12.0432),
    country: '',
    population: 0,
    timezone: 0,
    sunrise: 0,
    sunset: 0,
  ),
);
