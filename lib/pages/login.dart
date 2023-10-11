import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:social_app/Model/user_Model.dart';
import 'package:social_app/pages/forgotpwd.dart';
import 'package:social_app/pages/mainscr.dart';
import 'package:social_app/pages/signup.dart';

List<UserModel> usersDataList = [];

class login extends StatefulWidget {
  const login({super.key});
  @override
  State<login> createState() => _loginState();
}

// ignore: camel_case_types
class _loginState extends State<login> {
  final formkey = GlobalKey<FormState>();
  bool visible = false;
  TextEditingController emailControl = TextEditingController();
  TextEditingController passwordControl = TextEditingController();

  Future<void> fetchUserData() async {
    try {
      SharedPreferences sharedPreferences =
          await SharedPreferences.getInstance();
      String? jsonString = sharedPreferences.getString('dataList');

      if (jsonString == null) {
        String userString;
        try {
          userString = await rootBundle.loadString('assets/user.json');
        } catch (e) {
          print("Error loading 'user.json': $e");
          return;
        }
        final jsonData = json.decode(userString);

        if (jsonData is List<dynamic>) {
          usersDataList =
              jsonData.map((json) => UserModel.fromJson(json)).toList();
        } else if (jsonData is Map<String, dynamic>) {
          usersDataList.add(UserModel.fromJson(jsonData));
        }
        List<Map<String, dynamic>> jsonDataList =
            usersDataList.map((cv) => cv.toJson()).toList();

        String jsonDataString = json.encode(jsonDataList);
        sharedPreferences.setString('dataList', jsonDataString);
      }
    } catch (e) {
      //  print(e);
      rethrow;
    }
  }

  Future<List<String>> getUserData() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String? jsonData = prefs.getString('dataList');

    if (jsonData != null) {
      try {
        final decodedData = json.decode(jsonData) as List<dynamic>;
        usersDataList = decodedData.map((e) => UserModel.fromJson(e)).toList();
/*
        setState(
          () {},
        );
*/
      } catch (e) {
        rethrow;
      }
    } else {
      usersDataList = [];
    }
    return [];
  }

  Future<void> performLogin(String emaill, String passwordd) async {
    try {
      SharedPreferences prefs = await SharedPreferences.getInstance();

      // Convert email and password to lowercase
      // final lowercaseEmail = emaill.toLowerCase();
      // final lowercasePassword = passwordd.toLowerCase();

      UserModel? user = usersDataList.firstWhere(
        (user) =>
            // user.email?.toLowerCase() == lowercaseEmail &&
            //user.password?.toLowerCase() == lowercasePassword,

            user.email == emaill && user.password == passwordd,
      );

      // ignore: unnecessary_null_comparison
      if (user != null) {
        prefs.setString('userID', user.id.toString());
        prefs.setString('email', emaill);

        // Show a success dialog
        // ignore: use_build_context_synchronously
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Row(
              children: const <Widget>[
                Icon(
                  Icons.check_circle_outline,
                  color: Colors.white,
                  size: 24,
                ),
                SizedBox(width: 8),
                Text(
                  'Login Successful!',
                  style: TextStyle(
                    fontSize: 14,
                    fontWeight: FontWeight.w500,
                  ),
                ),
              ],
            ),
            backgroundColor: Colors.green.shade500,
            elevation: 2,
            behavior: SnackBarBehavior.floating,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(10.0),
            ),
            duration: Duration(seconds: 2),
          ),
        );

        // ignore: use_build_context_synchronously
        Navigator.pushReplacement(
          context,
          MaterialPageRoute(
            builder: (context) => const MainScreen(),
          ),
        );
