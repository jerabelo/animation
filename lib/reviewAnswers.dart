import 'package:animation/Model.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class reviewScreen extends StatefulWidget {
  final List<dynamic> questions;
  const reviewScreen(this.questions);

  @override
  _reviewScreenState createState() => _reviewScreenState();
}

class _reviewScreenState extends State<reviewScreen> {
  String checkResponse(var question) {
    if (question == Null) {
      return " ";
    } else {
      return question.getResponse();
    }
  }

  String getScore() {
    int score = 0;
    int total = widget.questions.length;
    for (int i = 0; i < widget.questions.length; i++) {
      if (widget.questions[i].checkAnswer()) {
        score++;
      }
    }
    return "Final Score is: $score/$total";
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Column(
      children: <Widget>[
        Text(getScore()),
        DataTable(
            columns: const <DataColumn>[
              DataColumn(label: Text('Question')),
              DataColumn(label: Text('Response'))
            ],
            rows: List<DataRow>.generate(
              widget.questions.length,
              (int index) => DataRow(cells: <DataCell>[
                DataCell(Text(widget.questions[index].getStem())),
                DataCell(Text(checkResponse(widget.questions[index]))),
              ]),
            ))
      ],
    ));
  }
}
