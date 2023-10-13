import 'package:friendzone/src/data/services/dio_client.dart';
import 'package:friendzone/src/domain/repositories/weather_repository.dart';

// http://api.openweathermap.org/geo/1.0/direct?q={city name},{state code},{country code}&limit={limit}&appid={API key}
class WeatherRepositoryImpl implements WeatherRepository {
  static String keyApiWeather = '';

  WeatherRepositoryImpl._();
  static final instance = WeatherRepositoryImpl._();

  ///Access current weather data for any location
  @override
  Future currentWeatherData() async {
    final res = await DioClient.instance
        .get('/data/2.5/weather?lat={lat}&lon={lon}&appid=$keyApiWeather');
  }

  ///- Hourly forecast is available for 4 days
  ///
  ///- Forecast weather data for 96 timestamps
  ///
  ///- JSON and XML formats
  ///
  ///- Included in the Developer, Professional and Enterprise subscription plans
  @override
  Future availableFor4Days() async {}

  Future currentLocation() async {
    final res = await DioClient.instance
        .get('/geo/1.0/direct?q=Danang&limit=1&appid=$keyApiWeather');
    print(res);
  }
}
