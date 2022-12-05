import 'package:bloc_test/bloc_test.dart';
import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:weather_app/presentation/home/logic/cities_cubit.dart';
import 'package:weather_app/weather/domain/repositories/weather_repository.dart';

class MockWeatherRepository extends Mock implements WeatherRepository {}

void main() {
  late MockWeatherRepository repository;

  setUp(() {
    repository = MockWeatherRepository();
  });

  blocTest<CitiesCubit, CitiesCubitState>(
    'initial state CitiesCubit',
    build: () => CitiesCubit(weatherRepository: repository),
    verify: (bloc) {
      expect(
        bloc.state,
        equals(
          const CitiesCubitState(
            cities: [],
          ),
        ),
      );
    },
  );

  blocTest<CitiesCubit, CitiesCubitState>(
    'should emits [CitiesCubitState(cities: [city])] when addCity is called',
    build: () => CitiesCubit(weatherRepository: repository),
    act: (cubit) => cubit.addCity('city'),
    expect: () => [
      equals(
        const CitiesCubitState(
          cities: ['city'],
        ),
      ),
    ],
  );

  blocTest<CitiesCubit, CitiesCubitState>(
    'should emits [CitiesCubitState(cities: [], selected: city)] when select '
    'is called',
    build: () => CitiesCubit(weatherRepository: repository),
    act: (cubit) => cubit.select('city'),
    expect: () => [
      equals(
        const CitiesCubitState(
          cities: [],
          selected: 'city',
        ),
      ),
    ],
  );

  blocTest<CitiesCubit, CitiesCubitState>(
    'should emits [CitiesCubitState(cities: [city])] when loadCities is called',
    build: () => CitiesCubit(weatherRepository: repository),
    act: (cubit) async {
      when(() => repository.getLastCities()).thenAnswer(
        (_) async => const Right(['city']),
      );
      await cubit.loadCities();
    },
    expect: () => [
      equals(
        const CitiesCubitState(
          cities: ['city'],
        ),
      ),
    ],
  );
}
