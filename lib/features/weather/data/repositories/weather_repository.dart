
import 'package:weather_app/core/error/failure.dart';
import 'package:dartz/dartz.dart';
import 'package:weather_app/features/weather/data/datasources/weather_remote_data.dart';
import '../../domain/entities/weather.dart';
import '../models/weather_model.dart';

abstract class WeatherRepository {

  Future<Either<Failure,Weather>> getCurrentLocationWeather(double lat,double long);

  Future<Either<Failure,Weather>> getCityWeather(String cityName);


}

class WeatherRepositoryImpl extends WeatherRepository{

  final WeatherRemoteData remoteData;

  WeatherRepositoryImpl(this.remoteData);

  @override
  Future<Either<Failure, Weather>> getCityWeather(String cityName) async {
    try {
      final weatherData = await remoteData.getCityWeather(cityName);
      print(weatherData);
      return Right(WeatherModel.fromJson(weatherData) as Weather);

    } catch (e) {
      return Left(Failure('Failed to load weather data'));
    }
  }

  @override
  Future<Either<Failure, Weather>> getCurrentLocationWeather(double lat, double long) async {
    try {
      final weatherData = await remoteData.getCurrentLocationWeather(lat, long);

      return Right(WeatherModel.fromJson(weatherData) as Weather);
    } catch (e) {
      return Left(Failure('Failed to load weather data'));
    }
  }


}
