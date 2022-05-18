// Dart imports:
import 'dart:convert';

// Project imports:
import 'package:weather/data/data_providers/weather_data_provider.dart';
import 'package:weather/entity/day.dart';
import 'package:weather/entity/weather_time.dart';
import 'package:weather/utils/custom_exceptions.dart';

// преобразовывает необработанные данные в модели данных
class WeatherRepository {
  final WeatherDataProvider _cityDataProvider;

  WeatherRepository(this._cityDataProvider);

  // преобразование необработанных данных в модель Day
  Future<List<Day>> getDaysWeather(String cityName) async {
    final response = await _cityDataProvider.getWeather(cityName);
    final data = jsonDecode(response.body) as Map<String, dynamic>;

    // если запрос неуспешен, кидаем исключение
    if (response.statusCode != 200) {
      if (data['message'] != null && data['message'] == 'city not found') {
        throw CityNotFoundException();
      }
      throw Exception();
    }

    final list = data['list'] as List<dynamic>;
    final weatherTimes = _getWeatherTimes(list);

    final List<Day> days = [];
    // сортируем данные о погоде по дням
    for (final item in weatherTimes) {
      final index = days.indexWhere((e) => e.date.day == item.dateTime.day);
      if (index == -1) {
        days.add(Day(date: item.dateTime, weatherByTime: [item]));
      } else {
        days[index].weatherByTime.add(item);
      }
    }

    // если имеется лишний 4-день, удаляем данные о нём;
    // api погоды возвращает данные о 3-х сутках с момента запроса,
    // если первая информация о погоде не о полуночи, получим 4 календарных дня,
    // а нам нужно 3 календарных дня
    if (days.length == 4) {
      days.removeLast();
    }

    return days;
  }

  // преобразование необработанных данных в модель WeatherTime
  List<WeatherTime> _getWeatherTimes(List<dynamic> list) {
    final List<WeatherTime> weatherTimes = [];

    for (final item in list) {
      final weatherItem = item as Map<String, dynamic>;
      final unixTime = weatherItem['dt'] as int;
      final dateTime = DateTime.fromMillisecondsSinceEpoch(unixTime * 1000);
      final mainData = weatherItem['main'] as Map<String, dynamic>;
      final temp = double.parse(mainData['temp'].toString());
      final pressure = mainData['pressure'] as int;
      final humidity = mainData['humidity'] as int;
      final weatherDataList = weatherItem['weather'] as List<dynamic>;
      final weatherData = weatherDataList.first as Map<String, dynamic>;
      final icon = weatherData['icon'] as String;
      final description = weatherData['description'] as String;
      final cloudsData = weatherItem['clouds'] as Map<String, dynamic>;
      final clouds = cloudsData['all'] as int;
      final windData = weatherItem['wind'] as Map<String, dynamic>;
      final windSpeed = double.parse(windData['speed'].toString());
      final pop = double.parse(weatherItem['pop'].toString());

      weatherTimes.add(
        WeatherTime(
          dateTime: dateTime,
          temp: temp,
          pressure: pressure,
          humidity: humidity,
          icon: icon,
          description: description,
          clouds: clouds,
          windSpeed: windSpeed,
          pop: pop,
        ),
      );
    }

    return weatherTimes;
  }
}
