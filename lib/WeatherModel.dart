
class Weather {
  final String cityName;
  final double temperature;
  final String description;
  final String iconCode;
  final List<WeatherForecast> forecast;

  Weather({
    required this.cityName,
    required this.temperature,
    required this.description,
    required this.iconCode,
    required this.forecast,
  });
}

class WeatherForecast {
  final DateTime date;
  final double temperature;
  final String description;
  final String iconCode;

  WeatherForecast({
    required this.date,
    required this.temperature,
    required this.description,
    required this.iconCode,
  });
}
