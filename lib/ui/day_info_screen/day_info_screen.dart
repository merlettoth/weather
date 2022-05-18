// Flutter imports:
import 'package:flutter/material.dart';

// Package imports:
import 'package:flutter_bloc/flutter_bloc.dart';

// Project imports:
import 'package:weather/business/day_info_bloc/day_info_bloc.dart';
import 'package:weather/business/day_info_bloc/day_info_events.dart';
import 'package:weather/business/day_info_bloc/day_info_state.dart';
import 'package:weather/data/repositories/weather_repository.dart';
import 'package:weather/ui/common_widgets/list_weather_card.dart';
import 'package:weather/ui/day_info_screen/error_info_snack_bar.dart';
import 'package:weather/ui/three_days_info_screen/three_days_info_screen.dart';

// пробрасывает зависимость DayInfoBloc
class DayInfoScreen extends StatelessWidget {
  final String cityName;

  const DayInfoScreen({
    Key? key,
    required this.cityName,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) =>
          DayInfoBloc(context.read<WeatherRepository>())..add(GetCityWeather(cityName)),
      child: const _DayInfoView(),
    );
  }
}

// экран о погоде за сегодня
class _DayInfoView extends StatelessWidget {
  const _DayInfoView({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<DayInfoBloc, DayInfoState>(
      listener: (context, state) {
        // если произошла ошибка получения данных о погоде,
        // показываем SnackBar с информацией об ошибке
        if (state.errorMessage.isNotEmpty) {
          showErrorInfoSnackBar(
            context: context,
            text: state.errorMessage,
          );
        }
      },
      builder: (context, state) {
        return WillPopScope(
          onWillPop: () async {
            // принудительно скрываем SnackBar, чтоб он не оказался на другом экране
            ScaffoldMessenger.of(context).hideCurrentSnackBar();
            return true;
          },
          child: Scaffold(
            appBar: AppBar(
              title: Text(state.cityName),
              actions: [
                if (state.isShowThreeDaysButton)
                  IconButton(
                    onPressed: () {
                      // переходим на экран погоды за 3 дня
                      Navigator.of(context).push<void>(
                        MaterialPageRoute(
                          builder: (context) => ThreeDaysInfoScreen(
                            days: state.days,
                            cityName: state.cityName,
                          ),
                        ),
                      );
                    },
                    icon: const Icon(Icons.read_more),
                  ),
              ],
            ),
            body: Builder(
              builder: (context) {
                // если ошибка получения данных, отображаем это
                if (state.errorMessage.isNotEmpty) {
                  return const Center(
                    child: Text('Ошибка получения данных'),
                  );
                }

                // даём пользователю понять, что приложение не зависло, а ждёт данные о погоде
                if (state.days.isEmpty) {
                  return const Center(
                    child: CircularProgressIndicator(),
                  );
                }

                // когда данные о погоде получены, отображаем их
                return ListWeatherCard(
                  weatherTimes: state.days.first.weatherByTime,
                );
              },
            ),
          ),
        );
      },
    );
  }
}
