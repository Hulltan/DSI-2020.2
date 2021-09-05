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

  void _resetCounter() {
    AlertDialog alert = AlertDialog(
      content: Text(
        'The counter has reset.',
        style: TextStyle(color: Colors.greenAccent),
      ),
      actions: [
        TextButton(
          onPressed: Navigator.of(context).pop,
          child: Text(
            'Ok',
            style: TextStyle(color: Colors.greenAccent),
          ),
        )
      ],
    );
    showDialog(context: context, builder: (_) => alert);
    setState(() {
      _counter = 0;
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
      floatingActionButton: Row(
        mainAxisAlignment: MainAxisAlignment.end,
        children: [
          FloatingActionButton(
            onPressed: _incrementCounter,
            tooltip: 'Increment',
            child: Icon(Icons.plus_one),
          ),
          SizedBox(
            width: 10,
          ),
          FloatingActionButton(
              onPressed: _resetCounter,
              tooltip: 'Reset',
              child: Icon(
                Icons.clear,
              )),
        ],
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
