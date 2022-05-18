// Flutter imports:
import 'package:flutter/material.dart';

// отображает название параметра о погоде и его значение
class WeatherParameter extends StatelessWidget {
  final String name;
  final String value;

  const WeatherParameter({
    Key? key,
    required this.name,
    required this.value,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 3),
      child: Row(
        children: [
          Expanded(
            child: Text(name),
          ),
          Expanded(
            child: Padding(
              padding: const EdgeInsets.only(left: 25),
              child: Text(value),
            ),
          ),
        ],
      ),
    );
  }
}
