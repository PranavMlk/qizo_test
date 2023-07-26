import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import '../data/quiz_data.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  int _currentQuestionIndex = 0;
  List<Map<String, dynamic>> _questions = QuizData.quizQuestions;
  int _score = 0;

  void _checkAnswer(String selectedAnswer) {
    String correctAnswer = _questions[_currentQuestionIndex]['correctAnswer'];

    setState(() {
      if (selectedAnswer == correctAnswer) {
        _score++;
      }

      if (_currentQuestionIndex < _questions.length - 1) {
        _currentQuestionIndex++;
      } else {
        // Show a dialog with the final score when all questions are answered.
        showDialog(
          context: context,
          builder: (context) => AlertDialog(
            title: Text('Quiz Complete'),
            content: Text('Your score: $_score'),
            actions: [
              TextButton(
                onPressed: () {
                  Navigator.pop(context);
                  setState(() {
                    _currentQuestionIndex = 0;
                    _score = 0;
                  });
                },
                child: Text('Restart'),
              ),
            ],
          ),
        );
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: ()async {
        SystemNavigator.pop();
        return false;
      },
      child: Scaffold(
        appBar: AppBar(title: Text('Quiz App'),
          backgroundColor: Colors.lightBlueAccent,
        ),
        backgroundColor: Colors.grey.shade300,
        body: Center(
          child: _currentQuestionIndex < _questions.length
              ? Column(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              Padding(
                padding: const EdgeInsets.only(left: 250,top: 50,bottom: 50),
                child: Text('Your score: $_score',
                  style: TextStyle(fontSize: 20),
                ),
              ),
              Text(
                _questions[_currentQuestionIndex]['question'],
                style: TextStyle(fontSize: 25,
                  fontWeight: FontWeight.w500
                ),
              ),
              SizedBox(height: 20),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children:(_questions[_currentQuestionIndex]['options']
                as List<String>)
                    .map(
                      (option) => Container(
                        margin: EdgeInsets.symmetric(vertical: 10),
                        width: double.infinity,
                        decoration: BoxDecoration(
                          border: Border.all(color: Colors.grey)
                        ),
                        child: TextButton(
                    onPressed: () => _checkAnswer(option),
                    child: Text(option,
                    ),
                  ),
                      ),
                )
                    .toList(),
              ),
            ],
          )
              : Text('Quiz Completed!'),
        ),
      ),
    );
  }
}
