// Flutter imports:
import 'package:flutter/material.dart';

// Project imports:
import 'package:weather/app_dependencies.dart';
import 'package:weather/ui/app.dart';

// точка входа в приложение
void main() {
  runApp(
    const AppDependencies(
      app: App(),
    ),
  );
}
