// Dart imports:
import 'dart:io';

// Package imports:
import 'package:flutter_bloc/flutter_bloc.dart';

// Project imports:
import 'package:weather/business/day_info_bloc/day_info_events.dart';
import 'package:weather/business/day_info_bloc/day_info_state.dart';
import 'package:weather/data/repositories/weather_repository.dart';
import 'package:weather/utils/custom_exceptions.dart';

// управляем состоянием экрана данных о погоде в выбранном городе за сегодня
class DayInfoBloc extends Bloc<GetCityWeather, DayInfoState> {
  final WeatherRepository weatherRepository;

  DayInfoBloc(this.weatherRepository) : super(DayInfoState()) {
    on<GetCityWeather>((event, emit) async {
      emit(state.copywith(cityName: event.cityName));
      try {
        // если данные о погоде получены, отображаем их и кнопку перехода на экран данных о погоде за 3 дня
        final days = await weatherRepository.getDaysWeather(event.cityName);
        emit(state.copywith(days: days, isShowThreeDaysButton: true));
      }
      // если данные о погоде не получены, отображаем информацию об ошибке
      on CityNotFoundException catch (e) {
        emit(state.copywith(errorMessage: e.message));
      } on SocketException catch (_) {
        emit(state.copywith(errorMessage: 'Проблемы с интернетом'));
      } catch (_) {
        emit(state.copywith(errorMessage: 'Ошибка'));
      }
    });
  }
}
