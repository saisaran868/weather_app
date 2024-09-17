import 'dart:convert';
import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:http/http.dart' as http;
import 'package:weather_app/additional_information.dart';
import 'package:weather_app/hourly_forecast_iteam.dart'; // Ensure correct import
import 'package:weather_app/secret.dart';

class WeatherScreen extends StatefulWidget {
  const WeatherScreen({super.key});

  @override
  State<WeatherScreen> createState() => _WeatherScreenState();
}

class _WeatherScreenState extends State<WeatherScreen> {
  final border = const OutlineInputBorder(
    borderSide: BorderSide(
      color: Colors.green,
      width: 3,
      style: BorderStyle.solid,
    ),
  );
  TextEditingController cityController = TextEditingController();
  String cityName = "chennai";

  Future<Map<String, dynamic>> getCurrentWeather() async {
    try {

      final response = await http.get(
        Uri.parse(
            'https://weather.visualcrossing.com/VisualCrossingWebServices/rest/services/timeline/$cityName?unitGroup=metric&key=$openWeatherApiKey&contentType=json'),
      );
      final data = jsonDecode(response.body);
      return data;
    } catch (e) {
      throw e.toString();
    }
  }

  String formatTime(String timeString) {
    final DateFormat inputFormat = DateFormat('HH:mm:ss');
    final DateFormat outputFormat = DateFormat('h:mm a');
    final DateTime dateTime = inputFormat.parse(timeString);
    return outputFormat.format(dateTime);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          "Weather app",
          style: TextStyle(
            fontWeight: FontWeight.bold,
          ),
        ),
        centerTitle: true,
        actions: [
          IconButton(
            onPressed: () {
              setState(() {});
            },
            icon: const Icon(Icons.refresh),
          ),
        ],
      ),
      body: SingleChildScrollView(
        child: FutureBuilder(
          future: getCurrentWeather(),
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting) {
              return const Center(
                child: CircularProgressIndicator.adaptive(),
              );
            }
            if (snapshot.hasError) {
              return Center(
                child: Text(snapshot.error.toString()),
              );
            }
        
            final data = snapshot.data!;
            final currentTemp = data["days"][0]["temp"];
            final currentCloud = data["days"][0]["icon"];
            final currentHumidity = data["days"][0]["humidity"];
            final currentWindSpeed = data["days"][0]["windspeed"];
            final currentPressure = data["days"][0]["pressure"];
        
            return Padding(
              padding: const EdgeInsets.all(16),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  TextField(
                    decoration: InputDecoration(
                      hintText: "Enter city name",
                      enabledBorder: border,
                      focusedBorder: border,
                      suffixIcon: IconButton(onPressed:_searchWeather,
                          icon: const Icon(
                              Icons.search),
                      ),
                    ),
                    textInputAction: TextInputAction.done,
                    controller: cityController,
        
                  ),
                  const SizedBox(height: 30,),
                  SizedBox(
                    width: double.infinity,
                    child: Card(
                      elevation: 10,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(16),
                      ),
                      child: ClipRRect(
                        borderRadius: BorderRadius.circular(16),
                        child: BackdropFilter(
                          filter: ImageFilter.blur(sigmaX: 10, sigmaY: 10),
                          child: Padding(
                            padding: const EdgeInsets.all(16),
                            child: Column(
                              children: [
                                Text(
                                  '$currentTemp° C',
                                  style: const TextStyle(
                                    fontSize: 32,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                                const SizedBox(height: 16),
                                Icon(
                                  currentCloud == "cloudy" ||
                                          currentCloud == "rain"
                                      ? Icons.cloud
                                      : Icons.sunny,
                                  size: 64,
                                ),
                                const SizedBox(height: 16),
                                Text(
                                  "$currentCloud",
                                  style: const TextStyle(
                                    fontSize: 20,
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                      ),
                    ),
                  ),
                  const SizedBox(height: 20),
                  const Text(
                    "Hourly Forecast",
                    style: TextStyle(
                      fontSize: 24,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const SizedBox(height: 8),
                  SizedBox(
                    height: 120,
                    child: ListView.builder(
                      scrollDirection: Axis.horizontal,
                      itemCount: 23,
                      itemBuilder: (context, index) {
                        final timeString = data["days"][0]['hours'][index + 1]
                            ["datetime"];
                        final formattedTime = formatTime(timeString);
        
                        return HourlyForecastItem(
                          time: formattedTime,
                          icons1: data["days"][0]['hours'][index + 1]["icon"] ==
                                  "cloudy" ||
                              data["days"][0]['hours'][index + 1]["icon"] ==
                                  "rain" ||
                              data["days"][0]['hours'][index + 1]["icon"] ==
                                  'partly-cloudy-night' ||
                              data["days"][0]['hours'][index + 1]["icon"] ==
                                  'partly-cloudy-day'
                              ? Icons.cloud
                              : Icons.sunny,
                          temp:
                              "${data["days"][0]['hours'][index + 1]["temp"]}° C",
                        );
                      },
                    ),
                  ),
                  const SizedBox(height: 20),
                  const Text(
                    "Additional Information",
                    style: TextStyle(
                      fontSize: 24,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const SizedBox(height: 8),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: [
                      AdditionalInformatiion(
                        icons: Icons.water_drop,
                        label: "Humidity",
                        value: '$currentHumidity',
                      ),
                      AdditionalInformatiion(
                        icons: Icons.air,
                        label: "Wind Speed",
                        value: '$currentWindSpeed',
                      ),
                      AdditionalInformatiion(
                        icons: Icons.beach_access,
                        label: "Pressure",
                        value: '$currentPressure',
                      ),
                    ],
                  ),
        
                ],
              ),
            );
          },
        ),
      ),
    );
  }
  void _searchWeather() {
    setState(() {
      cityName = cityController.text.isNotEmpty ? cityController.text : "chennai";
    });
  }

}
