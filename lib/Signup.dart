import 'dart:convert';
import 'dart:io';
import 'package:day_seven/login.dart';
import 'package:image_picker/image_picker.dart';
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
  File? _image;
  File? _image2;

  Future<void> _pickImageFromGallery() async {
    final imagePicker = ImagePicker();
    final pickedImage =
        await imagePicker.pickImage(source: ImageSource.gallery);
    setState(
      () {
        _image = pickedImage != null ? File(pickedImage.path) : null;
      },
    );
  }

  Future<void> _pickImageFromCamera() async {
    final imagePicker = ImagePicker();
    final capturedImage =
        await imagePicker.pickImage(source: ImageSource.camera);

    setState(
      () {
        _image2 = capturedImage != null ? File(capturedImage.path) : null;
      },
    );
  }

  Future<void> signUp() async {
    SharedPreferences sharedPreferences = await SharedPreferences.getInstance();

    final jsonString = sharedPreferences.getString('dataList');
    List<Usermodel> signuplist = [];
    print('User DATA: $jsonString'); // no need of print

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

    // Convert the image paths to strings
    String? imagePath = _image != null ? _image!.path : null;
    String? image2Path = _image2 != null ? _image2!.path : null;

    //
    signuplist.add(
      Usermodel(
          //  image: _image, // Add the image field here
          //  image2: _image2, // Add the image2 field here

          image: _image?.path, // Use the null-aware operator ?.
          image2: _image2?.path,
          fullname: fullname.text,
          userid: const Uuid().v4(),
          email: email.text,
          password: passwordController.text,
          mobilenumber: mobilenumber.text,
          dateofbirth: dateofbirth.text,
          gender: gender,
          martialstatus: selectValue),
    );

    List<Map<String, dynamic>> jsonDataList =
        signuplist.map((cv) => cv.toJson()).toList();

    //  signuplist.map((cv) => cv.toJson()).toList();
    // signuplist.map((cv) => cv.toJson()).toList();

    //

    jsonDataList.add({
      'image': imagePath,
      'image2': image2Path,
    });
    print(signuplist);
    sharedPreferences.setString('dataList', json.encode(jsonDataList));

    loginEmptyList[email.text] = jsonDataList;
    String jsonData = json.encode(jsonDataList);
    sharedPreferences.setString('dataList', jsonData);

    // ignore: use_build_context_synchronously
    Navigator.pushReplacement(
        context, MaterialPageRoute(builder: (context) => const login()));
    setState(() {
      showDialog(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            title: Text("Success"),
            content: Text(
                "User registered successfully!"), // Customize the message as needed
            actions: <Widget>[
              TextButton(
                child: Text("OK"),
                onPressed: () {
                  Navigator.of(context).pop(); // Close the dialog
                },
              ),
            ],
          );
        },
      );
    });
  }

  void _registerUser() async {
    if (Fkey.currentState!.validate()) {
      await signUp();
    }
  }

  @override
  Widget build(BuildContext context) {
    //

    return SafeArea(
      child: Scaffold(
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
                    controller: fullname,
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return "Enter Full Name";
                      } else if (RegExp(r'[^a-zA-Z ]').hasMatch(value)) {
                        return 'Name cannot have numbers';
                      }
                      return null;
                    },
                    decoration: InputDecoration(
                      hintText: "Enter Full Name",
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(14),
                        borderSide: BorderSide(color: Colors.black),
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
                    keyboardType: TextInputType.number,
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
                      Text(
                        "Martial Status",
                        style: TextStyle(
                          fontSize: 16,
                        ),
                      ),
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
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return "Please enter password";
                      } else if (value.length < 8) {
                        return 'Password must be at least 8 characters long';
                      }
                      return null;
                    },
                    obscureText: true,
                    obscuringCharacter: "*",
                    controller: passwordController,
                    decoration: InputDecoration(
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
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        "Upload Image",
                        style: TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                      SizedBox(
                        height: 20,
                      ),
                      _image != null
                          ? Image.file(
                              _image!,
                              width: 200,
                              height: 200,
                            )
                          : Text("No image Selected"),
                      SizedBox(
                        height: 25,
                      ),
                      Align(
                        alignment: Alignment.centerLeft,
                        child: Padding(
                          padding: const EdgeInsets.all(12.0),
                          child: ElevatedButton(
                            style: ElevatedButton.styleFrom(
                              fixedSize: Size(120, 40),
                              backgroundColor:
                                  Colors.purpleAccent.shade700, // Text color
                              elevation: 1, // Button shadow
                              shape: RoundedRectangleBorder(
                                  // Button border radius
                                  ),
                              padding: EdgeInsets.symmetric(
                                  horizontal: 20,
                                  vertical: 10), // Button padding
                            ),
                            onPressed: _pickImageFromGallery,
                            child: Text("Gallery"),
                          ),
                        ),
                      ),
                    ],
                  ),
                  SizedBox(
                    height: 20,
                  ),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[
                      _image2 != null
                          ? Image.file(
                              _image2!,
                              width: 200,
                              height: 200,
                            )
                          : Text("No image Selected"),
                      SizedBox(
                        height: 25,
                      ),
                      Align(
                        alignment: Alignment.centerLeft,
                        child: Padding(
                          padding: const EdgeInsets.all(12.0),
                          child: ElevatedButton(
                            style: ElevatedButton.styleFrom(
                              fixedSize: Size(120, 40),
                              backgroundColor:
                                  Colors.green.shade600, // Text color
                              elevation: 1, // Button shadow
                              shape: RoundedRectangleBorder(
                                  // Button border radius
                                  ),
                              padding: EdgeInsets.symmetric(
                                  horizontal: 20,
                                  vertical: 10), // Button padding
                            ),
                            onPressed: _pickImageFromCamera,
                            child: Text(
                              "Camera",
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                  SizedBox(
                    height: 25,
                  ),
                  Align(
                    alignment: Alignment.center,
                    child: ElevatedButton(
                      style: ElevatedButton.styleFrom(
                          foregroundColor: Colors.white,
                          backgroundColor: Colors.orangeAccent.shade400,
                          fixedSize: Size(110, 50), // Text color
                          padding: EdgeInsets.symmetric(
                              horizontal: 20, vertical: 10),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(12.0),
                          )),
                      onPressed: () {
                        if (Fkey.currentState!.validate()) {
                          setState(
                            () {
                              try {
                                // ignore: unused_local_variable
                                Usermodel users = signuplist.firstWhere(
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
                      child: const Text(
                        "Sign Up",
                        style: TextStyle(
                            fontSize: 18, fontWeight: FontWeight.bold),
                      ),
                    ),
                  ),
                  SizedBox(
                    height: 30,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        "Already have an account:",
                        style: TextStyle(
                            fontSize: 16, fontWeight: FontWeight.w400),
                      ),
                      TextButton(
                        onPressed: () {
                          Navigator.of(context).pop();
                        },
                        child: Text(
                          "Log-In",
                          style: TextStyle(
                              fontSize: 18, fontWeight: FontWeight.bold),
                        ),
                      )
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
