import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:weather_app/features/weather/data/datasources/weather_remote_data.dart';
import 'package:weather_app/features/weather/data/repositories/weather_repository.dart';
import 'package:weather_app/features/weather/domain/usecases/current_location_weather.dart';
import 'package:weather_app/features/weather/domain/usecases/get_city_weather.dart';
import 'package:weather_app/features/weather/presentation/blocs/weather_event.dart';

import 'features/weather/presentation/blocs/weather_bloc.dart';
import 'features/weather/presentation/weather_page.dart';

void main() {
  final Dio dio = Dio();
  final weatherRemoteData = WeatherRemoteDataImpl(dio);
  final weatherRepository = WeatherRepositoryImpl(weatherRemoteData);
  final getWeatherByLocation = CurrentLocationWeather(weatherRepository);
  final getWeatherByCity = GetCityWeather(weatherRepository);

  runApp(MyApp(
    getWeatherByCoordinates: getWeatherByLocation,
    getWeatherByCity: getWeatherByCity,
  ));
}

class MyApp extends StatelessWidget {
  final CurrentLocationWeather getWeatherByCoordinates;
  final GetCityWeather getWeatherByCity;

  const MyApp(
      {super.key,
      required this.getWeatherByCoordinates,
      required this.getWeatherByCity});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) => WeatherBloc(getWeatherByCoordinates, getWeatherByCity),
      child: MaterialApp(
        title: 'Weather App',
        theme: ThemeData(primarySwatch: Colors.blue),
        home: WeatherPage(),
      ),
    );
  }
}
