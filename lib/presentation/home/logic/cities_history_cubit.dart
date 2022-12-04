import 'package:bloc/bloc.dart';
import 'package:weather_app/weather/domain/repositories/weather_repository.dart';

class CitiesCubit extends Cubit<CitiesCubitState> {
  CitiesCubit({required WeatherRepository weatherRepository})
      : _weatherRepository = weatherRepository,
        super(CitiesCubitState(cities: []));

  final WeatherRepository _weatherRepository;

  void addCity(String city) {
    if (!state.cities
        .map((e) => e.toLowerCase())
        .contains(city.toLowerCase())) {
      final cities = [...state.cities, city];
      emit(state.copyWith(cities: cities));
    }
  }

  void select(String city) {
    emit(state.copyWith(selected: city));
  }

  Future<void> loadCities() async {
    final response = await _weatherRepository.getLastCities();

    response.fold(
      (l) => emit(state.copyWith(cities: [])),
      (r) => emit(state.copyWith(cities: r)),
    );
  }
}

class CitiesCubitState {
  CitiesCubitState({required this.cities, this.selected});

  final List<String> cities;
  final String? selected;

  CitiesCubitState copyWith({List<String>? cities, String? selected}) {
    return CitiesCubitState(
      cities: cities ?? this.cities,
      selected: selected ?? this.selected,
    );
  }
}
