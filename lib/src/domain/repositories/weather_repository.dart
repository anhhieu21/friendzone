import 'package:friendzone/src/domain/models/weather.dart';

abstract class WeatherRepository {
  ///Access current weather data for any location
  Future<WeatherModel> currentWeatherData();

  ///- Hourly forecast is available for 4 days
  ///
  ///- Forecast weather data for 96 timestamps
  ///
  ///- JSON and XML formats
  ///
  ///- Included in the Developer, Professional and Enterprise subscription plans
  Future availableFor4Days();
}
