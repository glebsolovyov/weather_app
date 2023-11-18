class DaylyWeather {
  const DaylyWeather({
    required this.date,
    required this.weekday,
    required this.averageTemp,
    required this.description,
    required this.averageWindSpeed,
    required this.averageHumidity
  });

  final String date;
  final String weekday;
  final int averageTemp;
  final String description;
  final int averageWindSpeed;
  final int averageHumidity;

  factory DaylyWeather.fromJson(List<dynamic> weatherList, String date) {
    var tempSum = 0;
    var windSpeedSum = 0.0;
    var humiditySum = 0;

    var counter = 0;
    for (var item in weatherList){
      tempSum += item["main"]["temp"].round() as int;
      windSpeedSum += item["wind"]["speed"];
      humiditySum += item["main"]["humidity"] as int;
      counter++;
    }
    var averageTemp = (tempSum / counter).round();

    var averageWindSpeed = (windSpeedSum / counter).round();

    var averageHumidity = (humiditySum / counter).round();

    Map<int, String> weekdays = {
      1: "Понедельник",
      2: "Вторник",
      3: "Среда",
      4: "Четверг",
      5: "Пятница",
      6: "Суббота",
      7: "Воскресенье"
    };

    var weekdayNumber = DateTime.parse(date).weekday;
    var weekday = "";
    for (var key in weekdays.keys) {

      if (weekdayNumber == key){
        weekday = weekdays[key]!;
      }
    }
    
    date = date.split("-").sublist(1, 3).join(".");

    Map<String, int> countMap = {};
    
    String mostFrequentValue = "";
    int maxCount = 0;
    
    for (var item in weatherList) {
      var weatherDescription = item["weather"][0]["main"];

      if (countMap.containsKey(weatherDescription)) {
        countMap[weatherDescription] = countMap[weatherDescription]! + 1;
      } else {
        countMap[weatherDescription] = 1;
      }
      
      if (countMap[weatherDescription]! > maxCount) {
        maxCount = countMap[weatherDescription]!;
        mostFrequentValue = weatherDescription;
        
      }
    }

    return DaylyWeather(
          date: date, 
          weekday: weekday,
          averageTemp: averageTemp, 
          description: mostFrequentValue,
          averageWindSpeed: averageWindSpeed,
          averageHumidity: averageHumidity);
  }
}
