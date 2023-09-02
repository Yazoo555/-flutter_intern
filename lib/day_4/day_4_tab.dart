import 'package:flutter/material.dart';

class DayFourTab extends StatefulWidget {
  const DayFourTab({Key? key}) : super(key: key);

  @override
  State<DayFourTab> createState() => _DayFourTabState();
}

class _DayFourTabState extends State<DayFourTab> {
  bool showAllList = false;
  List<Map<String, dynamic>> gridList = [
    {
      'text': 'First Grid',
      'imageUrl':
          'https://t3.ftcdn.net/jpg/05/99/53/58/360_F_599535831_pwQFVG0qtf6ksLXeVTnUwFMvoW5H0WiS.jpg'
    },
    {
      'text': 'Second Grid',
      'imageUrl':
          'https://docs.flutter.dev/assets/images/dash/dash-fainting.gif'
    },
    {
      'text': 'Third Grid',
      'imageUrl':
          'https://t3.ftcdn.net/jpg/05/99/53/58/360_F_599535831_pwQFVG0qtf6ksLXeVTnUwFMvoW5H0WiS.jpg'
    },
    {
      'text': 'Fourth Grid',
      'imageUrl':
          'https://docs.flutter.dev/assets/images/dash/dash-fainting.gif'
    },
    {
      'text': 'Fifth Grid',
      'imageUrl':
          'https://docs.flutter.dev/assets/images/dash/dash-fainting.gif'
    },
    {
      'text': 'Sixth Grid',
      'imageUrl':
          'https://t3.ftcdn.net/jpg/05/99/53/58/360_F_599535831_pwQFVG0qtf6ksLXeVTnUwFMvoW5H0WiS.jpg'
    },
    {
      'text': 'Seventh Grid',
      'imageUrl':
          'https://docs.flutter.dev/assets/images/dash/dash-fainting.gif'
    },
    {
      'text': 'Eighth Grid',
      'imageUrl':
          'https://t3.ftcdn.net/jpg/05/99/53/58/360_F_599535831_pwQFVG0qtf6ksLXeVTnUwFMvoW5H0WiS.jpg'
    },
    {
      'text': 'Ninth Grid',
      'imageUrl':
          'https://docs.flutter.dev/assets/images/dash/dash-fainting.gif'
    },
    {
      'text': 'Tenth Grid',
      'imageUrl':
          'https://t3.ftcdn.net/jpg/05/99/53/58/360_F_599535831_pwQFVG0qtf6ksLXeVTnUwFMvoW5H0WiS.jpg'
    },
    {
      'text': 'Eleventh Grid',
      'imageUrl':
          'https://t3.ftcdn.net/jpg/05/99/53/58/360_F_599535831_pwQFVG0qtf6ksLXeVTnUwFMvoW5H0WiS.jpg'
    },
    {
      'text': 'Twelveth Grid',
      'imageUrl':
          'https://docs.flutter.dev/assets/images/dash/dash-fainting.gif'
    },
    {
      'text': '13th Grid',
      'imageUrl':
          'https://t3.ftcdn.net/jpg/05/99/53/58/360_F_599535831_pwQFVG0qtf6ksLXeVTnUwFMvoW5H0WiS.jpg'
    },
    {
      'text': '14th Grid',
      'imageUrl':
          'https://docs.flutter.dev/assets/images/dash/dash-fainting.gif'
    },
    {
      'text': '15th Grid',
      'imageUrl':
          'https://docs.flutter.dev/assets/images/dash/dash-fainting.gif'
    },
    {
      'text': '16th Grid',
      'imageUrl':
          'https://t3.ftcdn.net/jpg/05/99/53/58/360_F_599535831_pwQFVG0qtf6ksLXeVTnUwFMvoW5H0WiS.jpg'
    },
    {
      'text': '17th Grid',
      'imageUrl':
          'https://docs.flutter.dev/assets/images/dash/dash-fainting.gif'
    },
    {
      'text': '18th Grid',
      'imageUrl':
          'https://t3.ftcdn.net/jpg/05/99/53/58/360_F_599535831_pwQFVG0qtf6ksLXeVTnUwFMvoW5H0WiS.jpg'
    },
    {
      'text': '19th Grid',
      'imageUrl':
          'https://docs.flutter.dev/assets/images/dash/dash-fainting.gif'
    },
    {
      'text': '20th Grid',
      'imageUrl':
          'https://t3.ftcdn.net/jpg/05/99/53/58/360_F_599535831_pwQFVG0qtf6ksLXeVTnUwFMvoW5H0WiS.jpg'
    },
  ];
  List<Color> colorList = [];
  @override
  void initState() {
    colorRecursion();
    super.initState();
  }

