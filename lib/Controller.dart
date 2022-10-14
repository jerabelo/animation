import 'dart:ffi';
import 'package:http/http.dart' as http;
import 'dart:math';
import 'dart:convert';
import 'dart:async';
import 'dart:io';
import 'dart:collection';
import 'Model.dart';

// Method that generates random number that will be used to get a questions from
List<dynamic> generateRandomQuiz(List<dynamic> questions, int totalQuestions) {
  List<dynamic> quiz = [];
  var range = Random();
  for (var i = 0; i < totalQuestions; i++) {
    quiz.add(questions.elementAt(range.nextInt(questions.length)));
  }
  return quiz;
}

// Method for checking if user is authorized to use the app
dynamic authenticateUser(String user, String pin) async {
  var url = Uri.parse(
      'https://www.cs.utep.edu/cheon/cs4381/homework/quiz/login.php?user=${user.toString()}&pin=${pin.toString()}');
  var response = await http.get(url);
  final decodedResponse = json.decode(response.body);
  String isValid = '${decodedResponse['response']}';
  return isValid;
}

//method gets questions from server
Future<List> getQuestions() async {
  List<dynamic> questions = [];
  String quizResponse = '';
  stdout.write('[Gathering questions from url links . . .]\n');
  do {
    var quiz = await getQuiz(changeQuiz());
    quizResponse = ('${quiz['response']}');
    questions = populateList(questions, quiz);
  } while (doesQuizExist(quizResponse));
  return (questions);
}

//Method checks if the quiz is finished
bool isQuizFinished(List<dynamic> questions) {
  for (int i = 0; i < questions.length; i++) {
    if (questions[i].hasResponse() == false) {
      return false;
    }
  }
  return true;
}

int quizCounter = 0;
// Method that changes quiz url
dynamic changeQuiz() {
  var url = Uri.parse(
      "https://www.cs.utep.edu/cheon/cs4381/homework/quiz?quiz=quiz${(quizCounter + 1).toString().padLeft(2, '0')}");
  quizCounter++;
  return url;
}

// Method that gets decoded quiz
Future<dynamic> getQuiz(var url) async {
  var response = await http.get(url);
  final decodedResponse = json.decode(response.body);
  return decodedResponse;
}

// Method that checks what if a quiz exists based on url
bool doesQuizExist(String isQuizFound) {
  if (isQuizFound != 'true') {
    return false;
  }
  return true;
}

// Method that generates pool of questions from a valid quiz
List<dynamic> populateList(List<dynamic> questions, var decodedResponse) {
  int counter = 0;
  String isFinished = '';
  do {
    try {
      int questionType =
          int.parse('${decodedResponse['quiz']['question'][counter]['type']}');
      String stem = '${decodedResponse['quiz']['question'][counter]['stem']}';
      String choices =
          '${decodedResponse['quiz']['question'][counter]['option']}';
      String answer =
          '${decodedResponse['quiz']['question'][counter]['answer']}';
      switch (questionType) {
        case 1:
          List<String> strarr = choices.split(",");
          questions.add(MultipleChoiceQuestion(stem, strarr, answer));
          break;
        case 2:
          questions.add(FillInBlankQuestion(stem, answer));
          break;
      }
    } catch (e) {
      isFinished = 'true';
      break;
    }
    counter++;
  } while (counter < 10);
  return questions;
}
