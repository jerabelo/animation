import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import "responseWidgets.dart";
import 'Model.dart';
import 'Controller.dart';
import 'dart:async';

main() => runApp(MyApp());

class MyApp extends StatefulWidget {
  @override
  MyAppState createState() {
    return new MyAppState();
  }
}

class MyAppState extends State<MyApp> {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(body: QuizPage()),
    );
  }
}

class QuizPage extends StatefulWidget {
  const QuizPage({Key? key}) : super(key: key);
  @override
  State<QuizPage> createState() => _QuizPageState();
}

class _QuizPageState extends State<QuizPage> {
  List<dynamic> quiz = [];
  bool isLoading = true;
  int _navbarindex = 0;

  void createquiz() async {
    var list = await getQuestions();
    setState(() {
      quiz = generateRandomQuiz(list, 10);
      isLoading = false;
    });
  }

  @override
  void initState() {
    createquiz();
    super.initState();
  }

  void _submit() {
    setState(() {});
  }

  Widget getWidget(var Question) {
    if (Question is MultipleChoiceQuestion) {
      return multipleChoiceList(Question);
    } else {
      return freeResponse(Question);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: isLoading
          ? Center(child: CircularProgressIndicator())
          : PageView.builder(
              itemCount: quiz.length,
              itemBuilder: (context, int index) {
                return Container(
                  color: Theme.of(context).colorScheme.background,
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      Container(
                        padding: EdgeInsets.all(20),
                        child: Text(
                          quiz[index].getStem(),
                          textAlign: TextAlign.left,
                          textScaleFactor: 2,
                        ),
                      ),
                      getWidget(quiz[index]),
                    ],
                  ),
                );
              }),
      floatingActionButton: FloatingActionButton.extended(
        onPressed: _submit,
        label: const Text('Submit'),
        icon: const Icon(Icons.thumb_up),
        backgroundColor: Colors.red,
      ),
    );
  }
}
