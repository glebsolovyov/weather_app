class Weather {
  const Weather({
    required this.city,
    required this.temp,
    required this.description,
  });

  final String city;
  final int temp;
  final String description;

  factory Weather.fromJson(Map<String, dynamic> json, String city) {
    return Weather(
        city: city,
        temp: json["main"]["temp"].round() as int,
        description: json["weather"][0]["main"] as String);
  }
}
