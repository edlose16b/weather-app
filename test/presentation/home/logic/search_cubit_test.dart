import 'package:bloc_test/bloc_test.dart';
import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:weather_app/core/errors/failures.dart';
import 'package:weather_app/presentation/home/logic/search_cubit.dart';
import 'package:weather_app/weather/domain/repositories/weather_repository.dart';

import '../../../weather/core/jsons.dart';

class MockWeatherRepository extends Mock implements WeatherRepository {}

void main() {
  late MockWeatherRepository repository;
  late SearchCubit cubit;

  const cities = ['Lima', 'Santiago'];

  setUp(() {
    repository = MockWeatherRepository();
    cubit = SearchCubit(weatherRepository: repository);
  });

  blocTest<SearchCubit, SearchCubitState>(
    'initial state SearchCubitState',
    build: () => cubit,
    verify: (bloc) {
      expect(
        bloc.state,
        equals(
          const SearchCubitState(),
        ),
      );
    },
  );

  group('init', () {
    blocTest<SearchCubit, SearchCubitState>(
      'should not emit state when lastCities are empty',
      build: () => cubit,
      setUp: () {
        when(() => repository.getLastCities())
            .thenAnswer((_) async => const Right([]));
      },
      act: (bloc) => bloc.init(),
      verify: (_) {
        verify(() => repository.getLastCities()).called(1);
        verifyNever(() => repository.getWeather(any()));
        verifyNever(() => repository.saveLastCity(any()));
        verifyNever(
          () => repository.getForecast(
            lat: any(named: 'lat'),
            lon: any(named: 'lon'),
          ),
        );
      },
    );

    blocTest<SearchCubit, SearchCubitState>(
      'should not emit state when lastCities throws a Failure',
      build: () => cubit,
      setUp: () {
        when(() => repository.getLastCities())
            .thenAnswer((_) async => Left(CacheFailure()));
      },
      act: (bloc) => bloc.init(),
      verify: (_) {
        verify(() => repository.getLastCities()).called(1);
        verifyNever(() => repository.getWeather(any()));
        verifyNever(() => repository.saveLastCity(any()));
        verifyNever(
          () => repository.getForecast(
            lat: any(named: 'lat'),
            lon: any(named: 'lon'),
          ),
        );
      },
    );
  });

  blocTest<SearchCubit, SearchCubitState>(
    'should search the weather from a query when load the local data',
    build: () => cubit,
    setUp: () {
      when(() => repository.getLastCities())
          .thenAnswer((_) async => const Right(cities));

      when(() => repository.getWeather(any()))
          .thenAnswer((_) async => Right(getWeatherResponseExampleModel));

      when(
        () => repository.getForecast(
          lat: any(named: 'lat'),
          lon: any(named: 'lon'),
        ),
      ).thenAnswer(
        (_) async => Right(getForeCastResponseExampleModel),
      );

      when(() => repository.saveLastCity(any()))
          .thenAnswer((_) async => const Right(null));
    },
    act: (bloc) {
      // act
      return bloc.init();
    },
    expect: () => [
      equals(SearchCubitState.loading()),
      equals(
        SearchCubitState(
          status: SearchCubitStatus.success,
          weatherResponse: getWeatherResponseExampleModel,
          query: cities.first,
        ),
      ),
      equals(
        SearchCubitState(
          status: SearchCubitStatus.success,
          weatherResponse: getWeatherResponseExampleModel,
          forecastResponse: getForeCastResponseExampleModel,
          query: cities.first,
        ),
      ),
    ],
    verify: (bloc) {
      verifyInOrder([
        () => repository.getLastCities(),
        () => repository.getWeather(cities.first),
        () => repository.saveLastCity(cities.first),
        () => repository.getForecast(
              lat: getWeatherResponseExampleModel.coord.lat,
              lon: getWeatherResponseExampleModel.coord.lon,
            ),
      ]);
    },
  );

  test('removeDuplicatedDays', () {
    cubit.removeDuplicatedDays(getForeCastResponseExampleModel.list);

    expect(
      getForeCastResponseExampleModel.list.length,
      equals(1),
    );
  });
}
