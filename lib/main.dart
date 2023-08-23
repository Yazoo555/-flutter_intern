import 'package:flutter/material.dart';

import 'day_three_task.dart';

void main() {
  runApp(myapp());
}

class myapp extends StatelessWidget {
  const myapp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: "Day - 3 Three Task",
      home: DayThreeTask(),
    );
  }
}
