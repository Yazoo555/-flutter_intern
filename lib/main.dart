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
      theme: ThemeData(
        brightness: Brightness.light,
      ),
      darkTheme: ThemeData(brightness: Brightness.dark),
      themeMode: ThemeMode.light,
      debugShowCheckedModeBanner: false,
      title: "CV Assignment",
      home: CvPage(),
    );
  }
}
