// Flutter imports:
import 'package:flutter/material.dart';

// Project imports:
import 'package:weather/ui/day_info_screen/day_info_screen.dart';
import 'package:weather/ui/search_screen/search_button.dart';
import 'package:weather/ui/search_screen/search_text_field.dart';

// экран с полем ввода названия города и кнопкой подтвердить
class SearchScreen extends StatefulWidget {
  const SearchScreen({Key? key}) : super(key: key);

  @override
  State<SearchScreen> createState() => _SearchScreenState();
}

class _SearchScreenState extends State<SearchScreen> {
  final _controller = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Погода'),
      ),
      body: Column(
        children: [
          SearchTextField(controller: _controller),
          SearchButton(
            // переходим на экран погоды за сегодня
            onTap: () => Navigator.of(context).push<void>(
              MaterialPageRoute(
                builder: (context) => DayInfoScreen(
                  cityName: _controller.text,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
