import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:weather_app/app/helpers/date_helper.dart';
import 'package:weather_app/app/helpers/weather_helper.dart';
import 'package:weather_app/presentation/home/wigets/min_max_temperature_widget.dart';
import 'package:weather_app/weather/infraestructure/dto/get_forecast_response.dart';

class ForecastCard extends StatelessWidget {
  const ForecastCard({super.key, required this.item});
  final ForeCastItemResponse item;

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
          Text(
            DateFormat('EEEE').format(item.dtTxt),
            style: Theme.of(context).textTheme.bodyText1,
          ),
          const SizedBox(height: 10),
          _buildWeatherImage(),
          const SizedBox(height: 20),
          MinMaxTemperatureWidget(
            min: item.main.tempMin,
            max: item.main.tempMax,
          ),
        ],
      ),
    );
  }

  Widget _buildWeatherImage() {
    return Container(
      height: 35,
      width: 35,
      decoration: BoxDecoration(
        image: DecorationImage(
          image: AssetImage(getImageFromWeather(item.weather.first.main)),
          fit: BoxFit.cover,
        ),
      ),
    );
  }
}
