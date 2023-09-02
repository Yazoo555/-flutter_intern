import 'package:flutter/material.dart';
import 'package:flutter_internn/day_3/first_list.dart';
import 'package:flutter_internn/day_3/second_listview.dart';

class DayThreeTask extends StatefulWidget {
  const DayThreeTask({Key? key}) : super(key: key);

  @override
  State<DayThreeTask> createState() => _DayThreeTaskState();
}

class _DayThreeTaskState extends State<DayThreeTask> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: const Text("Day 3"),
          centerTitle: true,
          backgroundColor: Colors.black,
          elevation: 0,
        ),
        body: SingleChildScrollView(
          child: Column(
            children: [
              const SizedBox(
                height: 180,
                child: FirstList(),
              ),
              const Padding(
                padding: EdgeInsets.all(2.0),
                child: SizedBox(
                  height: 450,
                  child: SecondListView(),
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(4.0),
                child: Container(
                  height: 150,
                  width: 346,
                  decoration: BoxDecoration(
                    border: Border.all(color: Colors.black),
                  ),
                  child: const Column(
                    children: [
                      //   ThirdListContainer(),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ));
  }
}
