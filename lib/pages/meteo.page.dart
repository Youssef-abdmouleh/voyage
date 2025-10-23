import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

import 'menu/drawer.widger.dart';

class MeteoPage extends StatefulWidget {
  final APIkey = "3a70252a3fc0fd63ec3137524929253d";

  // var lang = "ar";
  // String weatherUrl= "https://api.openweathermap.org/data/2.5/forecast?q=${sityName}&appid=${APIkey}&lang=${lang}";

  @override
  State<MeteoPage> createState() => _MeteoPageState();
}

class _MeteoPageState extends State<MeteoPage> {
  TextEditingController cityName = TextEditingController();
  var lang = "ar";
  final APIkey = "3a70252a3fc0fd63ec3137524929253d";

  WeatherResponse? weatherData;
  bool isLoading = false;
  String? errorMessage;
  int? expandedIndex; // Track which forecast item is expanded (-1 for current weather)

  Future<void> fetchWeather() async {
    if (cityName.text
        .trim()
        .isEmpty) {
      setState(() {
        errorMessage = "Please enter a city name";
      });
      return;
    }

    setState(() {
      isLoading = true;
      errorMessage = null;
    });

    try {
      // Replace with your actual API endpoint and key
      final response = await http.get(
        Uri.parse(
          "https://api.openweathermap.org/data/2.5/forecast?q=${cityName
              .text}&appid=${APIkey}&lang=${lang}",
        ),
      );

      if (response.statusCode == 200) {
        setState(() {
          weatherData = WeatherResponse.fromJson(json.decode(response.body));
          isLoading = false;
          expandedIndex = -1; // -1 means current weather is expanded
        });
      } else {
        setState(() {
          errorMessage = "Failed to load weather data";
          isLoading = false;
        });
      }
    } catch (e) {
      setState(() {
        errorMessage = "Error: $e";
        isLoading = false;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      drawer: MyDrawer(),
      appBar: AppBar(
        title: Text("Page meteo", style: TextStyle(color: Colors.white)),
        backgroundColor: Colors.green,
      ),
      body: Column(
        children: [
          // Search Bar Section
          Container(
            padding: const EdgeInsets.all(16.0),
            decoration: BoxDecoration(
              color: Colors.green.shade50,
              boxShadow: [
                BoxShadow(
                  color: Colors.grey.shade300,
                  blurRadius: 4,
                  offset: const Offset(0, 2),
                ),
              ],
            ),
            child: Column(
              children: [
                TextField(
                  controller: cityName,
                  decoration: InputDecoration(
                    hintText: 'Enter city name',
                    prefixIcon: const Icon(Icons.search, color: Colors.green),
                    filled: true,
                    fillColor: Colors.white,
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(12),
                      borderSide: BorderSide.none,
                    ),
                    enabledBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(12),
                      borderSide: BorderSide(color: Colors.green.shade200),
                    ),
                    focusedBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(12),
                      borderSide: const BorderSide(
                        color: Colors.green,
                        width: 2,
                      ),
                    ),
                  ),
                ),
                const SizedBox(height: 12),
                SizedBox(
                  width: double.infinity,
                  child: ElevatedButton(
                    onPressed: isLoading ? null : fetchWeather,
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.green,
                      foregroundColor: Colors.white,
                      padding: const EdgeInsets.symmetric(vertical: 14),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(12),
                      ),
                      elevation: 2,
                    ),
                    child: isLoading
                        ? const SizedBox(
                      height: 20,
                      width: 20,
                      child: CircularProgressIndicator(
                        color: Colors.white,
                        strokeWidth: 2,
                      ),
                    )
                        : const Text(
                      'Search Weather',
                      style: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),

          // Error Message
          if (errorMessage != null)
            Container(
              margin: const EdgeInsets.all(16),
              padding: const EdgeInsets.all(12),
              decoration: BoxDecoration(
                color: Colors.red.shade50,
                borderRadius: BorderRadius.circular(8),
                border: Border.all(color: Colors.red.shade200),
              ),
              child: Row(
                children: [
                  Icon(Icons.error_outline, color: Colors.red.shade700),
                  const SizedBox(width: 8),
                  Expanded(
                    child: Text(
                      errorMessage!,
                      style: TextStyle(color: Colors.red.shade700),
                    ),
                  ),
                ],
              ),
            ),

          // Weather Data Display
          if (weatherData != null)
            Expanded(
              child: SingleChildScrollView(
                padding: const EdgeInsets.all(16),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    // City Info Card
                    Card(
                      elevation: 3,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(16),
                      ),
                      child: Container(
                        width: double.infinity,
                        padding: const EdgeInsets.all(20),
                        decoration: BoxDecoration(
                          gradient: LinearGradient(
                            colors: [
                              Colors.green.shade400,
                              Colors.green.shade600,
                            ],
                            begin: Alignment.topLeft,
                            end: Alignment.bottomRight,
                          ),
                          borderRadius: BorderRadius.circular(16),
                        ),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Row(
                              children: [
                                const Icon(
                                  Icons.location_on,
                                  color: Colors.white,
                                  size: 28,
                                ),
                                const SizedBox(width: 8),
                                Text(
                                  weatherData!.city.name,
                                  style: const TextStyle(
                                    fontSize: 28,
                                    fontWeight: FontWeight.bold,
                                    color: Colors.white,
                                  ),
                                ),
                              ],
                            ),
                            const SizedBox(height: 8),
                            Text(
                              '${weatherData!.city
                                  .country} • Population: ${weatherData!.city
                                  .population}',
                              style: const TextStyle(
                                fontSize: 14,
                                color: Colors.white70,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                    const SizedBox(height: 16),

                    // Current Weather
                    if (weatherData!.list.isNotEmpty)
                      Card(
                        elevation: 2,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(16),
                        ),
                        child: InkWell(
                          onTap: () {
                            setState(() {
                              expandedIndex = expandedIndex == -1 ? null : -1;
                            });
                          },
                          borderRadius: BorderRadius.circular(16),
                          child: Padding(
                            padding: const EdgeInsets.all(16),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Row(
                                  mainAxisAlignment: MainAxisAlignment
                                      .spaceBetween,
                                  children: [
                                    const Text(
                                      'Current Weather',
                                      style: TextStyle(
                                        fontSize: 20,
                                        fontWeight: FontWeight.bold,
                                        color: Colors.green,
                                      ),
                                    ),
                                    Icon(
                                      expandedIndex == -1
                                          ? Icons.keyboard_arrow_up
                                          : Icons.keyboard_arrow_down,
                                      color: Colors.green,
                                    ),
                                  ],
                                ),
                                const SizedBox(height: 8),
                                // Always show summary
                                Row(
                                  children: [
                                    Icon(
                                      Icons.thermostat,
                                      color: Colors.orange.shade400,
                                      size: 20,
                                    ),
                                    const SizedBox(width: 4),
                                    Text(
                                      '${(weatherData!.list[0].main.temp -
                                          273.15).toStringAsFixed(1)}°C',
                                      style: const TextStyle(
                                        fontSize: 16,
                                        fontWeight: FontWeight.w600,
                                      ),
                                    ),
                                    const SizedBox(width: 16),
                                    Expanded(
                                      child: Text(
                                        weatherData!.list[0].weather[0]
                                            .description,
                                        style: TextStyle(
                                          fontSize: 14,
                                          color: Colors.grey.shade700,
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                                // Detailed info when expanded
                                if (expandedIndex == -1) ...[
                                  const SizedBox(height: 16),
                                  Row(
                                    mainAxisAlignment:
                                    MainAxisAlignment.spaceAround,
                                    children: [
                                      _buildWeatherInfo(
                                        Icons.thermostat,
                                        '${(weatherData!.list[0].main.temp -
                                            273.15).toStringAsFixed(1)}°C',
                                        'Temperature',
                                        Colors.orange,
                                      ),
                                      _buildWeatherInfo(
                                        Icons.water_drop,
                                        '${weatherData!.list[0].main
                                            .humidity}%',
                                        'Humidity',
                                        Colors.blue,
                                      ),
                                    ],
                                  ),
                                  const SizedBox(height: 16),
                                  Row(
                                    mainAxisAlignment:
                                    MainAxisAlignment.spaceAround,
                                    children: [
                                      _buildWeatherInfo(
                                        Icons.air,
                                        '${weatherData!.list[0].wind
                                            .speed} m/s',
                                        'Wind Speed',
                                        Colors.teal,
                                      ),
                                      _buildWeatherInfo(
                                        Icons.compress,
                                        '${weatherData!.list[0].main
                                            .pressure} hPa',
                                        'Pressure',
                                        Colors.purple,
                                      ),
                                    ],
                                  ),
                                  const SizedBox(height: 16),
                                  Container(
                                    padding: const EdgeInsets.all(12),
                                    decoration: BoxDecoration(
                                      color: Colors.blue.shade50,
                                      borderRadius: BorderRadius.circular(12),
                                    ),
                                    child: Row(
                                      children: [
                                        Icon(
                                          Icons.cloud,
                                          color: Colors.blue.shade700,
                                          size: 32,
                                        ),
                                        const SizedBox(width: 12),
                                        Expanded(
                                          child: Column(
                                            crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                            children: [
                                              Text(
                                                weatherData!
                                                    .list[0]
                                                    .weather[0]
                                                    .main,
                                                style: TextStyle(
                                                  fontSize: 18,
                                                  fontWeight: FontWeight.bold,
                                                  color: Colors.blue.shade900,
                                                ),
                                              ),
                                              Text(
                                                weatherData!
                                                    .list[0]
                                                    .weather[0]
                                                    .description,
                                                style: TextStyle(
                                                  fontSize: 14,
                                                  color: Colors.blue.shade700,
                                                ),
                                              ),
                                            ],
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                  const SizedBox(height: 12),
                                  // Additional details
                                  _buildDetailRow('Feels Like',
                                      '${(weatherData!.list[0].main.feelsLike -
                                          273.15).toStringAsFixed(1)}°C'),
                                  _buildDetailRow('Min Temp',
                                      '${(weatherData!.list[0].main.tempMin -
                                          273.15).toStringAsFixed(1)}°C'),
                                  _buildDetailRow('Max Temp',
                                      '${(weatherData!.list[0].main.tempMax -
                                          273.15).toStringAsFixed(1)}°C'),
                                  _buildDetailRow('Visibility',
                                      '${(weatherData!.list[0].visibility /
                                          1000).toStringAsFixed(1)} km'),
                                  _buildDetailRow('Wind Gust',
                                      '${weatherData!.list[0].wind.gust} m/s'),
                                ],
                              ],
                            ),
                          ),
                        ),
                      ),

                    const SizedBox(height: 16),

                    // Forecast List
                    const Text(
                      'Forecast',
                      style: TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                        color: Colors.green,
                      ),
                    ),
                    const SizedBox(height: 12),
                    ListView.builder(
                      shrinkWrap: true,
                      physics: const NeverScrollableScrollPhysics(),
                      itemCount: weatherData!.list.length.clamp(0, 10),
                      itemBuilder: (context, index) {
                        final item = weatherData!.list[index];
                        final isExpanded = expandedIndex == index;

                        return Card(
                          margin: const EdgeInsets.only(bottom: 8),
                          elevation: isExpanded ? 3 : 1,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(12),
                          ),
                          child: InkWell(
                            onTap: () {
                              setState(() {
                                expandedIndex = isExpanded ? null : index;
                              });
                            },
                            borderRadius: BorderRadius.circular(12),
                            child: Padding(
                              padding: const EdgeInsets.all(12),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  // Summary Row (always visible)
                                  Row(
                                    children: [
                                      Container(
                                        padding: const EdgeInsets.all(8),
                                        decoration: BoxDecoration(
                                          color: Colors.green.shade50,
                                          borderRadius: BorderRadius.circular(
                                              8),
                                        ),
                                        child: Icon(
                                          Icons.calendar_today,
                                          color: Colors.green.shade700,
                                          size: 20,
                                        ),
                                      ),
                                      const SizedBox(width: 12),
                                      Expanded(
                                        child: Column(
                                          crossAxisAlignment: CrossAxisAlignment
                                              .start,
                                          children: [
                                            Text(
                                              item.dtTxt,
                                              style: const TextStyle(
                                                fontWeight: FontWeight.w600,
                                                fontSize: 14,
                                              ),
                                            ),
                                            const SizedBox(height: 4),
                                            Text(
                                              '${item.weather[0]
                                                  .description} • ${(item.main
                                                  .temp - 273.15)
                                                  .toStringAsFixed(1)}°C',
                                              style: TextStyle(
                                                fontSize: 13,
                                                color: Colors.grey.shade700,
                                              ),
                                            ),
                                          ],
                                        ),
                                      ),
                                      Row(
                                        mainAxisSize: MainAxisSize.min,
                                        children: [
                                          Icon(
                                            Icons.water_drop,
                                            size: 16,
                                            color: Colors.blue.shade400,
                                          ),
                                          const SizedBox(width: 4),
                                          Text('${item.main.humidity}%'),
                                          const SizedBox(width: 8),
                                          Icon(
                                            isExpanded
                                                ? Icons.keyboard_arrow_up
                                                : Icons.keyboard_arrow_down,
                                            color: Colors.green,
                                          ),
                                        ],
                                      ),
                                    ],
                                  ),

                                  // Detailed Info (shown when expanded)
                                  if (isExpanded) ...[
                                    const Divider(height: 24),
                                    Row(
                                      mainAxisAlignment: MainAxisAlignment
                                          .spaceAround,
                                      children: [
                                        _buildWeatherInfo(
                                          Icons.thermostat,
                                          '${(item.main.temp - 273.15)
                                              .toStringAsFixed(1)}°C',
                                          'Temperature',
                                          Colors.orange,
                                        ),
                                        _buildWeatherInfo(
                                          Icons.water_drop,
                                          '${item.main.humidity}%',
                                          'Humidity',
                                          Colors.blue,
                                        ),
                                      ],
                                    ),
                                    const SizedBox(height: 16),
                                    Row(
                                      mainAxisAlignment: MainAxisAlignment
                                          .spaceAround,
                                      children: [
                                        _buildWeatherInfo(
                                          Icons.air,
                                          '${item.wind.speed} m/s',
                                          'Wind Speed',
                                          Colors.teal,
                                        ),
                                        _buildWeatherInfo(
                                          Icons.compress,
                                          '${item.main.pressure} hPa',
                                          'Pressure',
                                          Colors.purple,
                                        ),
                                      ],
                                    ),
                                    const SizedBox(height: 16),
                                    Container(
                                      padding: const EdgeInsets.all(12),
                                      decoration: BoxDecoration(
                                        color: Colors.blue.shade50,
                                        borderRadius: BorderRadius.circular(12),
                                      ),
                                      child: Row(
                                        children: [
                                          Icon(
                                            Icons.cloud,
                                            color: Colors.blue.shade700,
                                            size: 32,
                                          ),
                                          const SizedBox(width: 12),
                                          Expanded(
                                            child: Column(
                                              crossAxisAlignment: CrossAxisAlignment
                                                  .start,
                                              children: [
                                                Text(
                                                  item.weather[0].main,
                                                  style: TextStyle(
                                                    fontSize: 18,
                                                    fontWeight: FontWeight.bold,
                                                    color: Colors.blue.shade900,
                                                  ),
                                                ),
                                                Text(
                                                  item.weather[0].description,
                                                  style: TextStyle(
                                                    fontSize: 14,
                                                    color: Colors.blue.shade700,
                                                  ),
                                                ),
                                              ],
                                            ),
                                          ),
                                        ],
                                      ),
                                    ),
                                    const SizedBox(height: 12),
                                    _buildDetailRow('Feels Like',
                                        '${(item.main.feelsLike - 273.15)
                                            .toStringAsFixed(1)}°C'),
                                    _buildDetailRow('Min Temp',
                                        '${(item.main.tempMin - 273.15)
                                            .toStringAsFixed(1)}°C'),
                                    _buildDetailRow('Max Temp',
                                        '${(item.main.tempMax - 273.15)
                                            .toStringAsFixed(1)}°C'),
                                    _buildDetailRow('Visibility',
                                        '${(item.visibility / 1000)
                                            .toStringAsFixed(1)} km'),
                                    _buildDetailRow(
                                        'Wind Gust', '${item.wind.gust} m/s'),
                                    _buildDetailRow(
                                        'Cloudiness', '${item.clouds.all}%'),
                                  ],
                                ],
                              ),
                            ),
                          ),
                        );
                      },
                    ),
                  ],
                ),
              ),
            ),

          // Empty State
          if (weatherData == null && !isLoading && errorMessage == null)
            Expanded(
              child: Center(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Icon(
                      Icons.wb_sunny,
                      size: 80,
                      color: Colors.green.shade200,
                    ),
                    const SizedBox(height: 16),
                    Text(
                      'Search for a city to see weather',
                      style: TextStyle(
                        fontSize: 16,
                        color: Colors.grey.shade600,
                      ),
                    ),
                  ],
                ),
              ),
            ),
        ],
      ),
    );
  }

  Widget _buildWeatherInfo(IconData icon,
      String value,
      String label,
      Color color,) {
    return Column(
      children: [
        Container(
          padding: const EdgeInsets.all(12),
          decoration: BoxDecoration(
            color: color.withOpacity(0.1),
            borderRadius: BorderRadius.circular(12),
          ),
          child: Icon(icon, color: color, size: 28),
        ),
        const SizedBox(height: 8),
        Text(
          value,
          style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
        ),
        const SizedBox(height: 4),
        Text(
          label,
          style: TextStyle(fontSize: 12, color: Colors.grey.shade600),
        ),
      ],
    );
  }

  Widget _buildDetailRow(String label, String value) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 4),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            label,
            style: TextStyle(
              fontSize: 14,
              color: Colors.grey.shade700,
            ),
          ),
          Text(
            value,
            style: const TextStyle(
              fontSize: 14,
              fontWeight: FontWeight.w600,
            ),
          ),
        ],
      ),
    );
  }
}

