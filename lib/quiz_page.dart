import 'package:flutter/material.dart';
import 'quiz_model.dart'; // Import the Quiz model
import 'quiz_service.dart';
import 'quiz_pag3.dart'; // Import the QuizPag3 page

class QuizPage extends StatefulWidget {
  @override
  _QuizPageState createState() => _QuizPageState();
}

class _QuizPageState extends State<QuizPage> {
  final QuizService _quizService = QuizService();
  late Future<List<Quiz>> _quizzesFuture;
  List<Quiz>? _quizzes; // List quiz diambil dari ID
  Map<String, int?> _selectedOptions = {};
  int _currentQuestionIndex = 0;
  int _correctAnswersCount = 0;

  @override
  void initState() {
    super.initState();
    _quizzesFuture = _quizService.loadQuizzes();
  }

  void _submitAnswer(BuildContext context, Quiz quiz) {
    int? selectedOptionIndex = _selectedOptions[quiz.id];
    bool isCorrect = selectedOptionIndex == quiz.correctOptionIndex;

    // layar jawaban betul/tidak
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          backgroundColor: Theme.of(context).primaryColor,
          title: Text(
            isCorrect ? 'Correct' : 'Incorrect',
            style:
                TextStyle(color: Theme.of(context).textTheme.bodyText2!.color),
          ),
          content: Text(
            isCorrect
                ? 'You chose the correct answer!'
                : 'The correct answer is: ${quiz.options[quiz.correctOptionIndex]}',
            style:
                TextStyle(color: Theme.of(context).textTheme.bodyText2!.color),
          ),
          actions: <Widget>[
            TextButton(
              child: Text(
                'Next Question',
                style: TextStyle(
                    color: Theme.of(context).textTheme.bodyText2!.color),
              ),
              onPressed: () {
                Navigator.pop(context);
                setState(() {
                  _currentQuestionIndex++;
                  if (isCorrect) {
                    _correctAnswersCount++;
                  }
                });
                if (_currentQuestionIndex < _quizzes!.length) {
                  _selectedOptions[_quizzes![_currentQuestionIndex].id] = null;
                } else {
                  // Navigate to hacked page after completing all questions
                  Navigator.pushReplacement(
                    context,
                    MaterialPageRoute(
                      builder: (context) =>
                          QuizPag3(correctAnswersCount: _correctAnswersCount),
                    ),
                  );
                }
              },
            ),
          ],
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('NightCity Trivia'),
      ),
      body: FutureBuilder<List<Quiz>>(
        future: _quizzesFuture,
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return Center(child: CircularProgressIndicator());
          } else if (snapshot.hasError) {
            return Center(child: Text('Error: ${snapshot.error}'));
          } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
            return Center(child: Text('No quizzes available'));
          }

          _quizzes = snapshot.data!; // Assign data to quizzes list

          Quiz currentQuiz = _quizzes![_currentQuestionIndex];

          return Padding(
            padding: EdgeInsets.all(16.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: <Widget>[
                Text(
                  currentQuiz.question,
                  style: TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                    color: Theme.of(context).textTheme.bodyText2!.color,
                  ),
                ),
                SizedBox(height: 20),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: currentQuiz.options.map((option) {
                    int optionIndex = currentQuiz.options.indexOf(option);
                    return RadioListTile(
                      title: Text(
                        option,
                        style: TextStyle(
                          color: Theme.of(context).textTheme.bodyText2!.color,
                        ),
                      ),
                      value: optionIndex,
                      groupValue: _selectedOptions[currentQuiz.id],
                      onChanged: (value) {
                        setState(() {
                          _selectedOptions[currentQuiz.id] = value;
                        });
                      },
                    );
                  }).toList(),
                ),
                SizedBox(height: 20),
                ElevatedButton(
                  onPressed: () {
                    _submitAnswer(context, currentQuiz);
                  },
                  child: Text('Submit'),
                ),
              ],
            ),
          );
        },
      ),
    );
  }
}
