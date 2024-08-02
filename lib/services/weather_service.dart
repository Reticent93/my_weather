import 'dart:convert';
import 'package:geocoding/geocoding.dart';
import 'package:geolocator/geolocator.dart';
import '../models/weather_model.dart';
import 'package:http/http.dart' as http;
import 'package:flutter_dotenv/flutter_dotenv.dart';

class WeatherService {
  static const BASE_URL = 'https://api.openweathermap.org/data/2.5/weather';
  late String apiKey;

  WeatherService() {
    apiKey = dotenv.env['API_KEY'] ?? '';
  }

  Future<WeatherModel> getWeather(
    String cityName,
  ) async {
    String location = cityName;

    final response = await http
        .get(Uri.parse('$BASE_URL?q=$location&appid=$apiKey&units=imperial'));

    if (response.statusCode == 200) {
      return WeatherModel.fromJson(jsonDecode(response.body));
    } else {
      throw Exception('Failed to load weather information ${response.body}');
    }
  }

  Future<Map<String, String?>> getCurrentLocation() async {
    LocationPermission permission = await Geolocator.checkPermission();
    if (permission == LocationPermission.denied) {
      permission = await Geolocator.requestPermission();
    }

    Position position = await Geolocator.getCurrentPosition(
        desiredAccuracy: LocationAccuracy.bestForNavigation);

    List<Placemark> placemarks =
        await placemarkFromCoordinates(position.latitude, position.longitude);

    String? cityName = placemarks[0].locality;
    print('Current city: $cityName');

    return {
      'city': cityName ?? '',
    };
  }
}
