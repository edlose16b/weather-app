import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:weather_app/app/ui/colors.dart';
import 'package:weather_app/app/ui/paddings.dart';
import 'package:weather_app/presentation/home/logic/search_cubit.dart';
import 'package:weather_app/presentation/home/wigets/forecast_card.dart';
import 'package:weather_app/presentation/home/wigets/home_header_widget.dart';
import 'package:weather_app/presentation/home/wigets/weather_detail_widget.dart';
import 'package:weather_app/weather/infraestructure/dto/get_forecast_response.dart';

class HomeView extends StatelessWidget {
  const HomeView({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => SearchCubit(weatherRepository: context.read()),
      child: Scaffold(
        extendBodyBehindAppBar: true,
        extendBody: true,
        body: BlocConsumer<SearchCubit, SearchCubitState>(
          listener: (context, state) {},
          builder: (context, state) {
            return Container(
              padding: const EdgeInsets.symmetric(horizontal: 15),
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  begin: Alignment.topCenter,
                  end: Alignment.bottomCenter,
                  colors: getColorsFromWeather(
                    state.weatherResponse?.weather.first.main ?? '',
                  ),
                ),
              ),
              child: SafeArea(
                child: Column(
                  children: [
                    const HomeHeader(),
                    const SizedBox(height: Paddings.medium),
                    if (state.weatherResponse != null)
                      WeatherDetailWidget(response: state.weatherResponse!),
                    const SizedBox(height: Paddings.medium),
                    if (state.forecastResponse != null)
                      _buildForecast(state.forecastResponse!)
                  ],
                ),
              ),
            );
          },
        ),
      ),
    );
  }

  Widget _buildForecast(GetForeCastResponse forecast) {
    return SizedBox(
      height: 190,
      child: ListView.builder(
        scrollDirection: Axis.horizontal,
        physics: const BouncingScrollPhysics(),
        itemBuilder: (context, index) {
          final item = forecast.list[index];

          return ForecastCard(item: item);
        },
        shrinkWrap: true,
        itemCount: forecast.list.length,
      ),
    );
  }

  List<Color> getColorsFromWeather(String weather) {
    log(weather);
    switch (weather) {
      case 'Rain':
        return AppColors.thunderGradientColors;

      case 'Clouds':
        return AppColors.cloudyGradientColors;

      case 'Snow':
        return AppColors.coldGradientColors;

      case 'Haze':
        return AppColors.thunderGradientColors;

      default:
        return AppColors.hotGradientColors;
    }
  }
}
