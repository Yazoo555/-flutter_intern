import 'package:flutter/material.dart';

import 'custom_container.dart';

class SecondListView extends StatefulWidget {
  const SecondListView({Key? key}) : super(key: key);

  @override
  State<SecondListView> createState() => _SecondListViewState();
}

class _SecondListViewState extends State<SecondListView> {
  int viewList = 5;
  List<Widget> widgetList = <Widget>[
    const CustomListContainer(
      title: "Image 1",
      description: "This is image 1",
      icon: Icons.lock,
      buttonName: "Button 1",
      imageurl:
          "https://s7d1.scene7.com/is/image/mcdonalds/DC_202002_6050_SmallFrenchFries_Standing_832x472:1-3-product-tile-desktop?wid=765&hei=472&dpr=off",
    ),
    const CustomListContainer(
      title: "Image 2",
      description: "This is image 2",
      icon: Icons.add_box,
      buttonName: "Button 2",
      imageurl:
          "https://s7d1.scene7.com/is/image/mcdonalds/DC_202002_6050_SmallFrenchFries_Standing_832x472:1-3-product-tile-desktop?wid=765&hei=472&dpr=off",
    ),
    const CustomListContainer(
      title: "Image 3",
      description: "This is image 3",
      icon: Icons.call_merge_outlined,
      buttonName: "Button 3",
      imageurl:
          "https://s7d1.scene7.com/is/image/mcdonalds/DC_202002_6050_SmallFrenchFries_Standing_832x472:1-3-product-tile-desktop?wid=765&hei=472&dpr=off",
    ),
    const CustomListContainer(
      title: "Image 4",
      description: "This is image 4",
      icon: Icons.one_x_mobiledata,
      buttonName: "Button 4",
      imageurl:
          "https://s7d1.scene7.com/is/image/mcdonalds/DC_202002_6050_SmallFrenchFries_Standing_832x472:1-3-product-tile-desktop?wid=765&hei=472&dpr=off",
    ),
    const CustomListContainer(
      title: "Image 5",
      description: "This is image 5",
      icon: Icons.phone_missed,
      buttonName: "Button 5",
      imageurl:
          "https://s7d1.scene7.com/is/image/mcdonalds/DC_202002_6050_SmallFrenchFries_Standing_832x472:1-3-product-tile-desktop?wid=765&hei=472&dpr=off",
    ),
    const CustomListContainer(
      title: "Image 6",
      description: "This is image 6",
      icon: Icons.add_box,
      buttonName: "Button 6",
      imageurl:
          "https://s7d1.scene7.com/is/image/mcdonalds/DC_202002_6050_SmallFrenchFries_Standing_832x472:1-3-product-tile-desktop?wid=765&hei=472&dpr=off",
    ),
    const CustomListContainer(
      title: "Image 7",
      description: "This is image 7",
      icon: Icons.send_and_archive,
      buttonName: "Button 7",
      imageurl:
          "https://s7d1.scene7.com/is/image/mcdonalds/DC_202002_6050_SmallFrenchFries_Standing_832x472:1-3-product-tile-desktop?wid=765&hei=472&dpr=off",
    ),
    const CustomListContainer(
      title: "Image 8",
      description: "This is image 8",
      icon: Icons.tab_sharp,
      buttonName: "Button 8",
      imageurl:
          "https://s7d1.scene7.com/is/image/mcdonalds/DC_202002_6050_SmallFrenchFries_Standing_832x472:1-3-product-tile-desktop?wid=765&hei=472&dpr=off",
    ),
    const CustomListContainer(
      title: "Image 9",
      description: "This is image 9",
      icon: Icons.receipt,
      buttonName: "Button 9",
      imageurl:
          "https://s7d1.scene7.com/is/image/mcdonalds/DC_202002_6050_SmallFrenchFries_Standing_832x472:1-3-product-tile-desktop?wid=765&hei=472&dpr=off",
    ),
    const CustomListContainer(
      title: "Image 10",
      description: "This is image 10",
      icon: Icons.label_important,
      buttonName: "Button 10",
      imageurl:
          "https://s7d1.scene7.com/is/image/mcdonalds/DC_202002_6050_SmallFrenchFries_Standing_832x472:1-3-product-tile-desktop?wid=765&hei=472&dpr=off",
    ),
  ];
  List<Widget> visibleWidget = [];
  @override
  void initState() {
    updateWidgetList();
    super.initState();
  }

  void updateWidgetList() {
    visibleWidget = widgetList.take(viewList).toList();
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(4.0),
      child: Container(
          height: 400,
          decoration: BoxDecoration(
            color: Colors.grey,
            border: Border.all(color: Colors.black),
          ),
          child: Column(
            children: [
              const Text("Title: ListView Container"),
              const SizedBox(
                height: 15,
              ),
              const Text("Description: Below is list"),
              const SizedBox(
                height: 10,
              ),
              Padding(
                padding: const EdgeInsets.all(6.0),
                child: Container(
                  height: 320,
                  decoration: BoxDecoration(
                    color: Colors.white,
                    border: Border.all(color: Colors.black),
                  ),
                  child: ListView(children: visibleWidget),
                ),
              ),
              ElevatedButton(
                style: ElevatedButton.styleFrom(
                    fixedSize: const Size(180, 50),
                    backgroundColor: Colors.orange),
                onPressed: () {
                  setState(
                    () {
                      if (viewList == 5) {
                        viewList = 10;
                      } else {
                        viewList = 5;
                      }
                    },
                  );
                  updateWidgetList();
                },
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(viewList == 5 ? "Show More" : "Show Less"),
                    Icon(viewList == 5
                        ? Icons.arrow_drop_down
                        : Icons.arrow_drop_up_sharp)
                  ],
                ),
              ),
            ],
          )),
    );
  }
}
