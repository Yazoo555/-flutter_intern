import 'package:flutter/material.dart';

class InterestArea extends StatefulWidget {
  final Function(List<String>) onInterestArea;
  const InterestArea({
    required this.onInterestArea,
    Key? key,
  }) : super(key: key);

  @override
  State<InterestArea> createState() => _InterestAreaState();
}

class _InterestAreaState extends State<InterestArea> {
  List<Map<String, dynamic>> availableArea = [
    {
      'name': 'Flutter',
      'isChecked': false,
    },
    {
      'name': 'WebApp',
      'isChecked': false,
    },
    {
      'name': 'Graphics',
      'isChecked': false,
    },
  ];
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 8),
      child: Container(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Padding(
              padding: const EdgeInsets.all(17.0),
              child: Text(
                "Interested Areas",
                style: TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.w500,
                ),
              ),
            ),
            SingleChildScrollView(
              scrollDirection: Axis.vertical,
              child: Row(
                children: availableArea.map((areas) {
                  return Row(children: [
                    Checkbox(
                      activeColor: Colors.orangeAccent.shade700,
                      value: areas['isChecked'],
                      onChanged: (newValue) {
                        setState(() {
                          areas['isChecked'] = newValue;
                          final selectedInterestAreas = availableArea
                              .where((areas) => areas['isChecked'])
                              .map((areas) => areas['name'])
                              .toList()
                              .cast<String>();
                          widget.onInterestArea(selectedInterestAreas);
                        });
                      },
                    ),
                    Text(areas['name'])
                  ]);
                }).toList(),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
