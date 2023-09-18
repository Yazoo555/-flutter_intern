import 'dart:convert';
import 'package:day_seven/login.dart';
import 'package:uuid/uuid.dart';
import 'package:day_seven/model.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:shared_preferences/shared_preferences.dart';

class Signup extends StatefulWidget {
  const Signup({super.key});

  @override
  State<Signup> createState() => _SignupState();
}

class _SignupState extends State<Signup> {
  TextEditingController fullname = TextEditingController();
  TextEditingController dateofbirth = TextEditingController();
  TextEditingController mobilenumber = TextEditingController();
  TextEditingController email = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  final Fkey = GlobalKey<FormState>();
  String gender = 'Male';
  List<String> grpVal = ['Male', 'Female', 'Others'];
  String selectValue = "Married";
  Map<String, dynamic> signUpEmptyList = {};
  Map<String, dynamic> loginEmptyList = {};
  List<String> dropdownItem = ["Married", "Unmarried", "Divorced", "Widowed"];

  Future<void> signUp() async {
    SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
    final jsonString = sharedPreferences.getString('dataList');
    List<Usermodel> signuplist = [];
    print('User DATA: $jsonString');

    if (jsonString != null) {
      try {
        final jsonData = jsonDecode(jsonString);

        if (jsonData is List<dynamic>) {
          signuplist =
              jsonData.map((json) => Usermodel.fromJson(json)).toList();
          print(signuplist);
        } else if (jsonData is Map<String, dynamic>) {
          loginEmptyList
              .addAll(Usermodel.fromJson(jsonData) as Map<String, dynamic>);
        }
      } catch (e) {
        print(e);
      }
    }
    signuplist.add(
      Usermodel(
          fullname: fullname.text,
          userid: const Uuid().v4().toString(),
          email: email.text,
          password: passwordController.text,
          mobilenumber: mobilenumber.text,
          dateofbirth: dateofbirth.text,
          gender: gender,
          martialstatus: selectValue),
    );

    List<Map<String, dynamic>> jsonDataList =
        signuplist.map((cv) => cv.toJson()).toList();
    signuplist.map((cv) => cv.toJson()).toList();
    sharedPreferences.setString('dataList', json.encode(jsonDataList));

    loginEmptyList[email.text] = jsonDataList;
    String jsonData = json.encode(jsonDataList);
    sharedPreferences.setString('dataList', jsonData);

    Navigator.pushReplacement(
        context, MaterialPageRoute(builder: (context) => const login()));
  }

  void _registerUser() async {
    if (Fkey.currentState!.validate()) {
      await signUp();
    }
  }

