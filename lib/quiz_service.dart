import 'dart:convert';
import 'package:flutter/services.dart';
import 'quiz_model.dart';

class QuizService {
  Future<List<Quiz>> loadQuizzes() async {
    final String response = await rootBundle.loadString('assets/quizzes.json');
    final List<dynamic> data = json.decode(response);
    return data.map((quiz) => Quiz.fromJson(quiz)).toList();
  }
}
