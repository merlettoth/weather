// Flutter imports:
import 'package:flutter/material.dart';

// Package imports:
import 'package:flutter_bloc/flutter_bloc.dart';

// Project imports:
import 'package:weather/business/three_days_info_bloc/three_days_info_bloc.dart';
import 'package:weather/business/three_days_info_bloc/three_days_info_events.dart';
import 'package:weather/business/three_days_info_bloc/three_days_info_state.dart';
import 'package:weather/entity/day.dart';
import 'package:weather/ui/common_widgets/list_weather_card.dart';
import 'package:weather/ui/three_days_info_screen/day_card.dart';

// пробрасывает зависимость ThreeDaysInfoBloc
class ThreeDaysInfoScreen extends StatelessWidget {
  final List<Day> days;
  final String cityName;

  const ThreeDaysInfoScreen({
    Key? key,
    required this.days,
    required this.cityName,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => ThreeDaysInfoBloc()
        ..add(
          GetDaysWeather(
            days: days,
            cityName: cityName,
          ),
        ),
      child: const ThreeDaysInfoView(),
    );
  }
}

// экран о погоде за сегодня
class ThreeDaysInfoView extends StatelessWidget {
  const ThreeDaysInfoView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<ThreeDaysInfoBloc, ThreeDaysInfoState>(
      builder: (context, state) {
        final sortDays = state.days.toList();
        // сортируем дни по возрастанию средней температуры
        sortDays.sort((a, b) => a.averageTemp.compareTo(b.averageTemp));
        return WillPopScope(
          // если выбран день, показываем список дней, иначе возвращаемся на экран о погоде за сегодня
          onWillPop: () async {
            if (state.indexSelectedDay == -1) {
              return true;
            }
            context.read<ThreeDaysInfoBloc>().add(CancelSelectionDay());
            return false;
          },
          child: Scaffold(
            appBar: AppBar(
              title: Text(state.appBarTitle),
            ),
            body: Builder(
              builder: (context) {
                // если день не выбран, показываем 3 карточки с краткой информацией о дне
                if (state.indexSelectedDay == -1) {
                  return ListView(
                    children: sortDays.map((day) {
                      return DayCard(
                        day: day,
                        onTap: () => context.read<ThreeDaysInfoBloc>().add(
                              SelectDay(
                                state.days.indexWhere((e) => e.date == day.date),
                              ),
                            ),
                      );
                    }).toList(),
                  );
                }

                // если день выбран, показываем данные этого дня о погоде по часам
                return ListWeatherCard(
                  weatherTimes: state.days[state.indexSelectedDay].weatherByTime,
                );
              },
            ),
          ),
        );
      },
    );
  }
}
