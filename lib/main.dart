import 'package:flutter/material.dart';
import 'package:social_app/pages/login.dart';
import 'package:social_app/pages/mainscr.dart';
import 'package:social_app/pages/signup.dart';

void main() {
  runApp(myApp());
}

// ignore: camel_case_types
class myApp extends StatefulWidget {
  const myApp({super.key});

  @override
  State<myApp> createState() => _myAppState();
}

// ignore: camel_case_types
class _myAppState extends State<myApp> {
  // ignore: prefer_typing_uninitialized_variables
  var finalEmail;
  Future getValidationData() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    var obtainedEmail = prefs.getString('email');
    setState(() {
      finalEmail = obtainedEmail;
    });
  }

  @override
  void initState() {
    super.initState();
    getValidationData();
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: "Social App",
      debugShowCheckedModeBanner: false,
      home: finalEmail == null ? login() : MainScreen(),
    );
  }
}
