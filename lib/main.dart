import 'package:flutter/services.dart';
import 'package:flutter/material.dart';
import 'dart:math';
import 'package:password_generator/second_page.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: MyHomePage(),
    );
  }
}

class MyHomePage extends StatefulWidget {
  @override
  _MyHomePageState createState() => _MyHomePageState();
}

String password = "please press the button";

class _MyHomePageState extends State<MyHomePage> {
  String generatePassword(bool _isWithLetters, bool _isWithUppercase,
      bool _isWithNumbers, bool _isWithSpecial, double _numberCharPassword) {
    String _lowerCaseLettters = "abcdefghijklmnopqrstuvwxyz";
    String _upperCaseLetters = "ABCDEFGHIJKLMNOPQRSTUVWXYZ";
    String _numbers = "0123456789";
    String _special = "@#=+!£\$%&?[](){}";

    String _allowedChars = "";

    _allowedChars += (_isWithLetters ? _lowerCaseLettters : '');
    _allowedChars += (_isWithUppercase ? _upperCaseLetters : '');
    _allowedChars += (_isWithNumbers ? _numbers : '');
    _allowedChars += (_isWithSpecial ? _special : '');

    int i = 0;

    String _result = "";

    while (i < _numberCharPassword.round()) {
      int randomInt = Random.secure().nextInt(_allowedChars.length);
      _result = _result + _allowedChars[randomInt];
      i++;
    }
    return _result;
  }

  void generateRandomNumber() {
    setState(() {
      password = generatePassword(true, true, true, true, 40);
    });

    print(password);
  }

  @override
  Widget build(BuildContext context) {
    final key = new GlobalKey<ScaffoldState>();
    return Scaffold(
      backgroundColor: Color(0xFF21BFBD),
      key: key,
      body: ListView(
        children: <Widget>[
          Padding(
            padding: EdgeInsets.only(top: 50.0, left: 65.0),
            child: Row(
              children: <Widget>[
                Text('Password',
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      fontFamily: 'Montserrat',
                      color: Colors.white,
                      fontWeight: FontWeight.bold,
                      fontSize: 30.0,
                    )),
                SizedBox(
                  width: 10.0,
                ),
                Text('Generator',
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      fontFamily: 'Montserrat',
                      color: Colors.white,
                      fontSize: 30.0,
                    )),
              ],
            ),
          ),
          SizedBox(height: 70.0),
          Container(
            height: MediaQuery.of(context).size.height - 185.0,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                const SizedBox(height: 30),
                new GestureDetector(
                  child: new CustomToolTip(text: "$password"),
                  onTap: () {},
                ),
                Padding(
                  padding: EdgeInsets.all(30.0),
                ),
                RaisedButton(
                  onPressed: generateRandomNumber,
                  textColor: Colors.white,
                  padding: const EdgeInsets.all(0.0),
                  child: Container(
                    decoration: const BoxDecoration(
                      gradient: LinearGradient(
                        colors: <Color>[
                          Color(0xFF21BFBD),
                          Color(0xFF21BFBD),
                          Color(0xFF21BFBD),
                        ],
                      ),
                    ),
                    padding: const EdgeInsets.all(10.0),
                    child: const Text('Generate a password',
                        style: TextStyle(fontSize: 30)),
                  ),
                ),
                Padding(
                  padding: EdgeInsets.all(20.0),
                ),
                RaisedButton(
                  child: Text("Copy"),
                  color: Color(0xFF21BFBD),
                  onPressed: () {
                    Clipboard.setData(ClipboardData(text: "$password"));
                  },
                ),
                Padding(
                  padding: EdgeInsets.all(20.0),
                ),
                Align(
                    alignment: Alignment(1, -1),
                    child: RaisedButton(
                        child: Text('Go'),
                        onPressed: () => Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => TodoApp())))),
                RaisedButton(
                  child: Text("Go"),
                  onPressed: () => Navigator.push(context,
                      MaterialPageRoute(builder: (context) => TodoApp())),
                )
              ],
            ),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.only(topLeft: Radius.circular(75.0)),
            ),
          ),
        ],
      ),
    );
  }
}

class CustomToolTip extends StatelessWidget {
  String text;

  CustomToolTip({this.text});

  @override
  Widget build(BuildContext context) {
    return new GestureDetector(
      child: new Tooltip(
          preferBelow: false, message: "Copy", child: new Text("$password")),
      onTap: () {
        Clipboard.setData(new ClipboardData(text: "$password"));
      },
    );
  }
}
