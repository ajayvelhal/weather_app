import 'package:weather_app/core/usecases/usecase.dart';
import 'package:weather_app/features/weather/domain/entities/weather.dart';
import 'package:weather_app/features/weather/data/repositories/weather_repository.dart';
import 'package:dartz/dartz.dart';
import 'package:weather_app/core/error/failure.dart';

class CoordinatesParams {
  final double lat;
  final double long;

  CoordinatesParams(this.lat, this.long);
}

class CurrentLocationWeather extends Usecase<Weather, CoordinatesParams> {
  final WeatherRepository weatherRepository;

  CurrentLocationWeather(this.weatherRepository);

  @override
  Future<Either<Failure, Weather>> call(CoordinatesParams params) async {
    return await weatherRepository.getCurrentLocationWeather(
        params.lat, params.long);
  }
}
