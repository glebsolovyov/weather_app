class DaylyWeather {
  const DaylyWeather({
    required this.date,
    required this.averageTemp,
    required this.description
  });

  final String date;
  final int averageTemp;
  final String description;

  factory DaylyWeather.fromJson(List<dynamic> weatherList, String date) {
    var tempSum = 0;
    var counter = 0;
    for (var item in weatherList){
      tempSum += item["main"]["temp"].round() as int;
      counter++;
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
        averageTemp: (tempSum / counter).round(), 
        description: mostFrequentValue);
  }
}
