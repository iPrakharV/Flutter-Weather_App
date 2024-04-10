import 'package:flutter/material.dart';
import 'package:weather_flutter_app/services/weather_services.dart';
import 'package:weather_flutter_app/models/weather_model.dart';

class WeatherPage extends StatefulWidget {
  const WeatherPage({Key? key}) : super(key: key);

  @override
  State<WeatherPage> createState() => _WeatherPageState();
}

class _WeatherPageState extends State<WeatherPage> {
  //api key
  final _weatherService = WeatherService('ADD API KEY HERE PRAKHAR');
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

  //init state
  void initState() {
    super.initState();
    _fetchWeather();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(mainAxisAlignment: MainAxisAlignment.center, 
        children: [
          //city name
          Text(_weather?.CityName ?? 'Loading City...'),

          //city temperature
          Text('${_weather?.Temperature.round()}°C'),
        ]),
      ),
    );
  }
}
