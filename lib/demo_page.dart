import 'package:flutter/material.dart';
import 'dart:ui';

class DemoPage extends StatefulWidget {
  int counts = 1;
  DemoPage({Key? key}) : super(key: key);

  @override
  State<DemoPage> createState() => _DemoPageState();
}

class _DemoPageState extends State<DemoPage> {
  TextEditingController namecontrol = TextEditingController();
  int _count = 0;
  String name = "";
  String data = "Did change dependencies";
  int get count => _count;
  @override
  void initState() {
    name = "Ram Gurung";
    super.initState();
  }

  @override
  void dispose() {
    namecontrol.dispose();
    super.dispose();
  }

  @override
  void didChangeDependencies() {
    data = "Upadated did change data dependencies";
    setState(() {});
    super.didChangeDependencies();
  }

  @override
  void didUpdateWidget(DemoPage oldWidget) {
    if (oldWidget.counts != count) {
      print("Updated widget:$count");
    }
    super.didUpdateWidget(oldWidget);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Demo Page"),
        centerTitle: true,
        elevation: 0,
        backgroundColor: Colors.black,
      ),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text("Count Number:"),
              Text(" $count"),
            ],
          ),
          ElevatedButton(
            onPressed: () {
              setState(() {
                _count++;
              });
            },
            child: Text("Increase count"),
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text("Name: "),
              Text(name),
            ],
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: TextField(
              controller: namecontrol,
              decoration: InputDecoration(
                hintText: "Enter name",
                enabledBorder: OutlineInputBorder(
                  borderSide: BorderSide(color: Colors.black),
                ),
                focusedBorder: OutlineInputBorder(
                  borderSide: BorderSide(color: Colors.black),
                ),
              ),
            ),
          ),
          ElevatedButton(
            onPressed: () {
              setState(() {
                name = namecontrol.text.toString();
              });
            },
            child: Text("Update Name"),
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [Text("didChangeDependencies text:\n $data")],
          )
        ],
      ),
    );
  }
}