// Data Models
class WeatherResponse {
  final String cod;
  final int message;
  final int cnt;
  final List<WeatherItem> list;
  final City city;

  WeatherResponse({
    required this.cod,
    required this.message,
    required this.cnt,
    required this.list,
    required this.city,
  });

  factory WeatherResponse.fromJson(Map<String, dynamic> json) {
    return WeatherResponse(
      cod: json['cod'].toString(),
      message: json['message'] ?? 0,
      cnt: json['cnt'] ?? 0,
      list: (json['list'] as List)
          .map((item) => WeatherItem.fromJson(item))
          .toList(),
      city: City.fromJson(json['city']),
    );
  }
}

class WeatherItem {
  final int dt;
  final MainWeather main;
  final List<Weather> weather;
  final Clouds clouds;
  final Wind wind;
  final int visibility;
  final double pop;
  final String dtTxt;

  WeatherItem({
    required this.dt,
    required this.main,
    required this.weather,
    required this.clouds,
    required this.wind,
    required this.visibility,
    required this.pop,
    required this.dtTxt,
  });

  factory WeatherItem.fromJson(Map<String, dynamic> json) {
    return WeatherItem(
      dt: json['dt'],
      main: MainWeather.fromJson(json['main']),
      weather: (json['weather'] as List)
          .map((w) => Weather.fromJson(w))
          .toList(),
      clouds: Clouds.fromJson(json['clouds']),
      wind: Wind.fromJson(json['wind']),
      visibility: json['visibility'] ?? 0,
      pop: (json['pop'] ?? 0).toDouble(),
      dtTxt: json['dt_txt'] ?? '',
    );
  }
}

