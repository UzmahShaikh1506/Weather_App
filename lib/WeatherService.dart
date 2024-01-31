import 'dart:convert';
import 'package:http/http.dart' as http;
import 'WeatherModel.dart';

class WeatherApi {
  static const apiKey = 'd8a56500365b29766f312e82b7acd5b7';
  static const baseUrl = 'https://api.openweathermap.org/data/2.5/';

  Future<Weather> getWeatherByCity(String city) async {
    final currentWeatherUrl =
        '$baseUrl/weather?q=$city&units=metric&appid=$apiKey';
    final forecastUrl = '$baseUrl/forecast?q=$city&units=metric&appid=$apiKey';

    final currentWeatherResponse = await http.get(Uri.parse(currentWeatherUrl));
    final forecastResponse = await http.get(Uri.parse(forecastUrl));

    if (currentWeatherResponse.statusCode == 200 &&
        forecastResponse.statusCode == 200) {
      final currentWeatherData = json.decode(currentWeatherResponse.body);
      final forecastData = json.decode(forecastResponse.body);

      final List<WeatherForecast> forecastList = [];
      for (var item in forecastData['list']) {
        final forecast = WeatherForecast(
          date: DateTime.fromMillisecondsSinceEpoch(item['dt'] * 1000),
          temperature: item['main']['temp'],
          description: item['weather'][0]['description'],
          iconCode: item['weather'][0]['icon'],
        );
        forecastList.add(forecast);
      }

      return Weather(
        cityName: currentWeatherData['name'],
        temperature: currentWeatherData['main']['temp'],
        description: currentWeatherData['weather'][0]['description'],
        iconCode: currentWeatherData['weather'][0]['icon'],
        forecast: forecastList,
      );
    } else {
      throw Exception('Failed to fetch weather data');
    }
  }
}
