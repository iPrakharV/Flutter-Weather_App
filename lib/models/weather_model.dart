class Weather {
  final String CityName;
  final double Temperature;
  final String mainCondition;

  Weather(
      {required this.CityName,
      required this.Temperature,
      required this.mainCondition});

  factory Weather.fromJson(Map<String, dynamic> json) {
    return Weather(
      CityName: json['name'],
      Temperature: json['main']['temp'],
      mainCondition: json['weather'][0]['main'],
    );
  }

}
