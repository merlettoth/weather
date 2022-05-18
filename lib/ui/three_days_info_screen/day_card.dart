// Flutter imports:
import 'package:flutter/material.dart';

// Project imports:
import 'package:weather/entity/day.dart';

// отображает карточку с данными о дате и средней температуре
// при клике на карточку будут отображаться данные о погоде выбранного дня по часам
class DayCard extends StatelessWidget {
  final Day day;
  final Function() onTap;

  const DayCard({
    Key? key,
    required this.day,
    required this.onTap,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
      child: Ink(
        color: Colors.lightBlue.shade100,
        height: 50,
        child: InkWell(
          onTap: onTap,
          child: Row(
            children: [
              Expanded(
                child: Padding(
                  padding: const EdgeInsets.only(left: 20),
                  child: Text(day.date.toString().split(' ').first),
                ),
              ),
              Expanded(
                child: Padding(
                  padding: const EdgeInsets.only(left: 20),
                  child: Text('${day.averageTemp.toStringAsFixed(2)} °C'),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
