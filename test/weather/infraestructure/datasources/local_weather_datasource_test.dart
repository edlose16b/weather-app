import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:weather_app/weather/infraestructure/datasources/local_weather_datasource.dart';

class MockSharedPreferences extends Mock implements SharedPreferences {}

void main() {
  late SharedPreferences sharedPreferences;
  late LocalWeatherDataSource dataSource;

  setUp(() {
    sharedPreferences = MockSharedPreferences();
    dataSource = SharedPreferencesWeatherDataSource(
      sharedPreferences: sharedPreferences,
    );
  });

  group('getLastCities', () {
    test('should return a list of cities', () async {
      // arrange
      when(() => sharedPreferences.getStringList(any()))
          .thenReturn(['London', 'Madrid']);

      // act
      final result = await dataSource.getLastCities();

      // assert
      expect(result, ['London', 'Madrid']);
    });

    test('should return an empty list if there are no cities', () async {
      // arrange
      when(() => sharedPreferences.getStringList(any())).thenReturn(null);

      // act
      final result = await dataSource.getLastCities();

      // assert
      expect(result, <String>[]);
    });
  });

  group('saveLastCity', () {
    test('should save a city', () async {
      // arrange
      when(() => sharedPreferences.getStringList(any()))
          .thenReturn(['London', 'Madrid']);

      when(
        () => sharedPreferences.setStringList(any(), any()),
      ).thenAnswer((_) async => true);

      // act
      await dataSource.saveLastCity('Barcelona');

      // assert
      verify(
        () => sharedPreferences.setStringList(
          any(),
          ['Barcelona', 'London', 'Madrid'],
        ),
      ).called(1);
    });

    test('should save a city if there are no cities', () async {
      // arrange
      when(() => sharedPreferences.getStringList(any())).thenReturn(null);
      when(
        () => sharedPreferences.setStringList(any(), any()),
      ).thenAnswer((_) async => true);

      // act

      await dataSource.saveLastCity('Barcelona');

      // assert

      verify(
        () => sharedPreferences.setStringList(
          any(),
          ['Barcelona'],
        ),
      ).called(1);
    });

    test('should not save a city if it already exists', () async {
      // arrange
      when(() => sharedPreferences.getStringList(any()))
          .thenReturn(['London', 'Madrid']);

      when(
        () => sharedPreferences.setStringList(any(), any()),
      ).thenAnswer((_) async => true);

      // act
      await dataSource.saveLastCity('Madrid');

      // assert

      verify(
        () => sharedPreferences.setStringList(
          any(),
          ['London', 'Madrid'],
        ),
      ).called(1);
    });
  });
}
