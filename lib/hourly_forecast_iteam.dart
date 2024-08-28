import 'package:flutter/material.dart';

class HourlyForecastItem extends StatelessWidget {
  final String time;
  final IconData icons1;
  final String temp;
  const HourlyForecastItem({super.key,
  required this.time,
  required this.icons1,
  required this.temp,
  });

  @override
  Widget build(BuildContext context) {
    return Card(
                elevation: 6,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(15),
                ),
                color: const Color.fromARGB(255, 72, 80, 84),
                child: Container( 
                  width: 100,
                  padding: const EdgeInsets.all(8.0),
                  child:  Column(
                    children: [
                      Text(time ,style:const  TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                      ),
                      ),
                     const  SizedBox(height: 8,
                      ),
                      Icon(icons1 ,size: 32,
                      ),
                  
                     const SizedBox(height: 8,
                      ),
                  
                      Text(temp,
                      ),
                  
                    ],
                  ),
                ),
              );
            
  }
}