import 'package:dartz/dartz.dart';
import 'package:weather_app/core/usecases/usecase.dart';
import 'package:weather_app/features/weather/data/repositories/weather_repository.dart';

import '../../../../core/error/failure.dart';
import '../entities/weather.dart';
class CityParams {
  final String city;

  CityParams(this.city);
}
class GetCityWeather extends Usecase<Weather,CityParams>{

  final WeatherRepository weatherRepository;

  GetCityWeather(this.weatherRepository);


  @override
  Future<Either<Failure, Weather>> call(params) async {
    return await weatherRepository.getCityWeather(params.city);
  }


}