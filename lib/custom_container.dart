import 'package:flutter/material.dart';

class CustomListContainer extends StatelessWidget {
  final String imageurl;
  final String title;
  final IconData icon;
  final String description;
  final String buttonName;

  const CustomListContainer(
      {required this.title,
      required this.description,
      required this.icon,
      required this.buttonName,
      required this.imageurl,
      Key? key})
      : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(4.0),
      child: Container(
        decoration: BoxDecoration(border: Border.all(color: Colors.black)),
        child: Column(
          children: [
            Container(
              margin: const EdgeInsets.all(3.0),
              height: 50,
              width: 50,
              decoration: BoxDecoration(
                border: Border.all(color: Colors.red),
              ),
              child: ClipRRect(
                borderRadius: BorderRadius.circular(10.0),
                child: Image.network(
                  imageurl,
                  fit: BoxFit.fill,
                ),
              ),
            ),
            Text(title),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Icon(icon),
                SizedBox(
                  width: 10,
                ),
                Text(description),
              ],
            ),
            ElevatedButton(
              onPressed: () {},
              child: Text(buttonName),
            ),
          ],
        ),
      ),
    );
  }
}
