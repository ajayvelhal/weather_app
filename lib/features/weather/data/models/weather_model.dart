class WeatherModel {
  final String cityName;
  final double temperature;
  final String description;
  final String icon;

  WeatherModel(
      {required this.cityName,
      required this.temperature,
      required this.description,
      required this.icon});

  factory WeatherModel.fromJson(Map<String, dynamic> json) {
    return WeatherModel(
      cityName: json['city'],
      temperature: json['temp'].toDouble(),
      description: json['description'],
      icon: json['icon'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'city': cityName,
      'temp': temperature,
      'description': description,
      'icon': icon,
    };
  }
}
