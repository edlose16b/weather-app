import 'package:flutter/material.dart';
import 'package:weather_app/presentation/home/wigets/min_max_temperature_widget.dart';

class ForecastCard extends StatelessWidget {
  const ForecastCard({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: Colors.white.withOpacity(.35),
        borderRadius: BorderRadius.circular(10),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.1),
            blurRadius: 10,
            offset: const Offset(0, 5),
          ),
        ],
      ),
      child: Column(
        children: [
          Text('Tomorrow', style: Theme.of(context).textTheme.bodyText1),
          const SizedBox(height: 10),
          _buildWeatherImage(),
          const SizedBox(height: 20),
          const MinMaxTemperatureWidget(),
        ],
      ),
    );
  }

  Widget _buildWeatherImage() {
    return Container(
      height: 50,
      width: 50,
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
