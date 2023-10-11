import 'package:flutter/material.dart';
import 'package:social_app/frends/FriendDetails.dart';
import 'package:social_app/frends/searchfren.dart';

class FriendScreen extends StatefulWidget {
  const FriendScreen({
    super.key,
  });

  @override
  State<FriendScreen> createState() => _FriendScreenState();
}

class _FriendScreenState extends State<FriendScreen> {
  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 2,
      child: Scaffold(
        appBar: AppBar(
          toolbarHeight: 42,
          title: Text("Friend Screen"),
        ),
        body: Column(
          children: const [
            TabBar(
              tabs: [
                Tab(
                  icon: Icon(
                    Icons.home,
                    color: Colors.purple,
                  ),
                ),
                Tab(
                  icon: Icon(
                    Icons.search,
                    color: Colors.green,
                  ),
                ),
/*
                Tab(
                  icon: Icon(
                    Icons.person_3,
                    color: Colors.red,
                  ),
                ),
*/
              ],
              // Handle tab selection
            ),
            Expanded(
              child: TabBarView(
                children: [
                  FriendDetails(),
                  CustomSearchDelegateWidget(),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
