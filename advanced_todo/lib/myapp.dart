
import 'package:advanced_todo/welcome.dart';
import 'package:flutter/material.dart';

class myApp extends StatelessWidget {
  const myApp({super.key});

  Widget build(BuildContext context) {
    return const MaterialApp(
      debugShowCheckedModeBanner: false,
      home: welcomescreen(),
    );
  }
}