/*
        print(user.martialStatus);
        print(user.dob);
        print(user.email);
        print(user.fullname);
*/
      } else {
        // ignore: use_build_context_synchronously
        await showDialog(
          context:
              context, // Ensure that 'context' is accessible in this function
          builder: (BuildContext context) {
            return AlertDialog(
              title: Text('Invalid!!'),
              content: Text('Email / password does not match!'),
              actions: [
                TextButton(
                  onPressed: () {
                    Navigator.of(context).pop(); // Close the dialog
                  },
                  child: Text('OK'),
                ),
              ],
            );
          },
        );
      }
    } catch (e) {
      // ignore: use_build_context_synchronously
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Row(
            children: const <Widget>[
              Icon(
                Icons.error_outline,
                color: Colors.white,
                size: 24,
              ),
              SizedBox(width: 8),
              Text(
                'Email / Password Does Not Match!',
                style: TextStyle(
                  fontSize: 14,
                  fontWeight: FontWeight.w500,
                ),
              ),
            ],
          ),
          backgroundColor: Colors.redAccent,
          elevation: 2,
          behavior: SnackBarBehavior.floating,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(12.0),
          ),
          duration: Duration(seconds: 2),
        ),
      );
    }
  }

  @override
  void initState() {
    super.initState();
    getUserData();
    fetchUserData();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        toolbarHeight: 45.0,
        title: Text(
          "Log-In Page",
          style: TextStyle(
            fontSize: 18,
            fontWeight: FontWeight.w500,
          ),
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(10.0),
        child: Form(
          key: formkey,
          child: SingleChildScrollView(
            child: SingleChildScrollView(
              child: Column(
                children: [
                  Text(
                    "User Login",
                    style: TextStyle(
                      fontWeight: FontWeight.w400,
                      fontSize: 25,
                    ),
                  ),
                  SizedBox(
                    height: 15,
                  ),
                  TextFormField(
                    controller: emailControl,
                    decoration: InputDecoration(
                      hintText: "abc@gmail.com",
                      labelText: "Enter Your Email",
                      labelStyle: TextStyle(
                        color: Colors.grey.shade600,
                        fontWeight: FontWeight.w300,
                      ),
                      enabledBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(16),
                        borderSide: BorderSide(
                          color: Colors.orange.shade200,
                        ),
                      ),
                      focusedBorder: OutlineInputBorder(
                        borderSide: BorderSide(color: Colors.orange.shade900),
                      ),
                    ),
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return "Enter Your Email";
                      } else if (!RegExp(
                              r"^[a-zA-Z0-9.a-zA-Z0-9.!#$%&'*+-/=?^_`{|}~]+@[a-zA-Z0-9]+\.[a-zA-Z]+")
                          .hasMatch(value)) {
                        return 'Invalid email format';
                      }
                      return null;
                    },
                  ),
                  SizedBox(
                    height: 25,
                  ),
                  TextFormField(
                    controller: passwordControl,
                    obscureText: visible,
                    obscuringCharacter: "*",
                    decoration: InputDecoration(
                      suffixIcon: GestureDetector(
                        onTap: () {
                          setState(
                            () {
                              visible = !visible;
                            },
                          );
                        },
                        child: Icon(
                          visible ? Icons.visibility_off : Icons.visibility,
                          color: Colors.black87,
                        ),
                      ),
                      hintText: "Hint:  Abc@#123",
                      labelText: "Enter Password",
                      labelStyle: TextStyle(
                          color: Colors.grey.shade600,
                          fontWeight: FontWeight.w300),
                      enabledBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(16),
                        borderSide: BorderSide(
                          color: Colors.orange.shade200,
                        ),
                      ),
                      focusedBorder: OutlineInputBorder(
                        borderSide: BorderSide(
                          color: Colors.orange.shade900,
                        ),
                      ),
                    ),
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return "Enter Password";
                      } else if (value.length < 8) {
                        return "Password should be 8 Digits";
                      }
                      return null;
                    },
                  ),
                  SizedBox(
                    height: 40,
                  ),
                  ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      elevation: 2,
                      backgroundColor: Colors.red.shade400,
                      fixedSize: Size(130, 45),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(10),
                      ),
                    ),
                    onPressed: () {
                      if (formkey.currentState!.validate()) {
                        setState(() {
                          // login();
                          performLogin(emailControl.text, passwordControl.text);
                        });
                      }
                    },
                    child: Text(
                      "Log In",
                      style:
                          TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                    ),
                  ),
                  SizedBox(
                    height: 15,
                  ),
                  TextButton(
                    onPressed: () {
                      Navigator.pushReplacement(
                        context,
                        MaterialPageRoute(
                          builder: (context) => forgotpwd(),
                        ),
                      );
                    },
                    child: const Text(
                      'Forgot Password',
                      style: TextStyle(
                        fontSize: 16.5,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                  ),
                  SizedBox(
                    height: 20,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      GestureDetector(
                        onTap: () {
                          // Add your navigation or action when the "Signup" text is clicked.
                          // For example, you can navigate to the signup screen.
                          Navigator.pushReplacement(
                            context,
                            MaterialPageRoute(
                              builder: (context) => signup(),
                            ),
                          );
                        },
                        child: Text.rich(
                          TextSpan(
                            text: "New User ?",
                            style: TextStyle(
                              fontWeight: FontWeight.w400,
                              fontSize: 20,
                            ),
                            children: [
                              TextSpan(
                                text: "\t SignUp",
                                style: TextStyle(
                                  fontWeight: FontWeight.w600,
                                  fontSize: 22,
                                  color: Colors.green.shade500,
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
