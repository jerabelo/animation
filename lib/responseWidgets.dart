import 'dart:io';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'Model.dart';

main() => runApp(MyApp());

class MyApp extends StatefulWidget {
  @override
  MyAppState createState() {
    return new MyAppState();
  }
}

class MyAppState extends State<MyApp> {
  FillInBlankQuestion question =
      FillInBlankQuestion("This is the stem of the Question", "answer");

  MultipleChoiceQuestion question1 = MultipleChoiceQuestion(
      "what is the question choices",
      ["this is the answer", "this is not the answer"],
      "this is the answer");
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(body: multipleChoiceList(question1)),
    );
  }
}

class multipleChoiceList extends StatefulWidget {
  final MultipleChoiceQuestion question;
  const multipleChoiceList(this.question);
  @override
  _multipleChoiceListState createState() => _multipleChoiceListState();
}

class _multipleChoiceListState extends State<multipleChoiceList> {
  List<String> opts = [];
  int? _value = 1;

  @override
  void initState() {
    this.opts = widget.question.getChoices();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        for (int i = 1; i < opts.length + 1; i++)
          ListTile(
            title: Text(opts[i - 1]),
            leading: Radio<int>(
                value: i,
                groupValue: _value,
                onChanged: ((var value) {
                  setState(() {
                    print('$value');
                    _value = value as int;
                    widget.question.setResponse(value);
                    var response = widget.question.getResponse();
                    print('$response');
                  });
                })),
          ),
      ],
    );
  }
}

class freeResponse extends StatefulWidget {
  final FillInBlankQuestion question;
  const freeResponse(this.question);

  @override
  _freeResponseState createState() => _freeResponseState();
}

class _freeResponseState extends State<freeResponse> {
  late TextEditingController _controller;

  @override
  void initState() {
    super.initState();
    _controller = TextEditingController();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.white,
      child: Padding(
        padding: EdgeInsets.symmetric(horizontal: 32, vertical: 32),
        child: TextField(
          decoration: InputDecoration(
            border: UnderlineInputBorder(),
            labelText: 'Enter your answer',
          ),
          controller: _controller,
          onSubmitted: ((String value) {
            setState(() {
              widget.question.setResponse(value);
            });
          }),
        ),
      ),
    );
  }
}
