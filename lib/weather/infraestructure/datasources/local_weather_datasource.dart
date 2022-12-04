import 'package:shared_preferences/shared_preferences.dart';

const citiesStorageKey = 'cities';

abstract class LocalWeatherDataSource {
  Future<List<String>> getLastCities();
  Future<void> saveLastCity(String city);
}

class SharedPreferencesWeatherDataSource implements LocalWeatherDataSource {
  SharedPreferencesWeatherDataSource({
    required SharedPreferences sharedPreferences,
  }) : _sharedPreferences = sharedPreferences;

  final SharedPreferences _sharedPreferences;

  @override
  Future<List<String>> getLastCities() async {
    final cities = _sharedPreferences.getStringList(citiesStorageKey);
    return cities ?? [];
  }

  @override
  Future<void> saveLastCity(String city) async {
    final cities = _sharedPreferences.getStringList(citiesStorageKey) ?? [];

    if (!cities.map((e) => e.toLowerCase()).contains(city.toLowerCase())) {
      cities.insert(0, city);
    }

    await _sharedPreferences.setStringList(citiesStorageKey, cities);
    return;
  }
}
