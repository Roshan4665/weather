import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:intl/intl.dart';
import 'package:weather/constants.dart';

class Biggest extends StatelessWidget {
  const Biggest({
    Key? key,
    required this.date,
    required this.dateTimeData,
    required this.windData,
    required this.humidityData,
    required this.conditionData,
    required this.tempData,
    required this.iconData,
    required this.isError,
  }) : super(key: key);

  final DateTime date;
  final List<int> dateTimeData;
  final List windData;
  final List humidityData;
  final List conditionData;
  final List tempData;
  final List iconData;
  final bool isError;

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.teal,
          title: Text('Weather'),
        ),
        backgroundColor: Colors.tealAccent,
        body: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Container(
              decoration: BoxDecoration(
                  boxShadow: [
                    BoxShadow(
                      color: Colors.grey,
                      offset: Offset(0.0, 10.0), //(x,y)
                      blurRadius: 6.0,
                    ),
                  ],
                  color: kBoxColor,
                  borderRadius: BorderRadius.all(Radius.circular(12))),
              margin: EdgeInsets.only(top: 12, bottom: 8, left: 8, right: 8),
              padding: EdgeInsets.all(14),
              //height: (MediaQuery.of(context).size.height) / 8.5,
              child: Column(
                children: [
                  Row(
                    children: [
                      //Image.network("https://http://openweathermap.org/img/w/$.png"),
                      Text(
                        DateFormat('EEEE').format(date) +
                            ', ' +
                            DateFormat('d MMM, yyyy').format(date),
                        style: GoogleFonts.loveYaLikeASister(fontSize: 24),
                      ),
                    ],
                  ),
                ],
              ),
            ),
            Row(
              children: [
                RRBox(
                    date: dateTimeData[0],
                    windSpeed: windData[0],
                    humidity: humidityData[0],
                    description: conditionData[0],
                    temperature: tempData[0],
                    icon: iconData[0]),
                RRBox(
                    date: dateTimeData[1],
                    windSpeed: windData[1],
                    humidity: humidityData[1],
                    description: conditionData[1],
                    temperature: tempData[1],
                    icon: iconData[1]),
              ],
            ),
            Row(
              children: [
                RRBox(
                    date: dateTimeData[2],
                    windSpeed: windData[2],
                    humidity: humidityData[2],
                    description: conditionData[2],
                    temperature: tempData[2],
                    icon: iconData[2]),
                RRBox(
                    date: dateTimeData[3],
                    windSpeed: windData[3],
                    humidity: humidityData[3],
                    description: conditionData[3],
                    temperature: tempData[3],
                    icon: iconData[3]),
              ],
            ),
            Row(
              children: [
                RRBox(
                    date: dateTimeData[4],
                    windSpeed: windData[4],
                    humidity: humidityData[4],
                    description: conditionData[4],
                    temperature: tempData[4],
                    icon: iconData[4]),
                RRBox(
                    date: dateTimeData[5],
                    windSpeed: windData[5],
                    humidity: humidityData[5],
                    description: conditionData[5],
                    temperature: tempData[5],
                    icon: iconData[5]),
              ],
            ),
            isError == true
                ? Container(
                    child: Text(
                      'There was a network connection error, please check your network connection and refresh',
                      style: GoogleFonts.loveYaLikeASister(),
                    ),
                  )
                : SizedBox(
                    height: 0,
                    width: 0,
                  )
          ],
        ),
      ),
    );
  }
}

//°C//(data['main']['temp'] - 273.15).toStringAsFixed(2)
class RRBox extends StatelessWidget {
  RRBox(
      {@required this.date,
      @required this.windSpeed,
      @required this.humidity,
      @required this.description,
      @required this.temperature,
      @required this.icon});
  final date, icon, humidity, windSpeed, temperature, description;
  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: (MediaQuery.of(context).size.width) / 2,
      height: (MediaQuery.of(context).size.height) / 4.1,
      child: Container(
          decoration: BoxDecoration(
              boxShadow: [
                BoxShadow(
                  color: Colors.grey,
                  offset: Offset(0.0, 10.0), //(x,y)
                  blurRadius: 6.0,
                ),
              ],
              color: kBoxColor,
              borderRadius: BorderRadius.all(Radius.circular(12))),
          margin: EdgeInsets.only(top: 8, bottom: 8, left: 6, right: 6),
          padding: EdgeInsets.all(4),
          child: Column(
            children: [
              Image.asset(
                'assets/$icon.png',
              ),
              Text(
                convertDate(date),
                style: GoogleFonts.loveYaLikeASister(fontSize: 18),
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Spacer(),
                  Text(
                    description,
                    style: GoogleFonts.loveYaLikeASister(fontSize: 18),
                  ),
                  Spacer(),
                  Text(
                    temperature.toString() + '°C',
                    style: GoogleFonts.loveYaLikeASister(fontSize: 18),
                  ),
                  Spacer(),
                ],
              ),
              Row(
                children: [
                  Spacer(),
                  Icon(Icons.water),
                  Text(humidity.toString() + '%'),
                  Spacer(),
                  Icon(Icons.air),
                  Text(windSpeed.toString() + 'm/s'),
                  Spacer(),
                ],
              )
            ],
          )),
    );
  }
}

String convertDate(date) {
  var cd = DateTime.fromMillisecondsSinceEpoch(date * 1000);
  String formattedDate = (DateFormat('EEEE').format(cd)).substring(0, 3) +
      ', ' +
      DateFormat('d MMM').format(cd);

  return formattedDate;
}
