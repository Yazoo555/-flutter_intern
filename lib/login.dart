import 'dart:convert';
import 'package:day_seven/Signup.dart';
import 'package:day_seven/dashb.dart';
import 'package:day_seven/model.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:shared_preferences/shared_preferences.dart';

List<Usermodel> user = [];

class login extends StatefulWidget {
  const login({super.key});

  @override
  State<login> createState() => _loginState();
}

class _loginState extends State<login> {
  TextEditingController email = TextEditingController();
  TextEditingController password = TextEditingController();

  Future<List<String>> getuserdata() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String? jsonData = prefs.getString('dataList');
    print("Data :${jsonData}");
    if (jsonData != null) {
      try {
        final decodedData = json.decode(jsonData) as List<dynamic>;
        setState(() {
          user = decodedData.map((e) => Usermodel.fromJson(e)).toList();
        });
      } catch (e) {
        rethrow;
      }
    } else {
      user = [];
    }
    return [];
  }

  //
  Future<void> fetchuserData() async {
    try {
      SharedPreferences sharedPreferences =
          await SharedPreferences.getInstance();
      final jsonData = sharedPreferences.getString('dataList');
      if (jsonData == null) {
        String? jsonData = await rootBundle.loadString("assets/users.json");
        final jsonList = json.decode(jsonData);
        // print(jsonList);
        if (jsonList is List<dynamic>) {
          user = jsonList.map((json) => Usermodel.fromJson(json)).toList();
        } else if (jsonList is Map<String, dynamic>) {
          user.add(Usermodel.fromJson(jsonList));
        }
        List<Map<String, dynamic>> jsonDatalist =
            user.map((cv) => cv.toJson()).toList();
        String jsonDataString = json.encode(jsonDatalist);
        sharedPreferences.setString("dataList", jsonDataString);
      }
    } catch (e) {
      rethrow;
    }
  }

  //
  Future<void> _loginuser(String email, String password) async {
    try {
      SharedPreferences prefs = await SharedPreferences.getInstance();

      // ignore: unused_local_variable
      Usermodel users = user.firstWhere(
          (user) => user.email == email && user.password == password);
      prefs.setString('userid', users.userid.toString());

      // ignore: use_build_context_synchronously
      Navigator.pushReplacement(context,
          MaterialPageRoute(builder: (context) => Dashboard(userData: users)));
      // ignore: use_build_context_synchronously
      ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
        content: Center(
            child: Text(
          'Login Sucessfully',
        )),
        backgroundColor: Color.fromARGB(255, 84, 163, 248),
      ));

      return;
    } catch (e) {
      // ignore: use_build_context_synchronously
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
            content: Center(child: Text('User Not Found')),
            backgroundColor: Colors.redAccent),
      );
      return;
    }
  }

  @override
  void initState() {
    super.initState();
    getuserdata();
    fetchuserData();
  }

  final lfkey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("User LogIn"),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Form(
          key: lfkey,
          child: SingleChildScrollView(
            child: Column(
              children: [
                TextFormField(
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return "Please enter your Email";
                    }
                    return null;
                  },
                  controller: email,
                  decoration: InputDecoration(
                    labelText: "Email",
                    labelStyle: TextStyle(fontSize: 16),
                    hintText: "Enter your email",
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(20),
                      borderSide: BorderSide(color: Colors.black54),
                    ),
                  ),
                ),
                SizedBox(
                  height: 25,
                ),
                TextFormField(
                  obscureText: true,
                  obscuringCharacter: "*",
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return "Please enter your password";
                    }
                    return null;
                  },
                  controller: password,
                  decoration: InputDecoration(
                    labelText: "Password",
                    labelStyle: TextStyle(fontSize: 16),
                    hintText: "Enter your Password",
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(20),
                      borderSide: BorderSide(color: Colors.black54),
                    ),
                  ),
                ),
                SizedBox(
                  height: 35,
                ),
                Column(
                  children: [
                    ElevatedButton(
                      style: ElevatedButton.styleFrom(
                        elevation: 2,
                        foregroundColor: Colors.white,
                        backgroundColor: Colors.green.shade400,
                        // Text color
                        padding:
                            EdgeInsets.symmetric(horizontal: 20, vertical: 10),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(12.0),
                        ),
                      ),
                      onPressed: () {
                        if (lfkey.currentState!.validate()) {
                          _loginuser(email.text, password.text);
                        }
                      },
                      child: Text(
                        "Log In",
                        style: TextStyle(
                            fontSize: 18, fontWeight: FontWeight.bold),
                      ),
                    )
                  ],
                ),
                SizedBox(
                  height: 65,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      "No Account, Please:",
                      style:
                          TextStyle(fontSize: 17, fontWeight: FontWeight.w400),
                    ),
                    TextButton(
                      onPressed: () {
                        Navigator.push(context,
                            MaterialPageRoute(builder: (context) => Signup()));
                      },
                      child: Text(
                        "Signup",
                        style: TextStyle(
                            fontSize: 20, fontWeight: FontWeight.bold),
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
