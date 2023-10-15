part of 'weather_cubit.dart';

class WeatherState extends Equatable {
  const WeatherState();

  @override
  List<Object> get props => [];
}

class WeatherInitial extends WeatherState {}

class CurrentWeather extends WeatherState {
  final WeatherModel weatherModel;
  const CurrentWeather(this.weatherModel);

  @override
  List<Object> get props => [weatherModel];
}
