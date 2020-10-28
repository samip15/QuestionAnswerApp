import 'package:flutter/material.dart';
import 'package:question_answer_app/question_brain_controller.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Scaffold(
        backgroundColor: Colors.grey.shade900,
        body: SafeArea(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 10),
            child: QuizPage(),
          ),
        ),
      ),
    );
  }
}

class QuizPage extends StatefulWidget {
  @override
  _QuizPageState createState() => _QuizPageState();
}

class _QuizPageState extends State<QuizPage> {
  List<Icon> _scoreKeeper = [];

  QuestionBrain _questionBrain = QuestionBrain();

  void checkAnswer({bool userAnswer}) {
    setState(() {
      if (userAnswer == _questionBrain.answerResult) {
        _scoreKeeper.add(
          Icon(Icons.check, color: Colors.green, size: 30),
        );
      } else {
        _scoreKeeper.add(
          Icon(Icons.close, color: Colors.red, size: 30),
        );
      }
      _questionBrain.nextQuestions();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        Expanded(
          flex: 5,
          child: Center(
            child: Text(
              _questionBrain.questionText,
              textAlign: TextAlign.center,
              style: TextStyle(color: Colors.white, fontSize: 25),
            ),
          ),
        ),
        Expanded(
          child: Padding(
            padding: const EdgeInsets.symmetric(vertical: 10),
            child: FlatButton(
              onPressed: () {
                checkAnswer(userAnswer: true);
              },
              color: Colors.green,
              child: Text(
                "True",
                style: TextStyle(color: Colors.white, fontSize: 20),
              ),
            ),
          ),
        ),
        Expanded(
          child: Padding(
            padding: const EdgeInsets.symmetric(vertical: 10),
            child: FlatButton(
              onPressed: () {
                checkAnswer(userAnswer: false);
              },
              color: Colors.red,
              child: Text(
                "False",
                style: TextStyle(color: Colors.white, fontSize: 20),
              ),
            ),
          ),
        ),
        Row(
          children: _scoreKeeper,
        )
      ],
    );
  }
}
