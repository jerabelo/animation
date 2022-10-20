import 'package:animation/user_settings.dart';
import 'package:flutter/material.dart';
import 'Controller.dart';
import 'dart:io';
import 'package:shared_preferences/shared_preferences.dart';

void main() {
  HttpOverrides.global = MyHttpOverrides();
  runApp(const MyApp());
}

class MyHttpOverrides extends HttpOverrides {
  @override
  HttpClient createHttpClient(SecurityContext? context) {
    return super.createHttpClient(context)
      ..badCertificateCallback =
          (X509Certificate cert, String host, int port) => true;
  }
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
        primarySwatch: Colors.red,
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
  String _response = '';
  LoginData _loginData = new LoginData();
  GlobalKey<FormState> _formKey = new GlobalKey<FormState>();

  void _checkUser(String user, String id) {
    setState(() {
      _response;
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
      body: SingleChildScrollView(
        child: Container(
          padding: EdgeInsets.all(25.0),
          child: Form(
            key: this._formKey,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              mainAxisSize: MainAxisSize.max,
              children: <Widget>[
                Container(
                  child: Image.asset(
                    'android/assets/utep_logo.png',
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(top: 100),
                  child: TextFormField(
                    keyboardType: TextInputType.emailAddress,
                    validator: (String? inValue) {
                      // ignore: prefer_is_empty
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
                        hintText: "miners username",
                        labelText: 'username',
                        border: const OutlineInputBorder()),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(top: 25.0),
                  child: TextFormField(
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
                        hintText: 'last 4 of ID',
                        labelText: 'password',
                        border: OutlineInputBorder()),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(100.0),
                  child: ElevatedButton(
                    child: Text('Log in!'),
                    onPressed: () {
                      if (_formKey.currentState!.validate()) {
                        _formKey.currentState!.save();
                        FutureBuilder<String>(
                            future: authenticateUser(
                                _loginData.username, _loginData.password),
                            builder: (BuildContext context,
                                AsyncSnapshot<String> snapshot) {
                              if (snapshot.hasData) {
                                _response = snapshot.data!;
                              }
                              return Text(_response);
                            });
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => SecondRoute()),
                        );
                      }
                    },
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
