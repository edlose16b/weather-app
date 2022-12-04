// ignore_for_file: prefer_const_constructors

import 'package:flutter/material.dart';
import 'package:weather_app/app/helpers/weather_helper.dart';
import 'package:weather_app/app/ui/paddings.dart';
import 'package:weather_app/presentation/home/wigets/min_max_temperature_widget.dart';
import 'package:weather_app/weather/infraestructure/dto/get_weather_response.dart';

class WeatherDetailWidget extends StatelessWidget {
  const WeatherDetailWidget({
    super.key,
    required this.response,
  });

  final GetWeatherResponse response;
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        _buildWeatherImage(),
        const SizedBox(height: Paddings.medium),
        Text(
          response.weather.first.description,
          style: Theme.of(context).textTheme.titleLarge,
        ),
        Text(
          '${response.main.temp}°',
          style: Theme.of(context).textTheme.headline1,
        ),
        const SizedBox(height: Paddings.medium),
        SizedBox(
          width: MediaQuery.of(context).size.width * .8,
          child: MinMaxTemperatureWidget(
            min: response.main.tempMin,
            max: response.main.tempMax,
          ),
        ),
      ],
    );
  }

  Widget _buildWeatherImage() {
    return Container(
      height: 200,
      width: 200,
      decoration: BoxDecoration(
        image: DecorationImage(
          image: AssetImage(getImageFromWeather(response.weather.first.main)),
          fit: BoxFit.cover,
        ),
      ),
    );
  }
}
