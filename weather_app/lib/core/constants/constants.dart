class Url {
  static const String baseUrl =
      'https://api.openweathermap.org/data/2.5/weather';
  static const String apikey =
      "2de9e8ebd605944d35dc6c9793354dce"; //your api key
  static String currentWeatherByCityName(String cityName) =>
      '$baseUrl?q=$cityName&appid=$apikey';
  static String weatherIcon(String iconCode) =>
      'http://openweathermap.org/img/wn/$iconCode@2x.png';
}
