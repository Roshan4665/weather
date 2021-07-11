import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:geolocator/geolocator.dart';

class TroubleShootPage extends StatefulWidget {
  const TroubleShootPage({Key? key}) : super(key: key);

  @override
  _TroubleShootPageState createState() => _TroubleShootPageState();
}

class _TroubleShootPageState extends State<TroubleShootPage> {
  @override
  Widget build(BuildContext context) {
    return Container(
      child: Scaffold(
        appBar: AppBar(
          title: Text('Location and Network Settings'),
        ),
        body: Container(
          margin: EdgeInsets.only(left: 8, right: 8),
          child: Column(
            children: [
              Text(
                'OOPS...!',
                style: GoogleFonts.aguafinaScript(
                    fontSize: 40, color: Colors.white),
              ),
              Text(
                  'Was there some error while loading? \nNo problem we are here to help.',
                  style: GoogleFonts.loveYaLikeASister(color: Colors.white)),
              Icon(
                Icons.emoji_emotions_outlined,
                color: Colors.white,
              ),
              Text('Please turn on your GPS first...',
                  style: GoogleFonts.loveYaLikeASister(color: Colors.white)),
              ElevatedButton(
                onPressed: () {
                  Geolocator.openLocationSettings();
                },
                child: Container(
                  width: double.infinity,
                  child: Text('OPEN LOCATION SETTINGS'),
                ),
              ),
              Text(
                'Clicking below will open App Settings. From there go to " Permissions -> Location " and turn it on. ',
                style: GoogleFonts.loveYaLikeASister(color: Colors.white),
              ),
              ElevatedButton(
                onPressed: () {
                  Geolocator.openAppSettings();
                },
                child: Container(
                  width: double.infinity,
                  child: Text('OPEN APP SETTINGS'),
                ),
              ),
              Text(
                'Once you are done trouble shooting, please go back and refresh the main page. You can refresh by swiping down the screen.',
                style: GoogleFonts.loveYaLikeASister(color: Colors.white),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
