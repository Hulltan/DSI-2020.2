import 'package:flutter/material.dart';

int _counter = 0;

class FirstPage extends StatefulWidget {
  // const FirstPage({Key? key}) : super(key: key);

  @override
  _FirstPageState createState() => _FirstPageState();
}

class _FirstPageState extends State<FirstPage> {
  void _incrementCounter() {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text('One more for counter!'),
        duration: Duration(milliseconds: 100),
        backgroundColor: Colors.greenAccent,
      ),
    );
    setState(() {
      _counter++;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Text(
              'Push the button!',
              style: TextStyle(
                color: Colors.greenAccent,
                fontSize: 30,
              ),
            ),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: _incrementCounter,
        backgroundColor: Colors.greenAccent,
        tooltip: 'Increment',
        child: Icon(Icons.plus_one),
      ),
    );
  }
}

class SecondPage extends StatefulWidget {
  // const SecondPage({Key? key}) : super(key: key);

  @override
  _SecondPageState createState() => _SecondPageState();
}

class _SecondPageState extends State<SecondPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Text(
              'You have pushed the button this many times:',
              style: TextStyle(
                color: Colors.greenAccent,
              ),
            ),
            Text(
              '$_counter',
              style: TextStyle(
                color: Colors.greenAccent,
                fontSize: 40,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
