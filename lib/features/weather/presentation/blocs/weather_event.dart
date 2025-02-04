import 'package:equatable/equatable.dart';

abstract class WeatherEvent extends Equatable {
  @override
  List<Object?> get props => [];
}

class FetchCurrentLocationWeather extends WeatherEvent {
  final double lat;
  final double long;

  FetchCurrentLocationWeather(this.lat, this.long);

  @override
  List<Object?> get props => [lat, long];
}

class FetchWeatherByCity extends WeatherEvent {
  final String city;

  FetchWeatherByCity(this.city);

  @override
  List<Object?> get props => [city];
}
