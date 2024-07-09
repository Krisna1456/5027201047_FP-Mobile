import 'package:flutter/material.dart';
import 'start_screen.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'NightCity Trivia',
      theme: ThemeData(
        primaryColor: Colors.grey[900], // background abu2
        scaffoldBackgroundColor: Colors.grey[900], // scaffold abu
        textTheme: TextTheme(
          bodyText2: TextStyle(color: Colors.yellow[200]), // text kuning
        ),
        visualDensity: VisualDensity.adaptivePlatformDensity,
      ),
      home: StartScreen(), // StartScreen
    );
  }
}
