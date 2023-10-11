import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:social_app/Screens/homescrn.dart';
import 'package:social_app/User_Profile/addpost.dart';
import 'package:social_app/pages/login.dart';
import 'package:social_app/pages/signup.dart';
// ignore: depend_on_referenced_packages
import 'package:shared_preferences/shared_preferences.dart';

class ProfileScreen extends StatefulWidget {
  const ProfileScreen({
    super.key,
  });
  @override
  State<ProfileScreen> createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  Map<String, String> maritalStatusImages = {
    "Divorced": "assets/images/divorce.png",
    "Married": "assets/images/married.png",
    "Single": "assets/images/single.png",
    "Widowed": "assets/images/widowed.png",
  };

  Map<String, IconData> genderIcons = {
    "Male": Icons.male,
    "Female": Icons.female,
    "Others": Icons.transgender,
  };

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          elevation: 5,
          backgroundColor: Colors.orange.shade50,
          title: Text(
            "${loginUsers!.fullname}'s Profile",
            style: GoogleFonts.prompt(
              fontSize: 21,
              color: Colors.black87,
              fontWeight: FontWeight.w600,
            ),
          ),
          iconTheme: IconThemeData(color: Colors.black87),
        ),
        body: SingleChildScrollView(
          child: Center(
            child: Container(
              color: Colors.orange.shade50,
              child: Column(
                children: [
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Text(
                      "Profile Details",
                      style: GoogleFonts.anekKannada(
                        fontSize: 30,
                        fontWeight: FontWeight.w400,
                      ),
                    ),
                  ),
                  Positioned(
                    left: 120,
                    bottom: 0,
                    child: Container(
                      decoration: BoxDecoration(
                        shape: BoxShape.circle,
                        border: Border.all(
                            width: 6.0, color: Colors.green.shade300),
                      ),
                      child: ClipOval(
                        child: loginUsers?.image?.path != ""
                            ? Image(
                                height: 120,
                                width: 120,
                                image: FileImage(loginUsers!.image!),
                                fit: BoxFit.cover,
                              )
                            : Image(
                                height: 120,
                                width: 120,
                                fit: BoxFit.cover,
                                image: AssetImage('${loginUsers?.imageUrl}'),
                              ),
                      ),
                    ),
                  ),
                  SizedBox(
                    height: 5,
                  ),
                  Divider(
                    thickness: 0.5,
                    color: Colors.black54,
                  ),
                  Column(
                    children: [
                      loginUsers?.fullname != ""
                          ? Text(
                              "Name: ${loginUsers!.fullname}",
                              style: GoogleFonts.aBeeZee(
                                fontSize: 20,
                                fontWeight: FontWeight.w300,
                              ),
                            )
                          : Text('No Name'),
                      SizedBox(
                        height: 5,
                      ),
                      loginUsers?.email != ""
                          ? Text(
                              "Email: ${loginUsers!.email}",
                              style: GoogleFonts.aBeeZee(
                                fontSize: 20,
                                fontWeight: FontWeight.w300,
                              ),
                            )
                          : Text("No Email"),
                      SizedBox(
                        height: 5,
                      ),
                      Padding(
                        padding: const EdgeInsets.only(left: 22),
                        child: Row(
                          children: [
                            ElevatedButton(
                              onPressed: () {
                                Navigator.pushReplacement(
                                  context,
                                  MaterialPageRoute(
                                    builder: (context) => AddPost(
                                      loginUsers: loginUsers,
                                    ),
                                  ),
                                );
                              },
                              child: Row(
                                children: const [
                                  Icon(Icons.add),
                                  SizedBox(
                                    width: 8,
                                  ),
                                  Text('Add  Post')
                                ],
                              ),
                            ),
                            SizedBox(
                              width: 55,
                            ),
                            ElevatedButton(
                              onPressed: () {},
                              child: const Row(
                                children: [
                                  Icon(Icons.edit),
                                  SizedBox(width: 8),
                                  Text('Edit Profile')
                                ],
                              ),
                            ),
                            SizedBox(
                              height: 8,
                            ),
                          ],
                        ),
                      ),
                      SizedBox(
                        height: 5,
                      ),
                      Divider(
                        height: 20,
                        thickness: 2,
                      ),
                      Text(
                        "Contact Info",
                        style: TextStyle(
                          fontSize: 20,
                          fontWeight: FontWeight.w400,
                        ),
                      ),
                      ListTile(
                        leading: CircleAvatar(
                          backgroundColor: Colors.lightBlue.shade100,
                          child: Icon(Icons.phone),
                        ),
                        title: Text(
                          "${loginUsers!.mobilenumber}",
                          style: GoogleFonts.aBeeZee(
                            textStyle: TextStyle(
                              fontSize: 16,
                              color: Colors.black,
                            ),
                          ),
                        ),
                      ),
                      SizedBox(
                        height: 5,
                      ),
                      Divider(
                        height: 20,
                        thickness: 2,
                      ),
                      Text(
                        "Date Of Birth",
                        style: TextStyle(
                          fontSize: 20,
                          fontWeight: FontWeight.w400,
                        ),
                      ),
                      ListTile(
                        leading: CircleAvatar(
                          backgroundColor: Colors.orange.shade200,
                          child: Icon(Icons.calendar_month),
                        ),
                        title: Text(
                          "${loginUsers!.dob}",
                          style: GoogleFonts.aBeeZee(
                            textStyle: TextStyle(
                              fontSize: 16, // Adjust the font size as needed
                              color: Colors
                                  .black, // Adjust the text color as needed
                              // Add more text style attributes as needed
                            ),
                          ),
                        ),
                      ),
                      SizedBox(
                        height: 5,
                      ),
                      Divider(
                        height: 20,
                        thickness: 2,
                      ),
                      Text(
                        "Relationship",
                        style: TextStyle(
                          fontSize: 20,
                          fontWeight: FontWeight.w400,
                        ),
                      ),
                      ListTile(
                        leading: CircleAvatar(
                          backgroundColor: Colors.red.shade200,
                          backgroundImage: AssetImage(
                            maritalStatusImages[loginUsers!.martialStatus] ??
                                "assets/images/single.png",
                          ),
                        ),
                        title: Text(
                          "${loginUsers!.martialStatus}",
                          style: GoogleFonts.aBeeZee(
                            textStyle: TextStyle(
                              fontSize: 16,
                              color: Colors.black,
                            ),
                          ),
                        ),
                      ),
                      SizedBox(
                        height: 5,
                      ),
                      Divider(
                        height: 20,
                        thickness: 2,
                      ),
                      Text(
                        "Gender",
                        style: TextStyle(
                          fontSize: 20,
                          fontWeight: FontWeight.w400,
                        ),
                      ),
                      ListTile(
                        leading: CircleAvatar(
                          backgroundColor: Colors.lightGreen.shade200,
                          child: Icon(
                            genderIcons[loginUsers!.gender],
                            color: Colors.black,
                          ),
                        ),
                        title: Row(
                          children: [
                            SizedBox(
                              width: 8,
                            ),
                            Text(
                              "${loginUsers!.gender}",
                              style: GoogleFonts.aBeeZee(
                                textStyle: TextStyle(
                                  fontSize: 16,
                                  color: Colors.black,
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                      SizedBox(
                        height: 5,
                      ),
                      Divider(
                        height: 20,
                        thickness: 2,
                      ),
                      Text(
                        "Work History",
                        style: TextStyle(
                          fontSize: 20,
                          fontWeight: FontWeight.w400,
                        ),
                      ),
                      ListTile(
                        leading: CircleAvatar(
                          backgroundColor: Colors.black54,
                          child: Icon(Icons.work_history),
                        ),
                        title: Text(
                          "Add Work Experiences",
                          style: GoogleFonts.aBeeZee(
                            textStyle: TextStyle(
                              fontSize: 16,
                              color: Colors.black,
                            ),
                          ),
                        ),
                      ),
                      const Divider(
                        height: 10,
                        thickness: 3,
                      ),
                      SizedBox(
                        height: 20,
                      ),
                      SizedBox(
                        height: 45,
                        child: ElevatedButton(
                          style: ElevatedButton.styleFrom(
                            fixedSize: Size(125, 35),
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(12.0),
                            ),
                          ),
                          onPressed: () async {
                            SharedPreferences sharedPerference =
                                await SharedPreferences.getInstance();
                            sharedPerference.remove('email');
                            // ignore: use_build_context_synchronously
                            Navigator.pushReplacement(
                              context,
                              MaterialPageRoute(
                                builder: (context) => login(),
                              ),
                            );
                          },
                          child: const Text(
                            "Logout",
                            style: TextStyle(
                              fontSize: 18,
                            ),
                          ),
                        ),
                      ),
                      SizedBox(
                        height: 15,
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
