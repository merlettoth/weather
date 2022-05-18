// Package imports:
import 'package:flutter_bloc/flutter_bloc.dart';

// Project imports:
import 'package:weather/business/three_days_info_bloc/three_days_info_events.dart';
import 'package:weather/business/three_days_info_bloc/three_days_info_state.dart';

// управляем состоянием экрана данных о погоде в выбранном городе за 3 дня
class ThreeDaysInfoBloc extends Bloc<ThreeDaysInfoEvent, ThreeDaysInfoState> {
  ThreeDaysInfoBloc() : super(ThreeDaysInfoState()) {
    // инициализируем состояние при открытии экрана
    on<GetDaysWeather>((event, emit) {
      emit(
        state.copywith(
          days: event.days,
          cityName: event.cityName,
          appBarTitle: '${event.cityName} · 3 дня',
        ),
      );
    });

    // выбираем погоду какого дня отображать
    on<SelectDay>((event, emit) {
      final appBarTitle =
          '${state.cityName} · ${state.days[event.index].date.toString().split(' ').first}';
      emit(
        state.copywith(
          indexSelectedDay: event.index,
          appBarTitle: appBarTitle,
        ),
      );
    });

    // перестаём отображать погоду конкретного дня и отбражаем список дней
    on<CancelSelectionDay>((event, emit) {
      emit(
        state.copywith(
          indexSelectedDay: -1,
          appBarTitle: '${state.cityName} · 3 дня',
        ),
      );
    });
  }
}
