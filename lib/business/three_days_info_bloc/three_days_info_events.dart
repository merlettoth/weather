// Project imports:
import 'package:weather/entity/day.dart';

abstract class ThreeDaysInfoEvent {}

// инициирует инициализацию состояния экрана
class GetDaysWeather extends ThreeDaysInfoEvent {
  final List<Day> days;
  final String cityName;
  GetDaysWeather({
    required this.days,
    required this.cityName,
  });
}

// инициирует показ погоды выбранного дня
class SelectDay extends ThreeDaysInfoEvent {
  final int index;
  SelectDay(this.index);
}

// инициирует прекращение показа погоды выбранного дня
class CancelSelectionDay extends ThreeDaysInfoEvent {}
