import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:weather_app/app/ui/colors.dart';
import 'package:weather_app/app/ui/paddings.dart';
import 'package:weather_app/l10n/l10n.dart';
import 'package:weather_app/presentation/home/logic/cities_cubit.dart';
import 'package:weather_app/presentation/home/logic/search_cubit.dart';
import 'package:weather_app/presentation/home/wigets/forecast_card.dart';
import 'package:weather_app/presentation/home/wigets/home_header_widget.dart';
import 'package:weather_app/presentation/home/wigets/weather_detail_widget.dart';
import 'package:weather_app/presentation/shared/skeletos/forecast_skeleto.dart';
import 'package:weather_app/presentation/shared/skeletos/weather_detail_skeleto.dart';
import 'package:weather_app/weather/infraestructure/dto/get_forecast_response.dart';

class HomeView extends StatelessWidget {
  const HomeView({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(
          create: (context) =>
              SearchCubit(weatherRepository: context.read())..init(),
        ),
        BlocProvider(
          create: (context) =>
              CitiesCubit(weatherRepository: context.read())..loadCities(),
        ),
      ],
      child: const HomeContent(),
    );
  }
}

@visibleForTesting
class HomeContent extends StatelessWidget {
  const HomeContent({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      extendBodyBehindAppBar: true,
      extendBody: true,
      body: BlocConsumer<SearchCubit, SearchCubitState>(
        listener: (context, state) {
          if (state.status == SearchCubitStatus.success) {
            context.read<CitiesCubit>().addCity(state.query!);
            context.read<CitiesCubit>().select(state.query!);
          }
        },
        builder: (context, state) {
          return SingleChildScrollView(
            physics: const BouncingScrollPhysics(),
            child: Container(
              padding: const EdgeInsets.symmetric(horizontal: 15),
              constraints: BoxConstraints(
                minHeight: MediaQuery.of(context).size.height,
              ),
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
                    _buildBody(context, state),
                  ],
                ),
              ),
            ),
          );
        },
      ),
    );
  }

  Widget _buildBody(BuildContext context, SearchCubitState state) {
    if (state.status == SearchCubitStatus.initial) {
      return SizedBox(
        key: const Key('search_city'),
        height: MediaQuery.of(context).size.height * .8,
        child: Center(
          child: Text(context.l10n.search_city),
        ),
      );
    }

    if (state.status == SearchCubitStatus.error) {
      return SizedBox(
        key: const Key('error_message'),
        height: MediaQuery.of(context).size.height * .8,
        child: Center(
          child: Text(context.l10n.error_try_again),
        ),
      );
    }

    return Column(
      key: const Key('weather_detail'),
      children: [
        if (state.weatherResponse == null)
          const HomeHeaderSkeleto()
        else
          WeatherDetailWidget(response: state.weatherResponse!),
        const SizedBox(height: Paddings.medium),
        _buildForecast(state.forecastResponse),
      ],
    );
  }

  Widget _buildForecast(GetForeCastResponse? forecast) {
    if (forecast == null) return const ForecastSkeleto();
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
