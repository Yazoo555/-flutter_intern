import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:social_app/Model/user_Model.dart';
import 'package:social_app/pages/login.dart';
import 'package:social_app/pages/signup.dart';

// ignore: camel_case_types
class forgotpwd extends StatefulWidget {
  const forgotpwd({super.key});

  @override
  State<forgotpwd> createState() => _forgotpwdState();
}

// ignore: camel_case_types
class _forgotpwdState extends State<forgotpwd> {
  TextEditingController emlControl = TextEditingController();
  TextEditingController pwdcontrol = TextEditingController();
  final fmky = GlobalKey<FormState>();
  bool visible = false;

  Future<void> updateUser() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    try {
      UserModel users =
          usersDataList.firstWhere((eml) => eml.email == emlControl.text);

      int index = usersDataList.indexWhere((user) => user.id == users.id);
      if (index != -1) {
        usersDataList[index].password = pwdcontrol.text;
        String updatedUserListJson = jsonEncode(usersDataList);
        await prefs.setString('dataList', updatedUserListJson);

        // ignore: use_build_context_synchronously
        Navigator.pushReplacement(
            context, MaterialPageRoute(builder: (context) => const login()));
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
                  'Password Successfully Changed!',
                  style: TextStyle(
                    fontSize: 14,
                    fontWeight: FontWeight.w500,
                  ),
                ),
              ],
            ),
            backgroundColor:
                Colors.blue, // Customize the background color for success
            elevation: 2,
            behavior: SnackBarBehavior.floating,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(10.0),
            ),
            duration: Duration(seconds: 2),
          ),
        );
      }
    } catch (e) {
      // ignore: use_build_context_synchronously
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text(
            'Invalid Email',
            style: TextStyle(fontSize: 15, fontWeight: FontWeight.w400),
          ),
          backgroundColor: Colors.orange.shade500,
          duration: Duration(seconds: 1),
        ),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          icon: Icon(Icons.arrow_back),
          onPressed: () {
            Navigator.pushReplacement(
              context,
              MaterialPageRoute(
                builder: (context) => login(),
              ),
            );
          },
        ),
        toolbarHeight: 45.0,
        title: Text(
          "Forgot Password",
          style: TextStyle(
            fontSize: 18,
            fontWeight: FontWeight.w500,
          ),
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(10.0),
        child: Form(
          key: fmky,
          child: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                SizedBox(
                  height: 12,
                ),
                Text(
                  "Forgot Your Password",
                  style: TextStyle(
                    fontSize: 25,
                    fontWeight: FontWeight.w400,
                  ),
                ),
                SizedBox(
                  height: 20,
                ),
                TextFormField(
                  controller: emlControl,
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
                  height: 20,
                ),
                TextFormField(
                  obscureText: visible,
                  obscuringCharacter: "*",
                  controller: pwdcontrol,
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return "Enter Your Password";
                    } else if (value.length < 8) {
                      return "Password should be 8 Digits";
                    }
                    return null;
                  },
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
                    hintText: "Hint: Abc@#123",
                    labelText: "Enter New Password",
                    labelStyle: TextStyle(
                      fontWeight: FontWeight.w300,
                      color: Colors.grey.shade600,
                    ),
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
                ),
                SizedBox(
                  height: 45,
                ),
                Align(
                  alignment: Alignment.center,
                  child: Column(
                    children: [
                      ElevatedButton(
                        style: ElevatedButton.styleFrom(
                          elevation: 2,
                          backgroundColor: Colors.blueGrey.shade500,
                          fixedSize: Size(150, 50),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(10),
                          ),
                        ),
                        onPressed: () {
                          if (fmky.currentState!.validate()) {
                            setState(() {
                              updateUser();
                            });
                          }
                        },
                        child: Text(
                          "Change Password",
                          style: TextStyle(
                            fontSize: 14.5,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      )
                    ],
                  ),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
