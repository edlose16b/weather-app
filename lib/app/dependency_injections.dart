import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:weather_app/core/env/env.dart';
import 'package:weather_app/weather/domain/repositories/weather_repository.dart';
import 'package:weather_app/weather/infraestructure/datasources/local_weather_datasource.dart';
import 'package:weather_app/weather/infraestructure/datasources/remote_weather_datasource.dart';
import 'package:weather_app/weather/infraestructure/repositories/weather_repository.dart';

class DependejencyInjections extends StatelessWidget {
  const DependejencyInjections({
    super.key,
    required this.child,
    required this.sharedPreferences,
  });

  final Widget child;
  final SharedPreferences sharedPreferences;
  @override
  Widget build(BuildContext context) {
    return MultiRepositoryProvider(
      providers: [
        RepositoryProvider<Env>(create: (_) => DevEnv()),
        RepositoryProvider<RemoteWeatherDataSource>(
          create: (context) => OpenWeatherRemoteDataSource(
            client: Dio(
              BaseOptions(baseUrl: context.read<Env>().openWeatherApiUrl),
            ),
            env: context.read(),
          ),
        ),
        RepositoryProvider<LocalWeatherDataSource>(
          create: (context) => SharedPreferencesWeatherDataSource(
            sharedPreferences: sharedPreferences,
          ),
        ),
        RepositoryProvider<WeatherRepository>(
          create: (context) => AppWeatherRepository(
            remoteWeatherDataSource: context.read(),
            localWeatherDataSource: context.read(),
          ),
        ),
      ],
      child: child,
    );
  }
}
