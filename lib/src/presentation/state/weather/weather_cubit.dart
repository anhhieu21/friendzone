// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:friendzone/src/domain/models/weather.dart';

import 'package:friendzone/src/domain/repositories/weather_repository.dart';

part 'weather_state.dart';

class WeatherCubit extends Cubit<WeatherState> {
  final WeatherRepository _weatherRepository;
  WeatherCubit(
    this._weatherRepository,
  ) : super(WeatherInitial()) {
    currentWeather();
  }

  currentWeather() async {
    final weather = await _weatherRepository.currentWeatherData();
    emit(CurrentWeather(weather));
  }
}
