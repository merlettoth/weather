// Flutter imports:
import 'package:flutter/material.dart';

// Project imports:
import 'package:weather/ui/search_screen/search_screen.dart';

class App extends StatelessWidget {
  const App({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      title: 'Weather',
      home: SearchScreen(),
    );
  }
}
