import 'dart:async';
import 'dart:developer';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:weather_app/weather/domain/repositories/weather_repository.dart';
import 'package:weather_app/weather/infraestructure/dto/get_forecast_response.dart';
import 'package:weather_app/weather/infraestructure/dto/get_weather_response.dart';

class SearchCubit extends Cubit<SearchCubitState> {
  SearchCubit({required WeatherRepository weatherRepository})
      : _weatherRepository = weatherRepository,
        super(const SearchCubitState());

  final WeatherRepository _weatherRepository;

  Future<void> init() async {
    final response = await _weatherRepository.getLastCities();
    response.fold((l) => null, (r) {
      if (r.isNotEmpty) {
        search(r.first);
      }
    });
  }

  /// Search the weather from a query
  Future<void> search(String query) async {
    emit(SearchCubitState.loading());

    log('SearchCubit.search($query)');
    final response = await _weatherRepository.getWeather(query);

    response.fold(
      (l) => emit(state.copyWith(status: SearchCubitStatus.error)),
      (r) {
        emit(
          state.copyWith(
            status: SearchCubitStatus.success,
            weatherResponse: () => r,
            forecastResponse: () => null,
            query: () => query,
          ),
        );
        inspect(r);

        unawaited(_weatherRepository.saveLastCity(query));
        _getForecast(r.coord.lat, r.coord.lon);
      },
    );
  }

  /// Get forecast for the city
  Future<void> _getForecast(double lat, double lon) async {
    log('SearchCubit.getForecast($lat,$lon)');
    final response = await _weatherRepository.getForecast(lat: lat, lon: lon);

    response.fold(
      (l) => emit(state.copyWith(status: SearchCubitStatus.error)),
      (r) {
        removeDuplicatedDays(r.list);

        emit(state.copyWith(forecastResponse: () => r));
        inspect(r);
      },
    );
  }

  @visibleForTesting
  void removeDuplicatedDays(List<ForeCastItemResponse> list) {
    final dayTaken = <int>[];
    list.removeWhere((element) {
      final key = element.dtTxt.month + element.dtTxt.day;
      if (dayTaken.contains(key)) {
        return true;
      } else {
        dayTaken.add(key);
        return false;
      }
    });
  }
}

enum SearchCubitStatus { initial, loading, success, error }

class SearchCubitState extends Equatable {
  const SearchCubitState({
    this.status = SearchCubitStatus.initial,
    this.error = '',
    this.weatherResponse,
    this.forecastResponse,
    this.query,
  });
  // loading
  factory SearchCubitState.loading() => const SearchCubitState(
        status: SearchCubitStatus.loading,
      );

  final SearchCubitStatus status;
  final String error;
  final GetWeatherResponse? weatherResponse;
  final GetForeCastResponse? forecastResponse;
  final String? query;

  SearchCubitState copyWith({
    SearchCubitStatus? status,
    String? error,
    List<String>? cities,
    GetWeatherResponse? Function()? weatherResponse,
    GetForeCastResponse? Function()? forecastResponse,
    String? Function()? query,
  }) {
    return SearchCubitState(
      status: status ?? this.status,
      error: error ?? this.error,
      weatherResponse: weatherResponse?.call() ?? this.weatherResponse,
      forecastResponse: forecastResponse?.call() ?? this.forecastResponse,
      query: query?.call() ?? this.query,
    );
  }

  @override
  List<Object?> get props => [
        status,
        error,
        weatherResponse,
        forecastResponse,
        query,
      ];
}
