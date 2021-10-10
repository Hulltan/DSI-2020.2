import 'package:flutter/material.dart';
import 'package:contador/view/word_pair_view.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Startup Name Generator',
      theme: ThemeData(
        brightness: Brightness.dark,
      ),
      debugShowCheckedModeBanner: false,
      initialRoute: '/',
      routes:{
        '/': (context) => Home(),
        '/update': (context) => UpdateScreen(),
        '/favorites': (context) => FavoriteScreen(),
      },
    );
  }
}


