class WeatherModel {
  final String cityName;
  final double temperature;
  final double minTemperature;
  final double maxTemperature;

  final String weatherCondition;

  WeatherModel(
      {required this.cityName,
      required this.temperature,
      required this.minTemperature,
      required this.maxTemperature,
      required this.weatherCondition});

  factory WeatherModel.fromJson(Map<String, dynamic> json) {
    return WeatherModel(
      cityName: json['name'] ?? 'Unknown',
      temperature: (json['main']['temp'] as num).toDouble(),
      minTemperature: (json['main']['temp_min'] as num).toDouble(),
      maxTemperature: (json['main']['temp_max'] as num).toDouble(),
      weatherCondition: json['weather'][0]['main'] ?? 'Unknown',
    );
  }
}
