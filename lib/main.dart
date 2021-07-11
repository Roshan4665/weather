import 'package:flutter/material.dart';
import 'package:weather/homeScreen.dart';
import 'package:weather/trouble_shoot.dart';
import 'homeScreen.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatefulWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData.dark().copyWith(
          textTheme: ThemeData.light().textTheme,
          iconTheme: ThemeData.light().iconTheme),
      initialRoute: './',
      routes: {
        './': (context) => HomeScreen(),
        './tsp': (context) => TroubleShootPage(),
      },
    );
  }
}
