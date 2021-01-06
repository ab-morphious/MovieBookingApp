import 'package:cinema/screens/homepage.dart';
import 'package:flutter/material.dart';
import 'package:permission_handler/permission_handler.dart';
void main() {
  runApp(CinemaApp());
}

class CinemaApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Cinema App',
      theme: ThemeData(
        primarySwatch: Colors.blue,
        visualDensity: VisualDensity.adaptivePlatformDensity,
      ),
      home: HomePage(),
    );
  }
}

