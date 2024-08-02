import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';
import 'package:my_weather/models/weather_model.dart';
import 'package:my_weather/services/weather_service.dart';

class WeatherPage extends StatefulWidget {
  const WeatherPage({super.key});

  @override
  State<WeatherPage> createState() => _WeatherPageState();
}

class _WeatherPageState extends State<WeatherPage> {
  final _weatherService = WeatherService();

  WeatherModel? _weather;

  _fetchWeather() async {
    try {
      final locationInfo = await _weatherService.getCurrentLocation();
      final weather = await _weatherService.getWeather(
        locationInfo['city']!,
      );
      setState(() {
        _weather = weather;
      });
    } catch (e) {
      print('Error fetching weather: $e');
      // You might want to set an error state here
    }
  }

  String getWeatherAnimation(String? weatherCondition) {
    if (weatherCondition == null) return 'assets/images/sunny.json';

    switch (weatherCondition.toLowerCase()) {
      case 'clouds':
      case 'mist':
      case 'smoke':
      case 'haze':
      case 'dust':
      case 'fog':
        return 'assets/images/cloudy.json';
      case 'rain':
      case 'drizzle':
      case 'shower rain':
        return 'assets/images/rain.json';
      case 'thunderstorm':
        return 'assets/images/thunderstorm.json';
      case 'clear':
        return 'assets/images/sunny.json';
      default:
        return 'assets/images/sunny.json';
    }
  }

  @override
  void initState() {
    super.initState();
    _fetchWeather();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey.shade800,
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              'Current Location',
              style: const TextStyle(
                  fontSize: 30,
                  fontWeight: FontWeight.bold,
                  color: Colors.white),
            ),
            Text(
              _weather?.cityName ?? 'Loading city...',
              style: const TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                  color: Colors.white),
            ),
            Text(
              _weather != null
                  ? '${_weather?.temperature.round()}°'
                  : 'Loading temperature...',
              style: const TextStyle(
                  fontSize: 48,
                  fontWeight: FontWeight.bold,
                  color: Colors.white),
            ),
            Text(
              _weather?.weatherCondition ?? '',
              style: const TextStyle(
                  fontSize: 24,
                  fontWeight: FontWeight.bold,
                  color: Colors.white),
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  _weather != null
                      ? 'H:${_weather?.maxTemperature.round()}°'
                      : 'Loading temperature...',
                  style: const TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                      color: Colors.white),
                ),
                SizedBox(
                  width: 15,
                ),
                Text(
                  _weather != null
                      ? 'L:${_weather?.minTemperature.round()}°'
                      : 'Loading temperature...',
                  style: const TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                      color: Colors.white),
                ),
              ],
            ),
            Lottie.asset(getWeatherAnimation(_weather?.weatherCondition)),
          ],
        ),
      ),
    );
  }
}
