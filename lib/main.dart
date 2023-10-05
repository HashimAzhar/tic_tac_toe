import 'package:flutter/material.dart';
import 'package:tic_tac_toe/Game.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData(
        scaffoldBackgroundColor: Colors.red,
      ),
      debugShowCheckedModeBanner: false,
      home: Game(),

    );
  }
}