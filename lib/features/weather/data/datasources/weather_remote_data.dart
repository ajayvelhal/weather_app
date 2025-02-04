import 'dart:convert';

import 'package:dio/dio.dart';

abstract class WeatherRemoteData {
  Future<Map<String, dynamic>> getCurrentLocationWeather(
      double lat, double long);

  Future<Map<String, dynamic>> getCityWeather(String cityName);
}

class WeatherRemoteDataImpl extends WeatherRemoteData {
  final Dio dio;

  WeatherRemoteDataImpl(this.dio);

  @override
  Future<Map<String, dynamic>> getCityWeather(String cityName) async {
    final resp =
        await dio.get('https://api-ninjas.com/api/weather?city=$cityName');

    if (resp.statusCode == 200) {
      return jsonDecode(resp.data);
    } else {
      throw Exception('Api failed to respond');
    }
  }

  @override
  Future<Map<String, dynamic>> getCurrentLocationWeather(
      double lat, double long) async {
    final resp =
        await dio.get('https://api-ninjas.com/api/weather?lat=$lat&lon=$long');

    if (resp.statusCode == 200) {
      return jsonDecode(resp.data);
    } else {
      throw Exception('Api failed to respond');
    }
  }
}
