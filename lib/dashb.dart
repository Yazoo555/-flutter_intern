import 'package:flutter/material.dart';
import 'package:day_seven/model.dart'; // Import your Usermodel class

class Dashboard extends StatefulWidget {
  final Usermodel userData;

  const Dashboard({required this.userData, Key? key}) : super(key: key);

  @override
  State<Dashboard> createState() => _DashboardState();
}

class _DashboardState extends State<Dashboard> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("This is Dash"),
      ),
      body: Center(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            children: [
              Text(
                "Welcome to Dashboard",
                style: TextStyle(fontSize: 30, fontWeight: FontWeight.bold),
              ),
              SizedBox(height: 20),
              Text("Full Name: ${widget.userData.fullname}"),
              Text("Email: ${widget.userData.email}"),
              Text("Date of Birth: ${widget.userData.dateofbirth}"),
              Text("Gender: ${widget.userData.gender}"),
              Text("Mobile Number: ${widget.userData.mobilenumber}"),
              Text("Marital Status: ${widget.userData.martialstatus}"),
              // Add more fields as needed
            ],
          ),
        ),
      ),
    );
  }
}
