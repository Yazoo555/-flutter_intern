import 'package:flutter/material.dart';
import 'package:flutter_internn/day_3/day_three_task.dart';
import 'package:flutter_internn/day_4/day_4_tab.dart';
import 'package:flutter_internn/day_4/navigated_page.dart';
import 'package:flutter_internn/day_one_screen.dart';

class DayFourTask extends StatelessWidget {
  const DayFourTask({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    List<String> tabTitle = [
      'Day Two',
      'Day Three',
      'Day Four',
    ];
    return DefaultTabController(
      length: 3,
      child: Scaffold(
        appBar: AppBar(
          title: Text("Assessment 4"),
          centerTitle: true,
          elevation: 0,
          actions: [
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: GestureDetector(
                child: Icon(
                  Icons.navigate_next_rounded,
                  size: 40,
                ),
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => NavigatedPage(),
                    ),
                  );
                },
              ),
            ),
          ],
          bottom: TabBar(
            tabs: [
              Tab(
                icon: Icon(Icons.emoji_events_sharp),
                text: tabTitle[0],
              ),
              Tab(
                icon: Icon(Icons.theaters_rounded),
                text: tabTitle[1],
              ),
              Tab(
                icon: Icon(Icons.clear_all),
                text: tabTitle[2],
              )
            ],
          ),
        ),
        body: TabBarView(children: [
          DayOneScreen(),
          DayThreeTask(),
          DayFourTab(),
        ]),
      ),
    );
  }
}
