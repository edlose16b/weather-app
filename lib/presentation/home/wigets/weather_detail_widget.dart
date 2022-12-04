// ignore_for_file: prefer_const_constructors

import 'package:flutter/material.dart';
import 'package:weather_app/app/ui/paddings.dart';
import 'package:weather_app/presentation/home/wigets/min_max_temperature_widget.dart';

class WeatherDetailWidget extends StatelessWidget {
  const WeatherDetailWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        _buildWeatherImage(),
        const SizedBox(height: Paddings.medium),
        Text('Hot', style: Theme.of(context).textTheme.titleLarge),
        Text('32°', style: Theme.of(context).textTheme.headline1),
        const SizedBox(height: Paddings.medium),
        SizedBox(
          width: MediaQuery.of(context).size.width * .8,
          child: const MinMaxTemperatureWidget(),
        )
      ],
    );
  }

  Widget _buildWeatherImage() {
    return Container(
      height: 200,
      width: 200,
      decoration: BoxDecoration(
        image: DecorationImage(
          image: NetworkImage(
              'https://cdn-icons-png.flaticon.com/512/6393/6393305.png'),
          fit: BoxFit.cover,
        ),
      ),
    );
  }
}
