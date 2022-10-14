import 'package:flutter/material.dart';
import 'Controller.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: const MyHomePage(
        title: 'Interactive Quiz App',
      ),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({Key? key, required this.title}) : super(key: key);

  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class LoginData {
  String username = '';
  String password = '';
}

class _MyHomePageState extends State<MyHomePage> {
  int _counter = 0;
  LoginData _loginData = new LoginData();
  GlobalKey<FormState> _formKey = new GlobalKey<FormState>();

  void _incrementCounter() {
    setState(() {
      // This call to setState tells the Flutter framework that something has
      // changed in this State, which causes it to rerun the build method below
      // so that the display can reflect the updated values. If we changed
      // _counter without calling setState(), then the build method would not be
      // called again, and so nothing would appear to happen.
      _counter++;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: Text(widget.title),
      ),
      body: Container(
        padding: EdgeInsets.all(50.0),
        child: Form(
          key: this._formKey,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              TextFormField(
                  keyboardType: TextInputType.emailAddress,
                  validator: (String? inValue) {
                    // ignore: prefer_is_empty
                    if (inValue?.length == 0) {
                      return 'Please enter username';
                    }
                    return null;
                  },
                  onSaved: (String? inValue) {
                    this._loginData.username = inValue!;
                  },
                  // ignore: prefer_const_constructors
                  decoration: InputDecoration(
                      hintText: "none@none.com",
                      labelText: 'Username (eMail address)')),
              TextFormField(
                obscureText: true,
                validator: (String? inValue) {
                  if (inValue?.length != 4) {
                    return 'Password must be 4 in length!';
                  }
                  return null;
                },
                onSaved: (String? inValue) {
                  this._loginData.password = inValue!;
                },
                // ignore: prefer_const_constructors
                decoration: InputDecoration(
                    hintText: 'password', labelText: 'password'),
              ),
              ElevatedButton(
                child: Text('Log in!'),
                onPressed: () {
                  if (_formKey.currentState!.validate()) {
                    _formKey.currentState!.save();
                    authenticateUser(_loginData.username, _loginData.password);
                  }
                },
              ),
            ],
          ),
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: _incrementCounter,
        tooltip: 'Increment',
        child: const Icon(Icons.add),
      ), // This trailing comma makes auto-formatting nicer for build methods.
    );
  }
}
