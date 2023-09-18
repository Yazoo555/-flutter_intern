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
        title: const Text("This is Dashboard"),
      ),
      body: Center(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            children: [
              Text(
                "Welcome to Dashboard: ${widget.userData.fullname}",
                style: TextStyle(fontSize: 30, fontWeight: FontWeight.bold),
              ),
              SizedBox(height: 40),
              Text(
                "Full Name: ${widget.userData.fullname}",
                style: TextStyle(fontSize: 18),
              ),
              Text(
                "Email: ${widget.userData.email}",
                style: TextStyle(fontSize: 18),
              ),
              Text(
                "Date of Birth: ${widget.userData.dateofbirth}",
                style: TextStyle(fontSize: 18),
              ),
              Text(
                "Gender: ${widget.userData.gender}",
                style: TextStyle(fontSize: 18),
              ),
              Text(
                "Mobile Number: ${widget.userData.mobilenumber}",
                style: TextStyle(fontSize: 18),
              ),
              Text(
                "Marital Status: ${widget.userData.martialstatus}",
                style: TextStyle(fontSize: 18),
              ),
              // Add more fields as needed
            ],
          ),
        ),
      ),
    );
  }
}
