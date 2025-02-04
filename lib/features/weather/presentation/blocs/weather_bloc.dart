import 'package:weather_app/features/weather/presentation/blocs/weather_event.dart';
import 'package:weather_app/features/weather/presentation/blocs/weather_state.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../domain/usecases/current_location_weather.dart';
import '../../domain/usecases/get_city_weather.dart';

class WeatherBloc extends Bloc<WeatherEvent, WeatherState> {
  final CurrentLocationWeather currentLocationWeather;
  final GetCityWeather getCityWeather;

  WeatherBloc(this.currentLocationWeather, this.getCityWeather)
      : super(WeatherInitial());

  @override
  Stream<WeatherState> mapEventToState(WeatherEvent event) async* {
    if (event is FetchCurrentLocationWeather) {
      yield WeatherLoading();
      final result = await currentLocationWeather(
          CoordinatesParams(event.lat, event.long));
      yield* result.fold(
        (failure) async* {
          yield WeatherError(failure.message);
        },
        (weather) async* {
          yield WeatherFetched(weather);
        },
      );
    }

    if (event is FetchWeatherByCity) {
      yield WeatherLoading();
      final result = await getCityWeather(CityParams(event.city));
      yield* result.fold(
        (failure) async* {
          yield WeatherError(failure.message);
        },
        (weather) async* {
          yield WeatherFetched(weather);
        },
      );
    }
  }
}
