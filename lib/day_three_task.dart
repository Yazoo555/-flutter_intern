import 'package:day_3/second_listview.dart';
import 'package:flutter/material.dart';
import 'first_list.dart';

class DayThreeTask extends StatefulWidget {
  const DayThreeTask({super.key});

  @override
  State<DayThreeTask> createState() => _DayThreeTaskState();
}

class _DayThreeTaskState extends State<DayThreeTask> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Day Three- (3) task"),
        backgroundColor: Colors.black54,
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            SizedBox(
              height: 150,
              child: FirstList(),
            ),
            const Padding(
              padding: EdgeInsets.all(2.0),
              child: SizedBox(
                height: 450,
                child: SecondListView(),
              ),
            ),
            SizedBox(
              height: 25,
            ),
            Container(
              height: 150,
              width: 250,
              child: Column(
                children: [
                  //  ThirdListContainer(),
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}
