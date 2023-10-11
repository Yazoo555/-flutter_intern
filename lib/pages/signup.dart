import 'dart:convert';
import 'dart:io';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:social_app/Model/user_Model.dart';
import 'package:social_app/pages/login.dart';
import 'package:social_app/R_Button/radio_but.dart';
// ignore: depend_on_referenced_packages
export 'package:shared_preferences/shared_preferences.dart';
// ignore: depend_on_referenced_packages
import 'package:intl/intl.dart';
// ignore: depend_on_referenced_packages
import 'package:image_picker/image_picker.dart';
import 'package:social_app/pages/signup.dart';
import 'package:uuid/uuid.dart';

Map<String, dynamic> loginEmptyList = {};

// ignore: camel_case_types
class signup extends StatefulWidget {
  const signup({super.key});

  @override
  State<signup> createState() => _signupState();
}

// ignore: camel_case_types
class _signupState extends State<signup> {
  File? image;

  bool visible = false;
  String selectValue = 'Single';
  String genderList = '';

  List<String> dropdownItem = [
    'Single',
    'Married',
    'Divorced',
    'Widowed',
  ];
  final ImagePicker picker = ImagePicker();
  Future takePhoto(ImageSource source) async {
    try {
      final pickedProfile = await picker.pickImage(source: source);
      if (pickedProfile == null) return;
      String imagePath = pickedProfile.path;
      File? img = File(imagePath);
      setState(() {
        image = img;
        Navigator.of(context).pop();
      });
    } on PlatformException {
      //rethrow;
      // ignore: use_build_context_synchronously
      Navigator.of(context).pop();
    }
  }

