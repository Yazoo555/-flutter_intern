import 'package:flutter/material.dart';

class NavigatedPage extends StatelessWidget {
  const NavigatedPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    List<Map<String, dynamic>> customScrollLists = [
      {
        'imagePath': 'assets/images/flutter.png',
        'title': 'one',
      },
      {
        'imagePath': 'assets/images/android.png',
        'title': 'two',
      },
      {
        'imagePath': 'assets/images/vs.png',
        'title': 'three',
      },
      {
        'imagePath': 'assets/images/git.png',
        'title': 'four',
      },
      {
        'imagePath': 'assets/images/lab.png',
        'title': 'Five',
      },
      {
        'imagePath': 'assets/images/bit.png',
        'title': 'Six',
      },
      {
        'imagePath': 'assets/images/google.png',
        'title': 'Seven',
      },
      {
        'imagePath': 'assets/images/flutter.png',
        'title': 'Eight',
      },
      {
        'imagePath': 'assets/images/android.png',
        'title': 'Nine',
      },
      {
        'imagePath': 'assets/images/vs.png',
        'title': 'Ten',
      },
      {
        'imagePath': 'assets/images/git.png',
        'title': 'Eleven',
      },
    ];
    return SafeArea(
      child: Scaffold(
        body: CustomScrollView(
          shrinkWrap: true,
          scrollDirection: Axis.vertical,
          slivers: [
            SliverAppBar(
              pinned: true,
              expandedHeight: 80,
              toolbarHeight: 50,
              title: Column(
                children: [
                  Text("Nav  Page"),
                  Icon(Icons.pages_sharp),
                ],
              ),
              elevation: 0,
              backgroundColor: Colors.grey.shade500,
            ),
            SliverList(
              delegate: SliverChildBuilderDelegate(
                childCount: 2,
                (context, index) {
                  return Container(
                    child: ListView.builder(
                      itemCount: customScrollLists.length,
                      primary: false,
                      shrinkWrap: true,
                      physics: NeverScrollableScrollPhysics(),
                      itemBuilder: (context, index) {
                        Map<String, dynamic> lists = customScrollLists[index];
                        return Container(
                            height: 110,
                            decoration: BoxDecoration(
                              border: Border.all(color: Colors.black),
                            ),
                            child: Column(
                              children: [
                                SizedBox(
                                  height: 80,
                                  child: Image.asset(
                                    lists['imagePath'],
                                    fit: BoxFit.contain,
                                  ),
                                ),
                                Text(lists['title']),
                              ],
                            ));
                      },
                    ),
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
