import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'main.dart';

void main() {
  runApp(MaterialApp(
    title: 'Navigation Basics',
    home: SecondRoute(),
  ));
}

class SecondRoute extends StatefulWidget {
  SecondRoute({Key? key}) : super(key: key);

  @override
  _SecondRoute createState() => _SecondRoute();
}

class _SecondRoute extends State<SecondRoute> {
  // Default values for list when displayed
  String defaultChoice = 'Mixed';
  String defaultNum = '5';

  var items = ['Mixed', 'Multiple Choice', 'Fill in Blank'];
  var amountOfQuestions = [
    '1',
    '2',
    '3',
    '4',
    '5',
    '6',
    '7',
    '8',
    '9',
    '10',
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: const Text('Settings'),
      ),
      body: Center(
        child: Padding(
          padding: const EdgeInsets.all(20.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                'Please select type of questions',
                style: TextStyle(fontSize: 20),
              ),
              DropdownButton(
                  value: defaultChoice,
                  icon: const Icon(Icons.keyboard_arrow_down),
                  items: items.map((String items) {
                    return DropdownMenuItem(
                      value: items,
                      child: Text(items),
                    );
                  }).toList(),
                  onChanged: (String? newValue) {
                    setState(() {
                      defaultChoice = newValue!;
                    });
                  }),
              Text(
                'Select amount of questions',
                style: TextStyle(fontSize: 20),
              ),
              DropdownButton(
                  value: defaultNum,
                  icon: const Icon(Icons.keyboard_arrow_down),
                  items: amountOfQuestions.map((String items) {
                    return DropdownMenuItem(
                      value: items,
                      child: Text(items),
                    );
                  }).toList(),
                  onChanged: (String? newTotal) {
                    setState(() {
                      defaultNum = newTotal!;
                    });
                  }),
              ElevatedButton(
                onPressed: () {},
                child: Text('Submit'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
