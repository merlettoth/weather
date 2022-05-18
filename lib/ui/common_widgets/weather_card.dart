// Flutter imports:
import 'package:flutter/material.dart';

// Project imports:
import 'package:weather/entity/weather_time.dart';
import 'package:weather/ui/common_widgets/weather_paremeter.dart';

// отображает информацию о погоде в конкретное время
class WeatherCard extends StatelessWidget {
  final WeatherTime weatherTime;

  const WeatherCard({
    Key? key,
    required this.weatherTime,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 20),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Row(
            children: [
              Expanded(
                child: Column(
                  children: [
                    Text('${weatherTime.dateTime.hour}:00'),
                    const SizedBox(height: 10),
                    Text(weatherTime.description),
                  ],
                ),
              ),
              Expanded(
                child: Image.network(
                  'http://openweathermap.org/img/wn/${weatherTime.icon}@4x.png',
                  height: 100,
                ),
              ),
            ],
          ),
          WeatherParameter(
            name: 'Температура, °C',
            value: weatherTime.temp.toString(),
          ),
          WeatherParameter(
            name: 'Давление, ГПа ',
            value: weatherTime.pressure.toString(),
          ),
          WeatherParameter(
            name: 'Влажность, %',
            value: weatherTime.humidity.toString(),
          ),
          WeatherParameter(
            name: 'Облачность, %',
            value: weatherTime.clouds.toString(),
          ),
          WeatherParameter(
            name: 'Скорость ветра, м/с',
            value: weatherTime.windSpeed.toString(),
          ),
          WeatherParameter(
            name: 'Вероятность осадков, %',
            value: (weatherTime.pop * 100).toStringAsFixed(0),
          ),
        ],
      ),
    );
  }
}
