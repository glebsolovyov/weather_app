class Weather {
  const Weather({
    required this.city,
    required this.temp,
    required this.description,
    required this.time
  });

  final String city;
  final int temp;
  final String description;
  final String time;

  factory Weather.fromJson(Map<String, dynamic> json, String city) {
    String time = json["dt_txt"].split(' ')[1].split(':').sublist(0,2).join(":");
    return Weather(
        city: city,
        temp: json["main"]["temp"].round() as int,
        description: json["weather"][0]["main"] as String,
        time: time);
  }
}
