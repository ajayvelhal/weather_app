import 'package:equatable/equatable.dart';
import 'package:weather_app/features/weather/domain/entities/weather.dart';

abstract class WeatherState extends Equatable {
  @override
  List<Object?> get props => [];
}

class WeatherInitial extends WeatherState {}

class WeatherLoading extends WeatherState {}

class WeatherFetched extends WeatherState {
  final Weather weather;

  WeatherFetched(this.weather);

  @override
  List<Object?> get props => [weather];
}

class WeatherError extends WeatherState {
  final String message;

  WeatherError(this.message);

  @override
  List<Object?> get props => [message];
}