class MainWeather {
  final double temp;
  final double feelsLike;
  final double tempMin;
  final double tempMax;
  final int pressure;
  final int seaLevel;
  final int grndLevel;
  final int humidity;
  final double tempKf;

  MainWeather({
    required this.temp,
    required this.feelsLike,
    required this.tempMin,
    required this.tempMax,
    required this.pressure,
    required this.seaLevel,
    required this.grndLevel,
    required this.humidity,
    required this.tempKf,
  });

  factory MainWeather.fromJson(Map<String, dynamic> json) {
    return MainWeather(
      temp: (json['temp'] ?? 0).toDouble(),
      feelsLike: (json['feels_like'] ?? 0).toDouble(),
      tempMin: (json['temp_min'] ?? 0).toDouble(),
      tempMax: (json['temp_max'] ?? 0).toDouble(),
      pressure: json['pressure'] ?? 0,
      seaLevel: json['sea_level'] ?? 0,
      grndLevel: json['grnd_level'] ?? 0,
      humidity: json['humidity'] ?? 0,
      tempKf: (json['temp_kf'] ?? 0).toDouble(),
    );
  }
}

class Weather {
  final int id;
  final String main;
  final String description;
  final String icon;

  Weather({
    required this.id,
    required this.main,
    required this.description,
    required this.icon,
  });

