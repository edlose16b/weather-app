String getImageFromWeather(String weather) {
  if (weather == 'Clouds') return 'assets/cloudy.png';
  if (weather == 'Rain') return 'assets/rainy.png';
  if (weather == 'Snow') return 'assets/snowy.png';
  if (weather == 'Haze') return 'assets/cloudy.png';

  return 'assets/sun.png';
}
