import 'package:flutter/material.dart';
import 'dart:math';

void main() {
  runApp(myapp());
}

class myapp extends StatelessWidget {
  const myapp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: "Day 2",
      theme: ThemeData(brightness: Brightness.light),
      themeMode: ThemeMode.light,
      home: DayTwo(),
    );
  }
}

class DayTwo extends StatefulWidget {
  const DayTwo({super.key});

  @override
  State<DayTwo> createState() => _DayTwoState();
}

class _DayTwoState extends State<DayTwo> {
  List<Color> colorsList = [
    Colors.red,
    Colors.blue,
    Colors.orangeAccent,
    Colors.greenAccent,
    Colors.black,
  ];

  //List of font sizes
  List<double> fontsizes = [20, 12, 28, 38, 55];

  // List of Button Sizes

  List<Size> buttonSize = [
    Size(150, 50),
    Size(220, 40),
    Size(320, 45),
    Size(450, 55),
  ];

  List<String> eTexts = [
    "Button * Pressed",
    "Pressed - again",
    "Text Changed",
    "Pressed",
  ];

  //List of icons for icon button
  List<Icon> differentIcons = [
    Icon(Icons.man_3_outlined),
    Icon(Icons.phone_android),
    Icon(Icons.food_bank_outlined),
    Icon(Icons.account_balance),
    Icon(Icons.oil_barrel_rounded),
    Icon(Icons.earbuds_battery_outlined),
  ];

  //List of image url

  List<String> imageUrl = [
    "https://media2.giphy.com/media/v1.Y2lkPTc5MGI3NjExZG56a3FpOGQ1bWQ5bW9nMWU0a3BicHhucXk5eHZlcWVvaThjNmVpYSZlcD12MV9pbnRlcm5hbF9naWZfYnlfaWQmY3Q9Zw/xL7PDV9frcudO/giphy.gif"
        "https://media3.giphy.com/media/v1.Y2lkPTc5MGI3NjExanp2bGx5enAwcjRpeWRoY2IwencwMG02aWI0eXB6bXJvMmFvZmt1aCZlcD12MV9pbnRlcm5hbF9naWZfYnlfaWQmY3Q9Zw/l3q2K5jinAlChoCLS/giphy.gif"
        "https://media4.giphy.com/media/9AK6sJLPkdNAM9tPKN/giphy.gif",
    "https://media0.giphy.com/media/REOTLe3gvp1RQcijES/giphy.gif?cid=ecf05e47ybf0eehek7luezvwik3s2ljk6055ulql75ue66ty&ep=v1_gifs_gifId&rid=giphy.gif&ct=g",
  ];

  var random = Random();

// functions for Text button

  Color textColor = Colors.black;

  void changeTextColor() // function to change text color
  {
    textColor = colorsList[random.nextInt(colorsList.length)];
  }

  double firstFontSize = 25;

  void changeFontSize() // function to chang efont size
  {
    firstFontSize = fontsizes[random.nextInt(fontsizes.length)];
  }

// functions for elevated buttons

  Color elevatedButtonColor = Colors.black;
  void changeElevatedButttonColor() {
    elevatedButtonColor = colorsList[random.nextInt(colorsList.length)];
  }

  Size firstSize = Size(230, 50);
  void changeButtonSize() {
    firstSize = buttonSize[random.nextInt(buttonSize.length)];
  }

  double elevatedFontSize = 20.0;
  void changeElevatedFontSize() {
    elevatedFontSize = fontsizes[random.nextInt(fontsizes.length)];
  }

  Color elevatedTextColor = Colors.black12;
  void changeElevatedTextColor() {
    elevatedTextColor = colorsList[random.nextInt(colorsList.length)];
  }

  String defaultText = "Elevated Button";
  changeElevatedButtonChild() {
    defaultText = eTexts[random.nextInt(eTexts.length)];
  }

  // functions for Icon Buttons