  factory Weather.fromJson(Map<String, dynamic> json) {
    return Weather(
      id: json['id'],
      main: json['main'] ?? '',
      description: json['description'] ?? '',
      icon: json['icon'] ?? '',
    );
  }
}

class Clouds {
  final int all;

  Clouds({required this.all});

  factory Clouds.fromJson(Map<String, dynamic> json) {
    return Clouds(all: json['all'] ?? 0);
  }
}

class Wind {
  final double speed;
  final int deg;
  final double gust;

  Wind({required this.speed, required this.deg, required this.gust});

  factory Wind.fromJson(Map<String, dynamic> json) {
    return Wind(
      speed: (json['speed'] ?? 0).toDouble(),
      deg: json['deg'] ?? 0,
      gust: (json['gust'] ?? 0).toDouble(),
    );
  }
}

class City {
  final int id;
  final String name;
  final Coord coord;
  final String country;
  final int population;
  final int timezone;
  final int sunrise;
  final int sunset;

  City({
    required this.id,
    required this.name,
    required this.coord,
    required this.country,
    required this.population,
    required this.timezone,
    required this.sunrise,
    required this.sunset,
  });

  factory City.fromJson(Map<String, dynamic> json) {
    return City(
      id: json['id'] ?? 0,
      name: json['name'] ?? '',
      coord: Coord.fromJson(json['coord']),
      country: json['country'] ?? '',
      population: json['population'] ?? 0,
      timezone: json['timezone'] ?? 0,
      sunrise: json['sunrise'] ?? 0,
      sunset: json['sunset'] ?? 0,
    );
  }
}

class Coord {
  final double lat;
  final double lon;

  Coord({required this.lat, required this.lon});

  factory Coord.fromJson(Map<String, dynamic> json) {
    return Coord(
      lat: (json['lat'] ?? 0).toDouble(),
      lon: (json['lon'] ?? 0).toDouble(),
    );
  }
}
