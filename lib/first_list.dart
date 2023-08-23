import 'package:flutter/material.dart';

class FirstList extends StatelessWidget {
  const FirstList({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    List<Map<String, dynamic>> listForListViewBuilder = [
      {
        'imageUrl':
            'https://miro.medium.com/v2/resize:fit:980/1*UxsqCG40e62ZZ5bj_vElLQ.png',
        'title': 'Chess',
        'dateT': [
          {'date': '2012', 'time': '12:00'}
        ]
      },
      {
        'imageUrl':
            'https://static.vecteezy.com/system/resources/previews/006/044/496/original/set-of-tennis-logos-emblems-badges-labels-and-design-elements-free-vector.jpg',
        'title': 'Racket and Tennis',
        'dateT': [
          {'date': '2014', 'time': '11:00'}
        ]
      },
      {
        'imageUrl':
            'https://media3.giphy.com/media/v1.Y2lkPTc5MGI3NjExdjFjanpoaXFyNHg5MmM5cnRiaGFkN2Mzc2FyZWJ1MzRtN2k1M2tqYSZlcD12MV9pbnRlcm5hbF9naWZfYnlfaWQmY3Q9Zw/ebF0Vfj4TJo3u/giphy.gif',
        'title': 'Ball',
        'dateT': [
          {'date': '2020', 'time': '1:30'}
        ]
      },
      {
        'imageUrl':
            'https://media0.giphy.com/media/v1.Y2lkPTc5MGI3NjExa3lqNWtqc3VsNDUwbG84YXk0eXRnc3V1M3lqNWx4cnQ3dGdlMWhmNyZlcD12MV9pbnRlcm5hbF9naWZfYnlfaWQmY3Q9Zw/1XeAUJcTgKsHZfQy5A/giphy.gif',
        'title': 'Run with me',
        'dateT': [
          {'date': '2005', 'time': '7:00'}
        ]
      },
      {
        'imageUrl':
            'https://media3.giphy.com/media/v1.Y2lkPTc5MGI3NjExZ2tlcXJ5dWxlbGplNGRqMWZtcnp0anhlcDc2bmE5OHd2MGp0MHE1MyZlcD12MV9pbnRlcm5hbF9naWZfYnlfaWQmY3Q9Zw/jPOjetGs2g8w0/giphy.gif',
        'title': 'Excited',
        'dateT': [
          {'date': '2007', 'time': '15:00'}
        ]
      },
      {
        'imageUrl':
            'https://media4.giphy.com/media/v1.Y2lkPTc5MGI3NjExYXg0YWF1b3ZmeXZpaXhibWZvbTNjazU4N2MwY2hsa2gxa29keDd5MSZlcD12MV9pbnRlcm5hbF9naWZfYnlfaWQmY3Q9Zw/26FfhTZMLhY4PSnpm/giphy.gif',
        'title': 'Short-Guy',
        'dateT': [
          {'date': '2009', 'time': '19:00'}
        ]
      },
      {
        'imageUrl':
            'https://media2.giphy.com/media/v1.Y2lkPTc5MGI3NjExY2k3NDlwMDkxNHB1czI1cWo5dXp5b3RwM2JxaGt4aGMycnFkcjJyYyZlcD12MV9pbnRlcm5hbF9naWZfYnlfaWQmY3Q9Zw/L8hdZuf5cJ7mo/giphy.gif',
        'title': 'Wait For Me',
        'dateT': [
          {'date': '2003', 'time': '5:00'}
        ]
      },
      {
        'imageUrl':
            'https://media0.giphy.com/media/v1.Y2lkPTc5MGI3NjExa3lqNWtqc3VsNDUwbG84YXk0eXRnc3V1M3lqNWx4cnQ3dGdlMWhmNyZlcD12MV9pbnRlcm5hbF9naWZfYnlfaWQmY3Q9Zw/1XeAUJcTgKsHZfQy5A/giphy.gif',
        'title': 'Tall - freinds Run',
        'dateT': [
          {'date': '2004', 'time': '10:00'}
        ]
      },
      {
        'imageUrl':
            'https://media0.giphy.com/media/v1.Y2lkPTc5MGI3NjExaXIwcGt4Z3NtYnhzeXhsNXV4Y2J4czdhN3U1Mmx5bXF4bWw0NG01dCZlcD12MV9pbnRlcm5hbF9naWZfYnlfaWQmY3Q9Zw/xUNd9Otk0IQVLfaoHS/giphy.gif',
        'title': 'Short Man',
        'dateT': [
          {'date': '1996', 'time': '2:00'}
        ]
      },
      {
        'imageUrl':
            'https://media2.giphy.com/media/v1.Y2lkPTc5MGI3NjExY2k3NDlwMDkxNHB1czI1cWo5dXp5b3RwM2JxaGt4aGMycnFkcjJyYyZlcD12MV9pbnRlcm5hbF9naWZfYnlfaWQmY3Q9Zw/L8hdZuf5cJ7mo/giphy.gif',
        'title': 'Run-Run',
        'dateT': [
          {'date': '2002', 'time': '10:00'}
        ]
      },
    ];
    return SizedBox(
      child: ListView.builder(
        shrinkWrap: true,
        itemCount: listForListViewBuilder.length,
        scrollDirection: Axis.horizontal,
        itemBuilder: (context, index) {
          Map<String, dynamic> lists = listForListViewBuilder[index];
          return Padding(
            padding: EdgeInsets.only(left: 15),
            child: Container(
              decoration:
                  BoxDecoration(border: Border.all(color: Colors.black)),
              child: Column(
                children: [
                  Image.network(
                    lists['imageUrl'],
                    fit: BoxFit.scaleDown,
                    height: 100,
                    width: 100,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(lists['title']),
                      const SizedBox(
                        width: 75,
                      ),
                      Column(
                        children: [
                          Text("Date: ${lists['dateT'][0]['date']}"),
                          Text("Time: ${lists['dateT'][0]['time']}"),
                        ],
                      )
                    ],
                  )
                ],
              ),
            ),
          );
        },
      ),
    );
  }
}
