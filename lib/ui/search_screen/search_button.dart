// Flutter imports:
import 'package:flutter/material.dart';

// кнопка подтверждения получения погоды
class SearchButton extends StatelessWidget {
  final Function() onTap;

  const SearchButton({
    Key? key,
    required this.onTap,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      onPressed: onTap,
      child: const Text('Узнать погоду'),
    );
  }
}
