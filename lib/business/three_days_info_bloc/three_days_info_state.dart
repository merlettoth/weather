// Project imports:
import 'package:weather/entity/day.dart';

class ThreeDaysInfoState {
  // информации о погоде по дням
  final List<Day> days;

  // индекс дня, погода которого отображается
  final int indexSelectedDay;

  // название города, погода которого отображается
  final String cityName;

  // текстая информация, отображаемая в appBar; меняется, если выбрань день или показывается список дней
  final String appBarTitle;

  ThreeDaysInfoState({
    this.days = const [],
    this.indexSelectedDay = -1,
    this.cityName = '',
    this.appBarTitle = '',
  });

  ThreeDaysInfoState copywith({
    List<Day>? days,
    int? indexSelectedDay,
    String? cityName,
    String? appBarTitle,
  }) {
    return ThreeDaysInfoState(
      days: days ?? this.days,
      indexSelectedDay: indexSelectedDay ?? this.indexSelectedDay,
      cityName: cityName ?? this.cityName,
      appBarTitle: appBarTitle ?? this.appBarTitle,
    );
  }
}
