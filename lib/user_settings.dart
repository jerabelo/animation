import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'main.dart';

void main() {
  runApp(const MaterialApp(
    title: 'Navigation Basics',
    home: const SecondRoute(),
  ));
}

class SecondRoute extends StatelessWidget {
  const SecondRoute({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Settings'),
      ),
      body: Center(
        child: Column(
          children: <Widget>[
            Container(
              child: Text(
                'Select question type',
                // ignore: prefer_const_constructors
                style: TextStyle(
                  fontSize: 25,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
            SizedBox(
              width: 500,
              child: Container(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Padding(
                      padding: const EdgeInsets.all(80.0),
                      child: ActionChip(
                        elevation: 8.0,
                        padding: EdgeInsets.all(2.0),
                        avatar: const CircleAvatar(
                          backgroundColor: Colors.redAccent,
                          child: Icon(Icons.question_mark_rounded),
                        ),
                        label: Text('Multiple Choice'),
                        onPressed: () {},
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.all(100.0),
                      child: ActionChip(
                        elevation: 8.0,
                        padding: EdgeInsets.all(2.0),
                        avatar: const CircleAvatar(
                          backgroundColor: Colors.redAccent,
                          child: Icon(Icons.question_mark_rounded),
                        ),
                        label: Text('Mixed'),
                        onPressed: () {},
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.all(80.0),
                      child: ActionChip(
                        elevation: 8.0,
                        padding: EdgeInsets.all(2.0),
                        avatar: const CircleAvatar(
                          backgroundColor: Colors.redAccent,
                          child: Icon(Icons.question_mark_rounded),
                        ),
                        label: const Text('Fill in Blank'),
                        onPressed: () {},
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
