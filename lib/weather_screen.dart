import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:weather_app/additional_information.dart';
import 'package:weather_app/hourly_forecast_iteam.dart';

class WeatherScreen extends StatelessWidget {
  const WeatherScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return  Scaffold(
      appBar: AppBar(
        title:const Text("Weather app",style: TextStyle(
          fontWeight: FontWeight.bold,
        ),
        ),
        centerTitle: true,
        actions:  [
          IconButton(onPressed: (){

          }, icon: 
          const Icon(Icons.refresh),
          ),
        ],
      ),
      body: Padding(
        padding: const  EdgeInsets.all(16),
        child:  Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
                 SizedBox(
                  width: double.infinity,
                   child: Card(
                    color: const Color.fromARGB(255, 72, 80, 84),
                    elevation: 10,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(16),
                    ),
                    child: ClipRRect(
                      borderRadius: BorderRadius.circular(16),

                      child: BackdropFilter(
                        filter: ImageFilter.blur(sigmaX: 10 , sigmaY: 10),
                        child: const Padding(
                          padding: EdgeInsets.all(16),
                          child: Column(
                            
                            children: [
                              Text('300° K',style: TextStyle(
                                fontSize:32 ,
                                fontWeight: FontWeight.bold,
                              ),
                              ),
                              SizedBox(height: 16,
                              ),
                            Icon(Icons.cloud,size: 64,
                            ),
                           SizedBox(height: 16,
                           ),
                           Text("Rain",
                           style: TextStyle(
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
          const SizedBox(height: 20,
          ),

        const Text("Weather Forecast",
        style: TextStyle(
          fontSize: 24,
          fontWeight: FontWeight.bold,
        ),
        ),
        const SizedBox(height: 8,
        ),
        
          const SingleChildScrollView(
            scrollDirection: Axis.horizontal,
            child: Row(
            children: [
            HourlyForecastItem(
              time:'09:00',
              icons1: Icons.cloud,
              temp: "300.01" ,
            ),

            HourlyForecastItem(
              time:'12:00' ,
              icons1:Icons.sunny ,
              temp: "271.23",
            ),

            HourlyForecastItem(
              time: '15:00',
              icons1:Icons.cloud,
              temp: '299.04',
            ),

            HourlyForecastItem(
              time: '18:00',
              icons1:Icons.sunny ,
              temp: "300.45",
            ),

            HourlyForecastItem(
              time:'21:00' ,
              icons1:Icons.cloud ,
              temp: "295.60",
            ),  
            ],

            ),
          ),
        
          const SizedBox(height: 20,),
          
          const Text("Additional Information",
        style: TextStyle(
          fontSize: 24,
          fontWeight: FontWeight.bold,
        ),
        ),
        
        const SizedBox(height: 8,),

         const Row(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: [
           AdditionalInformatiion(
            icons: Icons.water_drop,
            label: "Humidity",
            value: '90',
           ),

           AdditionalInformatiion(
             icons: Icons.air,
            label: "Wind Speed",
            value: '7.5',
           ),

           AdditionalInformatiion(
             icons: Icons.beach_access,
            label: "Pressure",
            value: '1000',
           ),

            
          ],

        ),

          ],
        ),
      ),
    );
  }
}



