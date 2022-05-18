// Project imports:
import 'package:weather/entity/day.dart';

class DayInfoState {
  // информации о погоде по дням
  final List<Day> days;

  // название города, о погоде которого надо узнать
  final String cityName;

  // отображается ли кнопка перехода на экран данных о погоде за 3 дня
  final bool isShowThreeDaysButton;

  // текстовая информация об ошибки получения данных о погоде
  final String errorMessage;

  DayInfoState({
    this.days = const [],
    this.cityName = '',
    this.isShowThreeDaysButton = false,
    this.errorMessage = '',
  });

  DayInfoState copywith({
    List<Day>? days,
    String? cityName,
    bool? isShowThreeDaysButton,
    String? errorMessage,
  }) {
    return DayInfoState(
      days: days ?? this.days,
      cityName: cityName ?? this.cityName,
      isShowThreeDaysButton: isShowThreeDaysButton ?? this.isShowThreeDaysButton,
      errorMessage: errorMessage ?? this.errorMessage,
    );
  }
}
