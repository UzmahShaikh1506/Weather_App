import 'package:get/get.dart';
import 'WeatherModel.dart';
import 'WeatherService.dart';

class WeatherController extends GetxController {
  final _weather = Weather(
    cityName: '',
    temperature: 0,
    description: '',
    iconCode: '',
    forecast: [],
  ).obs;

  Weather get weather => _weather.value;

  final _isLoading = false.obs;
  bool get isLoading => _isLoading.value;

  final _error = ''.obs;
  String get error => _error.value;

  final WeatherApi _weatherApi = WeatherApi();

  Future<void> fetchWeather(String city) async {
    _isLoading.value = true;
    try {
      final weatherData = await _weatherApi.getWeatherByCity(city);
      _weather.value = weatherData;
      _error.value = '';
    } catch (e) {
      _error.value = 'Sorry! No Data Found';
    } finally {
      _isLoading.value = false;
    }
  }
}
