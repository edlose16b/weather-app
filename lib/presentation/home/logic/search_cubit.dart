import 'dart:developer';

import 'package:bloc/bloc.dart';
import 'package:weather_app/weather/domain/repositories/weather_repository.dart';
import 'package:weather_app/weather/infraestructure/dto/get_forecast_response.dart';
import 'package:weather_app/weather/infraestructure/dto/get_weather_response.dart';

class SearchCubit extends Cubit<SearchCubitState> {
  SearchCubit({required WeatherRepository weatherRepository})
      : _weatherRepository = weatherRepository,
        super(const SearchCubitState());

  final WeatherRepository _weatherRepository;

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
          ),
        );
        inspect(r);
        getForecast(r.coord.lat, r.coord.lon);
      },
    );
  }

  Future<void> getForecast(double lat, double lon) async {
    log('SearchCubit.getForecast($lat,$lon)');
    final response = await _weatherRepository.getForecast(lat: lat, lon: lon);

    response.fold(
      (l) => emit(state.copyWith(status: SearchCubitStatus.error)),
      (r) {
        _removeRepeatDays(r.list);

        emit(state.copyWith(forecastResponse: () => r));
        inspect(r);
      },
    );
  }

  void _removeRepeatDays(List<ForeCastItemResponse> list) {
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

class SearchCubitState {
  const SearchCubitState({
    this.status = SearchCubitStatus.initial,
    this.error = '',
    this.weatherResponse,
    this.forecastResponse,
  });
  // loading
  factory SearchCubitState.loading() => const SearchCubitState(
        status: SearchCubitStatus.loading,
      );

  final SearchCubitStatus status;
  final String error;
  final GetWeatherResponse? weatherResponse;
  final GetForeCastResponse? forecastResponse;

  SearchCubitState copyWith({
    SearchCubitStatus? status,
    String? error,
    List<String>? cities,
    GetWeatherResponse? Function()? weatherResponse,
    GetForeCastResponse? Function()? forecastResponse,
  }) {
    return SearchCubitState(
      status: status ?? this.status,
      error: error ?? this.error,
      weatherResponse: weatherResponse?.call() ?? this.weatherResponse,
      forecastResponse: forecastResponse?.call() ?? this.forecastResponse,
    );
  }
}
