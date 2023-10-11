import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:social_app/Model/userFriendListModel.dart';
import 'package:social_app/Model/user_Model.dart';
import 'package:social_app/Screens/homescrn.dart';
import 'package:social_app/pages/mainscr.dart';
import 'package:social_app/pages/signup.dart';
import 'package:uuid/uuid.dart';

// ignore: camel_case_types
class seeuserpro extends StatefulWidget {
  final String id;
  const seeuserpro({super.key, required this.id});

  @override
  State<seeuserpro> createState() => _seeuserproState();
}

// ignore: camel_case_types
class _seeuserproState extends State<seeuserpro> {
  UserModel? friendkoDetails;

  getUsersDetails() {
    try {
      friendkoDetails = usersData.firstWhere((e) => e.id == widget.id);
    } catch (e) {
      rethrow;
    }
  }

  var indexOfIt = -1;
  @override
  void initState() {
    super.initState();
    getUsersDetails();
    getUserData();
    getUserId();
    compare();
  }

  Future<List<String>> getUserId() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String? userIdData = prefs.getString('profileId');

    if (userIdData != null) {
      try {
        friendkoDetails =
            usersData.firstWhere((user) => user.id.toString() == userIdData);
        print('===friend id: ${friendkoDetails?.fullname}');
      } catch (e) {
        print(e);
      }
    } else {
      friendkoDetails;
    }
    return [];
  }

  Future<void> compare() async {
    if (request.isNotEmpty) {
      indexOfIt = request.indexWhere((e) =>
          e.friendId == friendkoDetails!.id &&
          e.requestedBy == loginUsers!.id &&
          e.userId == loginUsers!.id);
    } else {
      indexOfIt = -1;
    }

    setState(() async {
      if (indexOfIt != -1) {
        requestAcceptOrCancle.removeAt(indexOfIt);
        String update = jsonEncode(requestAcceptOrCancle);
        SharedPreferences prefs = await SharedPreferences.getInstance();
        prefs.setString('request', update);
        getUserData();
      } else {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text("No friend request exists for this user."),
            duration: Duration(seconds: 2),
          ),
        );
      }
    });
  }

  List<UserFriendListModel> request = [];
  Future<List<String>> getUserData() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String? jsonData = prefs.getString('request');
    print(jsonData);

    if (jsonData != null) {
      try {
        final decodedData = json.decode(jsonData) as List<dynamic>;

        setState(() {
          request =
              decodedData.map((e) => UserFriendListModel.fromJson(e)).toList();
        });
        indexOfIt = request.indexWhere((e) =>
            e.friendId == friendkoDetails!.id &&
            e.requestedBy == loginUsers!.id &&
            e.userId == loginUsers!.id);
      } catch (e) {
        rethrow;
      }
    } else {
      request = [];
    }
    return [];
  }

  Future<void> sendRequest() async {
    SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
    requestAcceptOrCancle.add(
      UserFriendListModel(
        user_list_id: const Uuid().v4(),
        createdAt: DateTime.now().toString(),
        hasNewRequest: true,
        friendId: friendkoDetails!.id!,
        userId: loginUsers!.id!,
        hasNewRequestAccepted: false,
        requestedBy: loginUsers!.id!,
        hasRemoved: false,
      ),
    );
    List<Map<String, dynamic>> jsonDataList =
        requestAcceptOrCancle.map((add) => add.toJson()).toList();

    String jsonData = json.encode(jsonDataList);
    print('===new data $jsonData');

    sharedPreferences.setString('request', jsonData);
    getUserData();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          onPressed: () {
            Navigator.of(context).pop();
          },
          icon: Icon(Icons.arrow_back_ios_new),
        ),
        title: Text(
          "${friendkoDetails!.fullname}'s Profile",
          style: GoogleFonts.prompt(
            fontSize: 22,
            color: Colors.black87,
            fontWeight: FontWeight.w500,
          ),
        ),
      ),
      body: Center(
        child: Padding(
          padding: const EdgeInsets.all(12.0),
          child: SingleChildScrollView(
            child: Column(
              children: [
                Positioned(
                  left: 120,
                  bottom: 0,
                  child: Container(
                    decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      border:
                          Border.all(width: 6.0, color: Colors.green.shade300),
                    ),
                    child: ClipOval(
                      child: friendkoDetails?.image?.path != ""
                          ? Image(
                              height: 120,
                              width: 120,
                              image: FileImage(friendkoDetails!.image!),
                              fit: BoxFit.cover,
                            )
                          : Image(
                              height: 120,
                              width: 120,
                              fit: BoxFit.cover,
                              image: AssetImage('${friendkoDetails?.imageUrl}'),
                            ),
                    ),
                  ),
                ),
                SizedBox(
                  height: 5,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    ElevatedButton(
                      onPressed: () async {
                        if (indexOfIt != -1) {
                          print('Before cancellation: $requestAcceptOrCancle');
                          requestAcceptOrCancle.removeAt(indexOfIt);
                          print('After cancellation: $requestAcceptOrCancle');
                          String update = jsonEncode(requestAcceptOrCancle);
                          SharedPreferences prefs =
                              await SharedPreferences.getInstance();
                          prefs.setString('request', update);
                          getUserData();
                          setState(
                            () {
                              indexOfIt = -1;
                            },
                          );
                        } else {
                          sendRequest();
                          setState(() {
                            indexOfIt = 1;
                          });
                        }
                      },
                      child: Row(
                        children: [
                          Icon(indexOfIt != -1
                              ? Icons.cancel
                              : Icons.person_add_alt_1),
                          const SizedBox(width: 8),
                          Text(indexOfIt != -1
                              ? 'Cancel Request'
                              : 'Add Friend'),
                        ],
                      ),
                    ),
                    //
                    ElevatedButton(
                      onPressed: () {
                        setState(
                          () {
                            ScaffoldMessenger.of(context).showSnackBar(
                              SnackBar(
                                backgroundColor: Colors.blueGrey.shade400,
                                content: Text(
                                  "Sorry, Cannot Send Message.",
                                  style: TextStyle(
                                    fontSize: 17,
                                  ),
                                ),
                                duration: Duration(seconds: 2),
                              ),
                            );
                          },
                        );
                      },
                      child: const Row(
                        children: [
                          Icon(Icons.messenger_outline_outlined),
                          SizedBox(width: 8),
                          Text('Message')
                        ],
                      ),
                    ),
                  ],
                ),
                Divider(
                  thickness: 0.5,
                  color: Colors.black54,
                ),
                Column(
                  children: [
                    friendkoDetails?.fullname != ""
                        ? Text(
                            "Name: ${friendkoDetails!.fullname}",
                            style: GoogleFonts.aBeeZee(
                              fontSize: 20,
                              fontWeight: FontWeight.w300,
                            ),
                          )
                        : Text('No Name'),
                    SizedBox(
                      height: 5,
                    ),
                    friendkoDetails?.email != ""
                        ? Text(
                            "Email: ${friendkoDetails!.email}",
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
                        "${friendkoDetails!.mobilenumber}",
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
                        "${friendkoDetails!.dob}",
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
                          "assets/images/single.png",
                        ),
                      ),
                      title: Text(
                        "${friendkoDetails!.martialStatus}",
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
                        child: Icon(Icons.abc),
                      ),
                      title: Row(
                        children: [
                          SizedBox(
                            width: 8,
                          ),
                          Text(
                            "${friendkoDetails!.gender}",
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
                      height: 15,
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
