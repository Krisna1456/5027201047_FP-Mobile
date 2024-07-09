import 'package:flutter/material.dart';

class FinalScreen extends StatelessWidget {
  final int correctAnswersCount;

  FinalScreen({required this.correctAnswersCount});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Congratulations!'),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Text(
              'Congratulations!',
              style: TextStyle(fontSize: 32, fontWeight: FontWeight.bold),
            ),
            SizedBox(height: 20),
            Text(
              'You have completed the NightCity Trivia.',
              style: TextStyle(fontSize: 20),
            ),
            SizedBox(height: 20),
            Text(
              'Correct Answers: $correctAnswersCount / 8',
              style: TextStyle(fontSize: 24),
            ),
            SizedBox(height: 40),
            ElevatedButton(
              onPressed: () {
                Navigator.popUntil(context, ModalRoute.withName('/'));
              },
              child: Text('Try Again'),
            ),
          ],
        ),
      ),
    );
  }
}
