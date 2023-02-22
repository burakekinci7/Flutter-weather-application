import 'package:flutter/material.dart';
import 'package:flutter_weather_app/core/global/titles.dart';
import 'package:flutter_weather_app/core/theme/dark_light_mode.dart';
import 'package:flutter_weather_app/feature/view/weather_home_view.dart';
import 'package:provider/provider.dart';

void main() {
  runApp(
    MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => ThemeDarkLightMode()),
      ],
      child: const MyApp(),
    ),
  );
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: Titles.appName,
      theme: context.watch<ThemeDarkLightMode>().currentTheme,
      home: const WeatherHomeView(),
    );
  }
}
