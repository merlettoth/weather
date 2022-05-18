class WeatherTime {
  final DateTime dateTime;
  final double temp;
  final int pressure;
  final int humidity;
  final String icon;
  final String description;
  final int clouds;
  final double windSpeed;
  final double pop;

  WeatherTime({
    required this.dateTime,
    required this.temp,
    required this.pressure,
    required this.humidity,
    required this.icon,
    required this.description,
    required this.clouds,
    required this.windSpeed,
    required this.pop,
  });
}
