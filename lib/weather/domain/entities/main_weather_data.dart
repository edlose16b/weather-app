class MainWeatherData {
  MainWeatherData({
    required this.temp,
    required this.feelsLike,
    required this.tempMin,
    required this.tempMax,
    required this.pressure,
    required this.humidity,
     this.tempKf,
    this.seaLevel,
    this.grndLevel,
  });

  final double temp;
  final double feelsLike;
  final double tempMin;
  final double tempMax;
  final int pressure;
  final int? seaLevel;
  final int? grndLevel;
  final int humidity;
  final double? tempKf;
}
