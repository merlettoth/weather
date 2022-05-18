// Project imports:
import 'package:weather/entity/weather_time.dart';

class Day {
  final DateTime date;
  final List<WeatherTime> weatherByTime;
  double get averageTemp =>
      weatherByTime.fold<double>(0, (sum, e) => sum + e.temp) / weatherByTime.length;

  Day({
    required this.date,
    required this.weatherByTime,
  });
}
