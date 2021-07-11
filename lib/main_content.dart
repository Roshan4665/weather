import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'beautify.dart';

class MainContent extends StatelessWidget {
  const MainContent({
    Key? key,
    required this.description,
    required this.temperature,
    required this.windSpeed,
    required this.humidity,
    required this.icon,
    required this.date,
  }) : super(key: key);

  final String description;
  final String temperature;
  final String windSpeed;
  final String humidity;
  final String icon;
  final String date;
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Image.asset('assets/$icon.png'),
            Beautify(
                data:
                    (description[0].toUpperCase() + description.substring(1))),
          ],
        ),
        Beautify(data: convertDate(date)),
        Beautify(
          data: '$temperature °C',
          scale: 3.0,
        ),
        Row(
          //mainAxisAlignment: ,
          children: [
            Spacer(),
            Row(
              children: [
                Icon(Icons.air),
                Beautify(data: '$windSpeed m/s'),
              ],
            ),
            Spacer(),
            Row(
              children: [
                Icon(Icons.water),
                Beautify(data: '$humidity %'),
              ],
            ),
            Spacer(),
          ],
        ),
      ],
    );
  }
}

String convertDate(date) {
  int dt = int.parse(date);
  var cd = DateTime.fromMillisecondsSinceEpoch(dt * 1000);
  String formattedDate = (DateFormat('EEEE').format(cd)).substring(0, 3) +
      ', ' +
      DateFormat('d MMM').format(cd);

  return formattedDate;
}
