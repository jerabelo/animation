import 'dart:io';
import 'package:http/http.dart';

abstract class Questions {
  var stem;
  var choices;
  dynamic answer;

  // Default Construct
  Questions(this.stem, this.choices, this.answer);

  // Named Construct
  Questions.withoutChoices(this.stem, this.answer);

  // DisplayQuestions method
  void displayQuestion();

  // DisplayQuestions method
  bool checkAnswer();
}

class MultipleChoiceQuestion extends Questions {
  var stem;
  var choices;
  var answer;
  var response;
  MultipleChoiceQuestion(this.stem, this.choices, this.answer)
      : super(stem, choices, answer);

  String getStem() {
    return stem;
  }

  // Method for displaying questions using Super method
  void displayQuestion() {
    stdout.write('${stem}\n');
    for (int i = 0; i < choices.length; i++) {
      stdout.write(
          '[${i + 1}]. ${choices[i].toString().replaceAll('[', '').replaceAll(']', '')}\n');
    }
    if (response != null) {
      stdout.write('Response: $response\n');
    }
  }

  // Method for checking answer using super method
  bool checkAnswer() {
    if (response == answer) {
      return true;
    }
    return false;
  }

  //get number of choices
  int getNumChoices() {
    return choices.length;
  }

  //set question response
  void setResponse(int selection) {
    response = choices[selection - 1];
  }

  //method for checking if question has response
  bool hasResponse() {
    if (response != null) {
      return true;
    }
    return false;
  }
}

// Class for open ended questions
class FillInBlankQuestion extends Questions {
  var stem;
  var answer;
  var response;
  FillInBlankQuestion(this.stem, this.answer)
      : super.withoutChoices(stem, answer);

  String getStem() {
    return stem;
  }

  // Method for displaying questions using Super method
  void displayQuestion() {
    stdout.write('${stem}\n');

    if (response != null) {
      stdout.write('Response: $response\n');
    }
  }

  void setResponse(var response) {
    this.response = response;
  }

  // Method for checking answer using super method
  bool checkAnswer() {
    for (var i = 0; i < answer.length; i++) {
      if (response == answer[i]) {
        return true;
      }
    }
    return false;
  }

  //returns if question has a response
  bool hasResponse() {
    if (response != null) {
      return true;
    }
    return false;
  }
}
