import 'dart:io';
import 'Model.dart';
import 'Controller.dart';
import 'dart:convert';

// Main method
void main() async {
  int numQuestions;
  var questions = await getQuestions();
  bool loop = true;
  while (loop) {
    numQuestions = getNumQuestions();
    var quiz = generateRandomQuiz(questions, numQuestions);
    menu(quiz);
    stdout.write('One more test (y/n) [default: n]?');
    var response = stdin.readLineSync();
    if (response == 'y') {
      loop = true;
    }
    loop = false;
  }
}

// Method that displays interactive menu to user
void menu(List<dynamic> questions) {
  bool inProgress = true;
  int nav = 0;
  stdout.write('\n');
  stdout.write('[Welcome to the interactive practice exam tool]!\n');
  stdout.write('------------------------------------------------\n');
  while (inProgress) {
    if (nav < 0) {
      nav = 0;
    }
    if (nav > questions.length - 1) {
      if (isQuizFinished(questions)) {
        stdout.write('All questions answered.');
        stdout.write('Submit (y/n) [default: n]?');
        var submit = stdin.readLineSync();
        if (submit == 'y') {
          submitQuiz(questions);
          reviewAnswers(questions);
          break;
        }
      }
      nav--;
    }
    stdout.write('\n[Question ${nav + 1}]: ');
    questions[nav].displayQuestion();
    while (true) {
      stdout.write('Enter your answer, p[revious] or n[ext]:');
      var answer = stdin.readLineSync();
      if (answer == 'p') {
        nav--;
        break;
      }
      if (answer == 'n') {
        nav++;
        break;
      }

      if (questions[nav] is MultipleChoiceQuestion) {
        var selection = int.tryParse(answer ?? '');
        if (selection != null) {
          if (selection < questions[nav].getNumChoices()) {
            questions[nav].setResponse(selection);
            nav++;
            break;
          }
        }
      } else {
        questions[nav].setResponse(answer);
        nav++;
        break;
      }
    }
  }
}

//method gets number of questions from the user
int getNumQuestions() {
  while (true) {
    stdout.write('Number of questions (1-10) [default: 5]');
    var input = stdin.readLineSync();
    if (input == "") {
      return 5;
    }
    var input_int = int.tryParse(input ?? "");

    if (input_int != null) {
      if (input_int <= 10 && input_int >= 1) {
        return input_int;
      }
    }
  }
}

//Method submit quiz and displays the score
void submitQuiz(List<dynamic> questions) {
  int score = 0;
  int total = questions.length;
  for (int i = 0; i < questions.length; i++) {
    if (questions[i].checkAnswer()) {
      score++;
    }
  }
  stdout.write('Score: $score/$total');
}

//displays all incorrect answers
void reviewAnswers(List<dynamic> questions) {
  stdout.write('\nReview incorrect answers (y/n) [default: y]?');
  var response = stdin.readLineSync();
  if (response == 'n') {
    return;
  } else {
    for (int i = 0; i < questions.length; i++) {
      if (!questions[i].checkAnswer()) {
        questions[i].displayQuestion();
        var answer = questions[i].answer;
        stdout.write('Correct answer: $answer\n');
      }
    }
  }
}