  void colorRecursion() {
    int requiredColor = 20;
    while (colorList.length < requiredColor) {
      colorList.addAll([
        Colors.purple,
        Colors.black45,
        Colors.cyan,
        Colors.yellow,
        Colors.teal,
      ]);
    }
    colorList = colorList.sublist(0, requiredColor);
  }

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Container(
        margin: const EdgeInsets.all(6.0),
        decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(10.0),
            boxShadow: [
              BoxShadow(
                color: Colors.black,
                blurRadius: 4.0,
                blurStyle: BlurStyle.outer,
              )
            ]),
        child: Column(
          children: [
            Text("Title:GridView Builder"),
            Text("Subtitle: Gridview Containing text and network image"),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text("Date: July 21, 2023"),
                const SizedBox(
                  width: 20,
                ),
                Text("Time: 10:00 A.M."),
              ],
            ),
            Container(
              height: 350,
              child: GridView.builder(
                padding: EdgeInsets.all(2.0),
                shrinkWrap: true,
                gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 2),
                itemCount: showAllList ? gridList.length : 10,
                itemBuilder: (context, index) {
                  Map<String, dynamic> lists = gridList[index];
                  return Padding(
                    padding: const EdgeInsets.all(4.0),
                    child: Container(
                        color: colorList[index],
                        child: Column(
                          children: [
                            SizedBox(
                              height: 80,
                              width: 80,
                              child: Image.network(
                                lists['imageUrl'],
                                fit: BoxFit.contain,
                              ),
                            ),
                            Text(lists['text']),
                          ],
                        )),
                  );
                },
              ),
            ),
            ElevatedButton(
              onPressed: () {
                setState(() {
                  if (showAllList == false) {
                    showAllList = true;
                  } else {
                    showAllList = false;
                  }
                });
              },
              child: Text(showAllList ? "Show Less" : "Show More"),
            ),
            const SizedBox(
              height: 10,
            ),
            Divider(
              color: Colors.black,
              thickness: 10.0,
            ),
            Container(
              height: 232,
              child: GridView.count(
                  crossAxisCount: 3,
                  shrinkWrap: true,
                  padding: EdgeInsets.all(4.0),
                  mainAxisSpacing: 4.0,
                  crossAxisSpacing: 4.0,
                  children: [
                    Container(
                      child: Image.network(
                          "https://t3.ftcdn.net/jpg/05/99/53/58/360_F_599535831_pwQFVG0qtf6ksLXeVTnUwFMvoW5H0WiS.jpg"),
                    ),
                    Container(
                      child: Image.network(
                          "https://t3.ftcdn.net/jpg/05/99/53/58/360_F_599535831_pwQFVG0qtf6ksLXeVTnUwFMvoW5H0WiS.jpg"),
                    ),
                    Container(
                      child: Image.network(
                          "https://t3.ftcdn.net/jpg/05/99/53/58/360_F_599535831_pwQFVG0qtf6ksLXeVTnUwFMvoW5H0WiS.jpg"),
                    ),
                    Container(
                      child: Image.network(
                          "https://t3.ftcdn.net/jpg/05/99/53/58/360_F_599535831_pwQFVG0qtf6ksLXeVTnUwFMvoW5H0WiS.jpg"),
                    ),
                    Container(
                      child: Image.network(
                          "https://t3.ftcdn.net/jpg/05/99/53/58/360_F_599535831_pwQFVG0qtf6ksLXeVTnUwFMvoW5H0WiS.jpg"),
                    ),
                    Container(
                      child: Image.network(
                          "https://t3.ftcdn.net/jpg/05/99/53/58/360_F_599535831_pwQFVG0qtf6ksLXeVTnUwFMvoW5H0WiS.jpg"),
                    ),
                    Container(
                      child: Image.network(
                          "https://t3.ftcdn.net/jpg/05/99/53/58/360_F_599535831_pwQFVG0qtf6ksLXeVTnUwFMvoW5H0WiS.jpg"),
                    ),
                  ]),
            )
          ],
        ),
      ),
    );
  }
}
