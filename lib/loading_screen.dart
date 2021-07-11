import 'dart:math';

import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:weather/detail_screen.dart';
import 'constants.dart';
import 'location_weather.dart';
import 'beautify.dart';
import 'dart:async';
import 'main_content.dart';

class LoadingScreen extends StatefulWidget {
  const LoadingScreen({Key? key}) : super(key: key);

  @override
  _LoadingScreenState createState() => _LoadingScreenState();
}

class _LoadingScreenState extends State<LoadingScreen> {
  final date = DateTime.now();
  bool isError = false;
  List<int> dateTimeData = [
    0,
    1485741600,
    1485741600,
    1485741600,
    1485741600,
    1485741600
  ];
  List<dynamic> tempData = [20, 24, 23, 34, 45, 56];
  List<dynamic> conditionData = [
    'Hot',
    'Humid',
    'Halo',
    'Hot',
    'Humid',
    'Halo'
  ];
  List<dynamic> humidityData = [20, 24, 23, 34, 45, 56];
  List<dynamic> windData = [20, 24, 23, 34, 45, 56];
  List<dynamic> iconData = ['10d', '10d', '10d', '10d', '10d', '10d'];
  double? latitude;
  double? longitude;
  String info = 'Getting Data...';
  String icon = '11n';
  String description = 'Toofani';
  var temperature = '-73';

  String city = 'Galaxy GN-z11';
  dynamic randomlyGenColor = Colors.red;
  String humidity = '0.24';
  String windSpeed = '324';
  var data;
  @override
  void initState() {
    errorChecker();
    super.initState();
  }

  Future<void> errorChecker() async {
    try {
      randomlyGenColor =
          Colors.primaries[Random().nextInt(Colors.primaries.length)];
      var someData = await determinePosition();
      latitude = someData.latitude;
      longitude = someData.longitude;
      var data = await getWeekweather(latitude, longitude);
      var temp = await getWeatherData(latitude, longitude);
      int i = 0;
      setState(() {
        for (i = 0; i < 6; i++) {
          dateTimeData[i] = data['daily'][i]['dt'];
          tempData[i] = data['daily'][i]['temp']['day'];
          humidityData[i] = data['daily'][i]['humidity'];
          windData[i] = data['daily'][i]['wind_speed'];
          conditionData[i] = data['daily'][i]['weather'][0]['main'];
          iconData[i] = data['daily'][i]['weather'][0]['icon'];
          conditionData[i][0].toUpperCase();
          tempData[i] -= 273.15;
          tempData[i] = tempData[i].toStringAsFixed(0);
        }
        description = temp['weather'][0]['description'];
        temperature = (temp['main']['temp'] - 273.15)
            .toStringAsFixed(0); //weather[0].description
        city = temp['name'] + ', ' + temp['sys']['country'];
        humidity = temp['main']['humidity'].toString();
        windSpeed = temp['wind']['speed'].toString();
        icon = temp['weather'][0]['icon'];

        isError = false;
      });
    } catch (e) {
      print(e);
      setState(() {
        info = 'Please check your internet connection...!';
        isError = true;
      });
    }
  }

/*
 return RefreshIndicator(
      child: ListView(
        children: <Widget>[
          ListTile(
            title: Center(
              child: Padding(
                padding: const EdgeInsets.all(80.0),
                child: Text(
                  _message,
                  style: TextStyle(
                    fontSize: 30.0,
                  ),
                ),
 */
  @override
  Widget build(BuildContext context) {
    return RefreshIndicator(
      onRefresh: errorChecker,
      child: SingleChildScrollView(
        child: Container(
          height: MediaQuery.of(context).size.height,
          width: MediaQuery.of(context).size.width,
          decoration: BoxDecoration(
              gradient: LinearGradient(
                  begin: Alignment.topCenter,
                  end: Alignment.bottomCenter,
                  colors: [randomlyGenColor, kCloudyColor2, kCloudyColor1])),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              ErrorDetectionWidget(isError: isError),
              Container(
                margin: EdgeInsets.only(top: 12),
                child: Row(
                  children: [
                    Expanded(
                        flex: 1,
                        child: Icon(
                          Icons.location_on,
                          size: 24,
                        )),
                    Expanded(
                        flex: 4,
                        child: Beautify(
                          data: city,
                        )),
                    Expanded(
                        //flex: 1,
                        child: GestureDetector(
                      onTap: () {
                        if (isError == false)
                          Navigator.pushNamed(context, './tsp');
                      },
                      child: Icon(Icons.settings),
                    ))
                  ],
                ),
              ),
              Spacer(),
              Container(
                margin: EdgeInsets.only(top: 12),
                child: Image.asset(
                  'assets/cloudy.png',
                  fit: BoxFit.scaleDown,
                ),
              ),
              Spacer(),
              GestureDetector(
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => Biggest(
                            date: date,
                            dateTimeData: dateTimeData,
                            windData: windData,
                            humidityData: humidityData,
                            conditionData: conditionData,
                            tempData: tempData,
                            iconData: iconData,
                            isError: isError),
                      ),
                    );
                  },
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
                    margin:
                        EdgeInsets.only(top: 12, bottom: 8, left: 8, right: 8),
                    padding: EdgeInsets.all(14),
                    child: MainContent(
                      description: description,
                      temperature: temperature,
                      windSpeed: windSpeed,
                      humidity: humidity,
                      icon: icon,
                      date: dateTimeData[0].toString(),
                    ),
                  )),
              Spacer(),
            ],
          ),
        ),
      ),
    );
  }
}

class ErrorDetectionWidget extends StatefulWidget {
  ErrorDetectionWidget({@required this.isError});
  final bool? isError;

  @override
  _ErrorDetectionWidgetState createState() => _ErrorDetectionWidgetState();
}

class _ErrorDetectionWidgetState extends State<ErrorDetectionWidget> {
  Timer? _timer;
  int _start = 10;
  int timeleft = 5;
  void startTimer() {
    const oneSec = const Duration(seconds: 1);
    _timer = new Timer.periodic(
      oneSec,
      (Timer timer) {
        if (_start == 0) {
          setState(() {
            timeleft = -1;
            timer.cancel();
          });
        } else {
          _start--;
        }
      },
    );
  }

  @override
  void initState() {
    startTimer();

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return widget.isError == true
        ? GestureDetector(
            onTap: () {
              Navigator.pushNamed((context), './tsp');
            },
            child: Container(
              color: Colors.tealAccent,
              child: Text(
                ". An error occurred. If refresh doesn't work then go to Trouble-Shooter by clicking here.",
                style: GoogleFonts.loveYaLikeASister(),
              ),
            ),
          )
        : timeleft >= 0
            ? Container(
                width: double.infinity,
                child: Image.asset('assets/loading_icon.gif'),
              )
            : Container(
                height: 0,
                width: 0,
              );
  }
}
