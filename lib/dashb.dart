import 'package:flutter/material.dart';
import 'package:day_seven/model.dart';
import 'dart:io'; // Import your Usermodel class

class Dashboard extends StatefulWidget {
  final Usermodel userData;

  const Dashboard({required this.userData, Key? key}) : super(key: key);

  @override
  State<Dashboard> createState() => _DashboardState();
}

class _DashboardState extends State<Dashboard> {
  File? imageFile;
  File? image2File;

  @override
  void initState() {
    super.initState();
    // Load the user's images as File objects
    imageFile =
        widget.userData.image != null ? File(widget.userData.image!) : null;
    image2File =
        widget.userData.image2 != null ? File(widget.userData.image2!) : null;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("This is Dashboard"),
      ),
      body: Center(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            children: [
              Text(
                "Welcome to Dashboard: ${widget.userData.fullname}",
                style:
                    const TextStyle(fontSize: 30, fontWeight: FontWeight.bold),
              ),
              const SizedBox(height: 15),
              //
              if (imageFile != null)
                Image.file(
                  imageFile!,
                  width: 200,
                  height: 200,
                ),
              if (image2File != null)
                Image.file(
                  image2File!,
                  width: 200,
                  height: 200,
                ),
//
              Text(
                "Full Name: ${widget.userData.fullname}",
                style: const TextStyle(fontSize: 18),
              ),
              Text(
                "Email: ${widget.userData.email}",
                style: const TextStyle(fontSize: 18),
              ),
              Text(
                "Date of Birth: ${widget.userData.dateofbirth}",
                style: const TextStyle(fontSize: 18),
              ),
              Text(
                "Gender: ${widget.userData.gender}",
                style: const TextStyle(fontSize: 18),
              ),
              Text(
                "Mobile Number: ${widget.userData.mobilenumber}",
                style: const TextStyle(fontSize: 18),
              ),
              Text(
                "Marital Status: ${widget.userData.martialstatus}",
                style: const TextStyle(fontSize: 18),
              ),
              // Add more fields as needed
            ],
          ),
        ),
      ),
    );
  }
}
