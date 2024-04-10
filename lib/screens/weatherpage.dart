import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';
import 'package:weather_flutter_app/services/weather_services.dart';
import 'package:weather_flutter_app/models/weather_model.dart';

class WeatherPage extends StatefulWidget {
  const WeatherPage({Key? key}) : super(key: key);

  @override
  State<WeatherPage> createState() => _WeatherPageState();
}

class _WeatherPageState extends State<WeatherPage> {
  //api key
  final _weatherService = WeatherService('1753fd6fe8661dd0a10af732a64b571b');
  Weather? _weather;

  //fetch weather data

  _fetchWeather() async {
    //get current city
    String cityName = await _weatherService.getCurrentCity();

    //get weather city
    try {
      final weather = await _weatherService.getWeather(cityName);
      setState(() {
        _weather = weather;
      });
    }

//if there are errors
    catch (e) {
      print(e);
    }
  }

  //weather animations
  String getWeatherAnimation(String? mainCondition) {
    if (mainCondition == null) {
      return 'assets/Sun.json';
    } //if there are no conditions

    switch (mainCondition) {
      case 'Rain':
        return 'assets/rain.json';
      case 'Clouds':
        return 'assets/cloud.json';
      case 'fog':
        return 'assets/cloud.json';
      case 'shower rain':
        return 'assets/rain.json';
      case 'thunderstorm':
        return 'assets/thunder.json';
      case 'Clear':
        return 'assets/Sun.json';
      default:
        return 'assets/Sun.json';
    }
  }

  //init state
  void initState() {
    super.initState();
    _fetchWeather();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[400],
      body: Center(
        child: Column(mainAxisAlignment: MainAxisAlignment.center, children: [
          //city name
          Text(_weather?.CityName ?? 'Loading City...'),

          //Adding aminations
          Lottie.asset(getWeatherAnimation(_weather?.mainCondition ?? "")),

          //city temperature
          Text('${_weather?.Temperature.round()}°C'),

          //weather condition
          Text(_weather?.mainCondition ?? ""),
        ]),
      ),
    );
  }
}
