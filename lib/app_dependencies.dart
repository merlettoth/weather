// Flutter imports:
import 'package:flutter/material.dart';

// Package imports:
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:http/http.dart';

// Project imports:
import 'package:weather/data/data_providers/weather_data_provider.dart';
import 'package:weather/data/repositories/weather_repository.dart';
import 'package:weather/utils/url_constants.dart';

class AppDependencies extends StatelessWidget {
  final Widget app;

  const AppDependencies({Key? key, required this.app}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final weatherDataProvider = WeatherDataProvider(
      Client(),
      UrlConstants.baseUrl,
      UrlConstants.apiKey,
    );
    final weatherRepository = WeatherRepository(weatherDataProvider);

    // внедряем зависимость WeatherRepository
    return RepositoryProvider<WeatherRepository>(
      create: (context) => weatherRepository,
      child: app,
    );
  }
}