  @override
  Widget build(BuildContext context) {
    //

    return Scaffold(
      appBar: AppBar(
        title: const Text("Sign Up Form"),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Form(
          key: Fkey,
          child: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                TextFormField(
                  validator: (text) {
                    final regex = RegExp(r'^[a-zA-Z]{4,}(?: [a-zA-Z]+){0,2}$');
                    if (text == null || text.isEmpty) {
                      return "should not be empty";
                    } else if (!regex.hasMatch(text)) {
                      return "accepts only character";
                    }
                    return null;
                  },
                  controller: fullname,
                  decoration: InputDecoration(
                    labelText: 'Full Name',
                    labelStyle: const TextStyle(fontSize: 16),
                    hintText: 'Enter your fullname',
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(20),
                      borderSide: const BorderSide(color: Colors.black),
                    ),
                  ),
                ),
                const SizedBox(
                  height: 15,
                ),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Row(
                    children: [
                      Text(
                        "Select Gender:",
                        style: TextStyle(
                          fontSize: 16,
                        ),
                      ),
                    ],
                  ),
                ),
                Row(
                  children: [
                    Radio(
                      value: 'Male',
                      groupValue: gender,
                      onChanged: ((value) {
                        gender = value!;
                        setState(() {
                          gender = value;
                        });
                      }),
                    ),
                    Text("Male"),
                    Radio(
                      value: "Female",
                      groupValue: gender,
                      onChanged: (value) {
                        setState(() {
                          gender = value!;
                        });
                      },
                    ),
                    Text("Female"),
                    Radio(
                      value: "Others",
                      groupValue: gender,
                      onChanged: (value) {
                        setState(() {
                          gender = value!;
                        });
                      },
                    ),
                    Text("Others")
                  ],
                ),
                SizedBox(
                  height: 20,
                ),
                TextFormField(
                  keyboardType: TextInputType.text,
                  validator: (value) {
                    RegExp(r'^(0[1-9]|1[0-9]|2[0-9]|3[01])-/. -/. $');
                    if (value!.isEmpty) {
                      return "DOB should not be Empty.";
                    }
                    return null;
                  },
                  readOnly: true,
                  controller: dateofbirth,
                  decoration: InputDecoration(
                    icon: Icon(Icons.calendar_today_rounded),
                    labelText: "Select Date of Birth",
                  ),
                  onTap: () async {
                    DateTime? pickeddate = await showDatePicker(
                        context: context,
                        initialDate: DateTime.now(),
                        firstDate: DateTime(1995),
                        lastDate: DateTime(2024));
                    if (pickeddate != null) {
                      setState(() {
                        dateofbirth.text =
                            DateFormat('yyyy-MM-dd').format(pickeddate);
                      });
                    }
                  },
                ),
                const SizedBox(
                  height: 20,
                ),
                TextFormField(
                  validator: (value) {
                    RegExp regExp = RegExp(r'^(?:[+0]9)?[0-9]{10}$');
                    if (value!.isEmpty) {
                      return 'Please enter mobile number';
                    } else if (!regExp.hasMatch(value)) {
                      return "Please enter valid phone number";
                    }
                    return null;
                  },
                  controller: mobilenumber,
                  decoration: InputDecoration(
                    labelText: "Mobile Number",
                    labelStyle: const TextStyle(fontSize: 16),
                    hintText: '+977**********',
                    prefixIcon: Icon(Icons.phone_android_outlined),
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(16),
                      borderSide: BorderSide(color: Colors.black45),
                    ),
                  ),
                ),
                SizedBox(
                  height: 20,
                ),
                Row(
                  children: [
                    Text("Martial Status"),
                    SizedBox(
                      width: 25,
                    ),
                    DropdownButton<String>(
                        focusColor: Colors.grey.shade300,
                        value: selectValue,
                        icon: Icon(
                          Icons.keyboard_arrow_down_outlined,
                          color: Colors.purple.shade400,
                        ),
                        items: dropdownItem.map((String item) {
                          return DropdownMenuItem<String>(
                            value: item,
                            child: Text(item),
                          );
                        }).toList(),
                        onChanged: (newValue) {
                          setState(() {
                            selectValue = newValue!;
                          });
                        }),
                  ],
                ),
                SizedBox(
                  height: 20,
                ),
                TextFormField(
                  validator: (text) {
                    final regex = RegExp(r'\S+@\S+\.\S+');
                    if (text == null || text.isEmpty) {
                      return "should not be empty";
                    } else if (text.length > 15) {
                      return 'Length size=15';
                    } else if (!regex.hasMatch(text)) {
                      return "enter a valid mail";
                    }
                    return null;
                  },
                  controller: email,
                  decoration: InputDecoration(
                    labelText: 'Email',
                    labelStyle: const TextStyle(fontSize: 16),
                    hintText: 'Enter your email',
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(20),
                      borderSide: const BorderSide(color: Colors.black),
                    ),
                  ),
                ),
                const SizedBox(
                  height: 20,
                ),
                TextFormField(
                  validator: (text) {
                    final regex =
                        RegExp(r"(?=.*\d)(?=.*[a-z])(?=.*[A-Z])(?=.*\W)");
                    if (text == null || text.isEmpty) {
                      return "should not be empty";
                    } else if (!regex.hasMatch(text)) {
                      return "password must contain special character,numbers and capital and small letter";
                    }
                    return null;
                  },
                  obscureText: true,
                  obscuringCharacter: "*",
                  controller: passwordController,
                  decoration: InputDecoration(
                    prefixIcon: const Icon(Icons.lock, color: Colors.black),
                    labelText: 'Password',
                    labelStyle: const TextStyle(fontSize: 16),
                    hintText: 'Enter Password',
                    disabledBorder: InputBorder.none,
                    focusedBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(15),
                    ),
                    border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(20)),
                  ),
                ),
                SizedBox(
                  height: 50,
                ),
                Align(
                  alignment: Alignment.center,
                  child: ElevatedButton(
                    onPressed: () {
                      if (Fkey.currentState!.validate()) {
                        setState(
                          () {
                            try {
                              // ignore: unused_local_variable
                              Usermodel user = signuplist.firstWhere(
                                  (user) => user.email == email.text);
                              ScaffoldMessenger.of(context).showSnackBar(
                                const SnackBar(
                                    content: Center(
                                      child: Text('Email already in use'),
                                    ),
                                    backgroundColor: Colors.purple),
                              );

                              return;
                            } catch (e) {
                              _registerUser();
                              return;
                            }
                          },
                        );
                      }
                    },
                    child: const Text("SignUp"),
                  ),
                ),
                SizedBox(
                  height: 30,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text("Already have an account:"),
                    TextButton(
                        onPressed: () {
                          Navigator.of(context).pop();
                        },
                        child: Text("Log-in"))
                  ],
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
