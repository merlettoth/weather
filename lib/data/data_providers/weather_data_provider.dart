// Package imports:
import 'package:http/http.dart';

// постащик данных; продоставляет необработанные данные
class WeatherDataProvider {
  final Client _httpClient;
  final String _baseUrl;
  final String _apiKey;

  WeatherDataProvider(
    this._httpClient,
    this._baseUrl,
    this._apiKey,
  );

  // совершает get-запрос в погодное api и возвзращает полученные данные в виде json
  Future<Response> getWeather(String query) {
    final queryParameters = <String, dynamic>{
      'appid': _apiKey,
      'q': query,
      'units': 'metric',
      'cnt': '24',
      'lang': 'ru',
    };

    final uri = Uri.parse(_baseUrl).replace(queryParameters: queryParameters);
    return _httpClient.get(uri);
  }
}
