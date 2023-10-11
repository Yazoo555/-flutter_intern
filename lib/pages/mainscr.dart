import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:google_nav_bar/google_nav_bar.dart';
import 'package:social_app/Model/user_Model.dart';
import 'package:social_app/Screens/homescrn.dart';
import 'package:social_app/Screens/marketscrn.dart';
import 'package:social_app/User_Profile/profilescrn.dart';
import 'package:social_app/frends/friendscr.dart';
import 'package:social_app/pages/signup.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

List<UserModel> usersData = [];

class MainScreen extends StatefulWidget {
  const MainScreen({
    super.key,
  });
  @override
  State<MainScreen> createState() => _MainScreenState();
}

class _MainScreenState extends State<MainScreen> {
  int index = 0;
  List<Widget> screens = [];

  Future<void> getUserData() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String? jsonData = prefs.getString('dataList');
    // print("JsonData:::${jsonData}");

    if (jsonData != null) {
      try {
        final decodedData = json.decode(jsonData) as List<dynamic>;

        setState(
          () {
            usersData = decodedData.map((e) => UserModel.fromJson(e)).toList();
            screens = [
              HomeScreen(
                usersData: usersData,
              ), // index -> 0
              FriendScreen(), // index -> 1
              MarketScreen(), // index -> 2
              ProfileScreen(), // index -> 3
            ];
          },
        );
      } catch (e) {
        rethrow;
      }
    }
  }

  @override
  void initState() {
    super.initState();
    getUserData().then((_) {
      // print("usersData:::${usersData}");
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      bottomNavigationBar: Container(
        color: Colors.grey.shade300,
        child: Padding(
          padding: const EdgeInsets.symmetric(
            horizontal: 8,
            vertical: 4,
          ),
          child: GNav(
            color: Colors.black87,
            backgroundColor: Colors.grey.shade300,
            activeColor: Colors.white,
            tabBackgroundColor: Colors.grey.shade800,
            gap: 10,
            onTabChange: (selectedindex) {
              setState(() {
                index = selectedindex;
              });
            },
            padding: EdgeInsets.all(14),
            tabs: [
              GButton(
                icon: FaIcon(FontAwesomeIcons.house).icon!,
                text: 'Home',
              ),
              GButton(
                icon: FaIcon(FontAwesomeIcons.users).icon!,
                text: 'Freinds',
              ),
              GButton(
                icon: FaIcon(FontAwesomeIcons.store).icon!,
                text: 'Market-place',
              ),
              GButton(
                icon: FaIcon(FontAwesomeIcons.idBadge).icon!,
                text: 'Profile',
              ),
            ],
          ),
        ),
      ),
      body: Container(
        child: getSelectedWidget(index: index),
      ),
    );
  }

  Widget getSelectedWidget({required int index}) {
    if (index >= 0 && index < screens.length) {
      //  print(index);
      return screens[index];
    } else {
      return Container();
      //   throw ArgumentError('Invalid index');
    }
  }
}