  void signUp() async {
    SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
    final jsonString = sharedPreferences.getString('dataList') ?? '';

    if (jsonString.isNotEmpty) {
      try {
        final jsonData = jsonDecode(jsonString) as List<dynamic>;
        setState(() {
          signupList =
              jsonData.map((json) => UserModel.fromJson(json)).toList();
        });
      } catch (e) {
        rethrow;
      }
    }
    signupList.add(
      UserModel(
        id: Uuid().v4().toString(),
        fullname: fullNameController.text,
        email: emailController.text,
        mobilenumber: mobileNumController.text,
        gender: genderList,
        dob: dateController.text,
        password: passwordController.text,
        martialStatus: selectValue,
        image: image!,
      ),
    );
    List<Map<String, dynamic>> jsonDataList =
        signupList.map((cv) => cv.toJson()).toList();
    // print(signupList);
    loginEmptyList[emailController.text] = jsonDataList;
    String jsonData = json.encode(jsonDataList);
    sharedPreferences.setString('dataList', jsonData);

    // ignore: use_build_context_synchronously
    Navigator.pushReplacement(
      context,
      MaterialPageRoute(
        builder: (context) => const login(),
      ),
    );

    // ignore: use_build_context_synchronously
    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(
        content: Center(
          child: Text(
            'Data Added Sucessfully',
          ),
        ),
        backgroundColor: Colors.blue,
      ),
    );
    // print(jsonData);
    //
  }

  final fmkey = GlobalKey<FormState>();
  TextEditingController fullNameController = TextEditingController();
  TextEditingController emailController = TextEditingController();
  TextEditingController mobileNumController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  TextEditingController dateController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        backgroundColor: Colors.grey.shade200,
        appBar: AppBar(
          toolbarHeight: 45.0,
          title: Text(
            "Sign Up Page",
            style: TextStyle(
              fontSize: 18,
              fontWeight: FontWeight.w500,
            ),
          ),
        ),
        body: SingleChildScrollView(
          child: Form(
            key: fmkey,
            child: Padding(
              padding: const EdgeInsets.all(12.0),
              child: Column(
                children: [
                  Padding(
                    padding: const EdgeInsets.all(4.0),
                    child: Align(
                      alignment: Alignment.center,
                      child: Text(
                        "User Sign-Up",
                        style: TextStyle(
                          fontWeight: FontWeight.w400,
                          fontSize: 25,
                        ),
                      ),
                    ),
                  ),
                  Stack(
                    children: [
                      Container(
                        height: 125,
                        width: 125,
                        decoration: BoxDecoration(
                          shape: BoxShape.circle,
                          color: Colors.grey.shade300,
                        ),
                        child: Center(
                          // Center the Text widget here
                          child: image == null
                              ? GestureDetector(
                                  child: Text(
                                    "No image Selected",
                                    style: TextStyle(
                                        fontSize: 12.5,
                                        fontWeight: FontWeight.w400),
                                  ),
                                  onTap: () {
                                    showModalBottomSheet(
                                      context: context,
                                      builder: (context) => buttonSheet(),
                                    );
                                  },
                                )
                              : CircleAvatar(
                                  backgroundColor: Colors.blue.shade200,
                                  radius: 57,
                                  backgroundImage: FileImage(image!),
                                ),
                        ),
                      ),
                      Positioned(
                        bottom: 2,
                        right: 40,
                        child: IconButton(
                          onPressed: () {
                            showModalBottomSheet(
                              context: context,
                              builder: (context) => buttonSheet(),
                            );
                          },
                          icon: Icon(
                            Icons.camera_alt_outlined,
                            size: 35,
                          ),
                        ),
                      )
                    ],
                  ),
                  Column(
                    children: [
                      SizedBox(
                        height: 20,
                      ),
                      TextFormField(
                        controller: fullNameController,
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return "Enter User Name";
                          } else if (RegExp(r'[^a-zA-Z ]').hasMatch(value)) {
                            return 'No Numbers In User Name';
                          }
                          return null;
                        },
                        decoration: InputDecoration(
                          labelText: "User Full Name",
                          hintText: "Enter Your Name",
                          labelStyle: TextStyle(
                              color: Colors.grey.shade600,
                              fontWeight: FontWeight.w300),
                          enabledBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(16),
                            borderSide:
                                BorderSide(color: Colors.green.shade200),
                          ),
                          focusedBorder: OutlineInputBorder(
                            borderSide:
                                BorderSide(color: Colors.green.shade900),
                          ),
                        ),
                      ),
                      SizedBox(
                        height: 15,
                      ),
                      TextFormField(
                        controller: emailController,
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
                              color: Colors.green.shade200,
                            ),
                          ),
                          focusedBorder: OutlineInputBorder(
                            borderSide:
                                BorderSide(color: Colors.green.shade900),
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
                        height: 15,
                      ),
                      TextFormField(
                        controller: passwordController,
                        obscureText: visible,
                        obscuringCharacter: "*",
                        decoration: InputDecoration(
                            suffixIcon: GestureDetector(
                              onTap: () {
                                setState(() {
                                  visible = !visible;
                                });
                              },
                              child: Icon(
                                visible
                                    ? Icons.visibility_off
                                    : Icons.visibility,
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
                                color: Colors.green.shade200,
                              ),
                            ),
                            focusedBorder: OutlineInputBorder(
                                borderSide: BorderSide(
                              color: Colors.green.shade900,
                            ))),
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
                        height: 15,
                      ),
                      TextFormField(
                        controller: mobileNumController,
                        keyboardType: TextInputType.number,
                        decoration: InputDecoration(
                          hintText: "Enter Mobile Number",
                          labelText: "Mobile Number",
                          labelStyle: TextStyle(
                            color: Colors.grey.shade600,
                            fontWeight: FontWeight.w300,
                          ),
                          enabledBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(16),
                            borderSide:
                                BorderSide(color: Colors.green.shade200),
                          ),
                          focusedBorder: OutlineInputBorder(
                            borderSide:
                                BorderSide(color: Colors.green.shade900),
                          ),
                        ),
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return "Enter Mobile Number";
                          } else if (!RegExp(r'^\d{10}$').hasMatch(value)) {
                            return "Invalid! Mobile number should be 10 Digits";
                          }
                          return null;
                        },
                      ),
                      SizedBox(
                        height: 15,
                      ),
                      Column(
                        children: [
                          TextFormField(
                            validator: (value) {
                              if (value!.isEmpty) {
                                return 'Choose Date';
                              }
                              return null;
                            },
                            controller: dateController,
                            decoration: InputDecoration(
                              hintText: 'Select your correct date of birth',
                              border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(15),
                              ),
                              prefixIcon: const Icon(
                                Icons.calendar_today,
                                color: Colors.black54,
                              ),
                              labelText: "Date Of Birth",
                              labelStyle:
                                  const TextStyle(color: Colors.blueGrey),
                            ),
                            readOnly: true,
                            onTap: () async {
                              DateTime? pickedDate = await showDatePicker(
                                context: context,
                                initialDate: DateTime.now(),
                                firstDate: DateTime(1980),
                                lastDate: DateTime.now(),
                              );
                              if (pickedDate != null) {
                                String formattedDate =
                                    DateFormat('yyyy-MM-dd').format(pickedDate);
                                setState(
                                  () {
                                    dateController.text = formattedDate;
                                  },
                                );
                              }
                            },
                          ),
                        ],
                      ),
                      SizedBox(
                        height: 10,
                      ),
                      RadioBox(
                        callback: (String? value) {
                          genderList = value!;
                        },
                      ),
                      //
                      Padding(
                        padding: const EdgeInsets.all(10.0),
                        child: Row(
                          crossAxisAlignment: CrossAxisAlignment
                              .center, // Align elements vertically
                          children: [
                            Text(
                              'Select Marital Status: \t',
                              style: TextStyle(
                                  fontSize: 17, color: Colors.grey.shade700),
                            ),
                            SizedBox(width: 10),
                            DropdownButton<String>(
                              value: selectValue,
                              icon: const Icon(
                                Icons.keyboard_arrow_down,
                                color: Colors.orange,
                              ),
                              onChanged: (newValue) {
                                setState(() {
                                  selectValue = newValue!;
                                });
                              },
                              items: dropdownItem.map((String item) {
                                return DropdownMenuItem<String>(
                                  value: item,
                                  child: Text(item),
                                );
                              }).toList(),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                  ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      elevation: 2,
                      backgroundColor: Colors.green.shade400,
                      fixedSize: Size(130, 45),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(10),
                      ),
                    ),
                    onPressed: () {
                      if (fmkey.currentState!.validate()) {
                        setState(() {
                          try {
                            // ignore: unused_local_variable
                            UserModel user = usersDataList.firstWhere(
                                (user) => user.email == emailController.text);
                            ScaffoldMessenger.of(context)
                                .showSnackBar(const SnackBar(
                              content: Center(child: Text('Email already use')),
                              backgroundColor: Colors.red,
                            ));

                            return;
                          } catch (e) {
                            signUp();
                            return;
                          }
                        });
                        // print("Log IN");
                      }
                      // _registerUser();
                    },
                    child: Text(
                      "Sign In",
                      style:
                          TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
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
                          Navigator.pushReplacement(
                            context,
                            MaterialPageRoute(
                              builder: (context) => login(),
                            ),
                          );
                        },
                        child: Text.rich(
                          TextSpan(
                            text: "Already a user?",
                            style: TextStyle(
                              fontWeight: FontWeight.w500,
                              fontSize: 20,
                            ),
                            children: [
                              TextSpan(
                                text: "\t LogIn",
                                style: TextStyle(
                                  fontWeight: FontWeight.w700,
                                  fontSize: 22,
                                  color: Colors.red.shade500,
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

  Widget buttonSheet() {
    return Container(
      height: 200,
      width: double.infinity,
      margin: const EdgeInsets.symmetric(horizontal: 10, vertical: 20),
      child: Column(
        children: [
          const SizedBox(height: 20),
          const Text('Choose Profile Picture'),
          const SizedBox(height: 20),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const Icon(Icons.camera),
              const SizedBox(width: 5),
              ElevatedButton(
                onPressed: () {
                  takePhoto(ImageSource.camera);
                },
                child: const Text('Camera'),
              ),
              const SizedBox(width: 20),
              const Icon(Icons.photo),
              const SizedBox(width: 5),
              ElevatedButton(
                onPressed: () {
                  takePhoto(ImageSource.gallery);
                },
                child: const Text('Gallery'),
              ),
            ],
          )
        ],
      ),
    );
  }
}
