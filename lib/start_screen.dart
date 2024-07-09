import 'package:flutter/material.dart';
import 'quiz_page.dart';

class StartScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('NightCity Trivia'),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Text(
              'Welcome to the NightCity Trivia',
              style: TextStyle(fontSize: 32, fontWeight: FontWeight.bold),
              textAlign: TextAlign.center,
            ),
            SizedBox(height: 20),
            Image.asset('assets/nightcity_logo.png'),
            SizedBox(height: 40),
            ElevatedButton(
              onPressed: () {
                // Quiz screen
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => QuizPage()),
                );
              },
              child: Text('Start'),
            ),
          ],
        ),
      ),
    );
  }
}
