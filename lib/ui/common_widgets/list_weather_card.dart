// Flutter imports:
import 'package:flutter/material.dart';

// Project imports:
import 'package:weather/entity/weather_time.dart';
import 'package:weather/ui/common_widgets/weather_card.dart';

// отображает информацию о погоде за весь оставшийся день
class ListWeatherCard extends StatelessWidget {
  final List<WeatherTime> weatherTimes;

  const ListWeatherCard({
    Key? key,
    required this.weatherTimes,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ListView.separated(
      itemCount: weatherTimes.length,
      separatorBuilder: (context, index) => const Divider(
        thickness: 3,
      ),
      itemBuilder: (context, index) => WeatherCard(
        weatherTime: weatherTimes[index],
      ),
    );
  }
}
