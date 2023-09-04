import 'package:flutter/material.dart';
import 'day_6/cv_page.dart';

void main() {
  runApp(myapp());
}

class myapp extends StatelessWidget {
  const myapp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: "CV Assignment",
      home: CvPage(),
    );
  }
}
