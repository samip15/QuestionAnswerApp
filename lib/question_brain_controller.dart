import 'package:question_answer_app/question_model.dart';

class QuestionBrain {
  int _questionNumber = 0;
  List<Question> _questions = [
    Question("Flutter Is Made By Google.", true),
    Question("Mt .Everest is in nepal", true),
    Question("Iphone is not made by Apple.", false)
  ];

  String get questionText {
    return _questions[_questionNumber].questionText;
  }

  bool get answerResult {
    return _questions[_questionNumber].answerResult;
  }

  void nextQuestions() {
    if (_questionNumber < _questions.length - 1) {
      _questionNumber++;
    }
  }
}
