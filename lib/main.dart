import 'package:flutter/material.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:my_weather/pages/weather_page.dart';

Future main() async {
  WidgetsFlutterBinding.ensureInitialized();
  try {
    await dotenv.load(); // Ensure correct file path if it's not in the root
  } catch (e) {
    print("Failed to load .env file!!: $e");
  }
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      debugShowCheckedModeBanner: false,
      home: WeatherPage(),
    );
  }
}
