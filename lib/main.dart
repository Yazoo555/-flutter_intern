import 'package:day_seven/Signup.dart';
import 'package:day_seven/login.dart';
import 'package:flutter/material.dart';

void main() {
  runApp(myapp());
}

class myapp extends StatelessWidget {
  const myapp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: "Day - 7 Task",
      debugShowCheckedModeBanner: false,
      home: login(),
    );
  }
}
