import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'blocs/weather_bloc.dart';
import 'blocs/weather_event.dart';
import 'blocs/weather_state.dart';

class WeatherPage extends StatelessWidget {
  final TextEditingController _controller = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Weather App')),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            TextField(
              controller: _controller,
              decoration: const InputDecoration(hintText: 'Enter city name'),
            ),
            const SizedBox(height: 10),
            ElevatedButton(
              onPressed: () {
                final city = _controller.text;
                BlocProvider.of<WeatherBloc>(context).add(FetchWeatherByCity(city));
              },
              child: const Text('Get Weather'),
            ),
            const SizedBox(height: 20),
            BlocBuilder<WeatherBloc, WeatherState>(
              builder: (context, state) {
                if (state is WeatherLoading) {
                  return const Center(child: CircularProgressIndicator());
                } else if (state is WeatherError) {
                  return Center(child: Text(state.message, style: const TextStyle(color: Colors.red)));
                } else if (state is WeatherFetched) {
                  final weather = state.weather;
                  return Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text('${weather.cityName}', style: const TextStyle(fontSize: 24, fontWeight: FontWeight.bold)),
                      Text('Temperature: ${weather.temperature}°C'),
                      Text('Condition: ${weather.description}'),
                      Image.network('https://openweathermap.org/img/wn/${weather.icon}@2x.png'),
                    ],
                  );
                }
                return Container();
              },
            ),
          ],
        ),
      ),
    );
  }
}
