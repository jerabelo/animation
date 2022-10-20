import 'package:flutter/material.dart';
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
      body: Container(
        padding: EdgeInsets.all(25.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          // ignore: prefer_const_literals_to_create_immutables
          children: <Widget>[
            // ignore: prefer_const_constructors
            Center(
              child: Text(
                'How many questions would you like?',
                // ignore: prefer_const_constructors
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 15,
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(25.0),
              child: TextField(
                decoration: InputDecoration(
                    border: OutlineInputBorder(),
                    hintText: 'Number of questions'),
              ),
            ),
            Column(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                ActionChip(
                  elevation: 8.0,
                  padding: EdgeInsets.all(2.0),
                  avatar: CircleAvatar(
                    backgroundColor: Colors.redAccent,
                    child: Icon(Icons.mode_comment),
                  ),
                  label: Text('Multiple Choice'),
                  onPressed: () {},
                ),
                ActionChip(
                  elevation: 8.0,
                  padding: EdgeInsets.all(2.0),
                  avatar: CircleAvatar(
                    backgroundColor: Colors.redAccent,
                    child: Icon(Icons.mode_comment),
                  ),
                  label: Text('Fill in Blank'),
                  onPressed: () {},
                ),
                ActionChip(
                  elevation: 8.0,
                  padding: EdgeInsets.all(2.0),
                  avatar: CircleAvatar(
                    backgroundColor: Colors.redAccent,
                    child: Icon(Icons.mode_comment),
                  ),
                  label: Text('Mixed'),
                  onPressed: () {},
                ),
              ],
            ),
            ElevatedButton(onPressed: () {}, child: const Text('Submit')),
          ],
        ),
      ),
    );
  }
}
