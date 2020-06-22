import 'package:flutter/material.dart';
import 'package:memoir_mu/views/home.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Memoir Mockup',
      theme: ThemeData.dark(),
      home: HomePage(),
    );
  }
}