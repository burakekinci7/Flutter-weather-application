import 'package:flutter/material.dart';
import 'package:flutter_weather_app/feature/view/wetaher_temp_main_view.dart';

class WeatherHomeView extends StatefulWidget {
  const WeatherHomeView({Key? key}) : super(key: key);
  @override
  State<WeatherHomeView> createState() => _WeatherHomeViewState();
}

class _WeatherHomeViewState extends State<WeatherHomeView> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false, //keyborad pixel error defect prevention
      body: Column(
        children: const [
          WeatherHomeWidgetView(),
        ],
      ),
    );
  }
}
