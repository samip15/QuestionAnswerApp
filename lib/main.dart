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

  int _rightAnswer = 0;

  void checkAnswer({bool userAnswer}) {
    setState(() {
      if (userAnswer == _questionBrain.answerResult) {
        _scoreKeeper.add(
          Icon(Icons.check, color: Colors.green, size: 30),
        );
        _rightAnswer++;
      } else {
        _scoreKeeper.add(
          Icon(Icons.close, color: Colors.red, size: 30),
        );
      }
      if (_questionBrain.isFinished()) {
        // game over dialog
        showDialog(
            context: context,
            barrierDismissible: false,
            builder: (dCtx) {
              return AlertDialog(
                title: Text("Game Over"),
                content: Text(
                    "You have answered all the questions : Score: $_rightAnswer / ${_questionBrain.questionLength}"),
                actions: [
                  RaisedButton(
                    onPressed: () {
                      Navigator.pop(dCtx);
                      setState(() {
                        _rightAnswer = 0;
                      });
                    },
                    child: Text("Play Again"),
                  )
                ],
              );
            });
        _questionBrain.reset();
        _scoreKeeper.clear();
      } else {
        _questionBrain.nextQuestions();
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        Padding(
          padding: EdgeInsets.only(top: 30, left: 15),
          child: Text(
            "Score:$_rightAnswer / ${_questionBrain.questionLength}",
            style: TextStyle(color: Colors.white, fontSize: 20),
          ),
        ),
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
        SingleChildScrollView(
          scrollDirection: Axis.horizontal,
          child: Row(
            children: _scoreKeeper,
          ),
        )
      ],
    );
  }
}
