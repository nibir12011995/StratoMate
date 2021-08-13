import 'package:flutter/material.dart';
import 'package:strato_mate/pages/choose_location.dart';
import 'package:strato_mate/pages/home.dart';
import 'package:strato_mate/pages/loading.dart';
import 'package:strato_mate/screens/loading_screen.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      //* Routes for world time integartion
      routes: {
        '/loading': (context) => Loading(),
        '/home': (context) => Home(),
        '/location': (context) => ChooseLocation(),
      },

      //* weather app main screen
      theme: ThemeData.dark(),
      home: LoadingScreen(),
    );
  }
}