  Icon firstIcon = Icon(Icons.power_settings_new);
  void changeIconWithButton() {
    firstIcon = differentIcons[random.nextInt(differentIcons.length)];
  }

  Color firstIconColor = Colors.black54;
  void changeIconColor() {
    firstIconColor = colorsList[random.nextInt(colorsList.length)];
  }

  String firstImage =
      "https://media2.giphy.com/media/l0IymUcxU41kOE9SE/giphy.gif?cid=ecf05e47qit9g6a25dyb048v25423mrss6hm8xqoa0ncuy1c&ep=v1_gifs_search&rid=giphy.gif&ct=g";
  void changeImageWithNetwork() {
    firstImage = imageUrl[random.nextInt(imageUrl.length)];
  }

  int add = 0;
  void _increment() {
    {
      setState(() {
        add++;
      });
    }
  }

  void _decrement() {
    setState(() {
      if (add > 0) {
        add--;
      }
    });
  }

  void _reset() {
    setState(() {
      if (add > 0 || add == 0) {
        add = 0;
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Scaffold(
        appBar: AppBar(
          title: Text("Day Two"),
          centerTitle: true,
          backgroundColor: Colors.grey.shade600,
        ),
        body: SingleChildScrollView(
          child: Center(
            child: Column(
              children: [
                Padding(
                  padding: const EdgeInsets.all(25.0),
                  child: TextButton(
                    onPressed: () {
                      setState(() {
                        changeTextColor();
                        changeFontSize();
                      });
                    },
                    style: TextButton.styleFrom(
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(15),
                        side: BorderSide(color: textColor),
                      ),
                      fixedSize: Size(250, 60),
                    ),
                    child: Text(
                      "Text Button",
                      style:
                          TextStyle(fontSize: firstFontSize, color: textColor),
                    ),
                  ),
                ),
                SizedBox(
                  height: 25,
                  child: Divider(height: 22),
                ),
                ElevatedButton(
                    onPressed: () {
                      setState(() {
                        changeElevatedButttonColor();
                        changeButtonSize();
                        changeElevatedFontSize();
                        changeElevatedTextColor();
                        changeElevatedButtonChild();
                      });
                    },
                    child: Text(
                      defaultText,
                      style: TextStyle(
                          fontSize: elevatedFontSize, color: elevatedTextColor),
                    )),
                SizedBox(
                  height: 25,
                  child: Divider(height: 22),
                ),
                Text(
                  "Counter:?\t\n$add",
                  textScaleFactor: 3,
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    color: Colors.grey.shade700,
                  ),
                ),
                SizedBox(
                  height: 45,
                  child: Divider(height: 22),
                ),
                //
                IconButton(
                  onPressed: () {
                    setState(() {
                      changeIconWithButton();
                      changeIconColor();
                      changeImageWithNetwork();
                    });
                  },
                  icon: firstIcon,
                  color: firstIconColor,
                  iconSize: 55,
                ),

                SizedBox(
                  height: 45,
                  child: Divider(height: 22),
                ),

                Image.network(
                  firstImage,
                  fit: BoxFit.fill,
                ),
                SizedBox(
                  height: 45,
                  child: Divider(height: 22),
                ),

                Image.asset('assets/flutter.jpg')
              ],
            ),
          ),
        ),
        floatingActionButton: Container(
          margin: const EdgeInsets.only(left: 40, bottom: 50),
          child: Row(
            children: [
              Expanded(
                child: Padding(
                  padding: EdgeInsets.only(right: 18.0),
                  child: FloatingActionButton(
                    onPressed: _decrement,
                    child: Icon(
                      Icons.remove,
                    ),
                  ),
                ),
              ),
              Expanded(
                child: FloatingActionButton(
                  onPressed: _reset,
                  child: Icon(
                    Icons.exposure_zero_sharp,
                  ),
                ),
              ),
              Expanded(
                child: FloatingActionButton(
                  onPressed: _increment,
                  child: Icon(
                    Icons.add,
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
