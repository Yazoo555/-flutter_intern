import 'package:flutter/material.dart';

class RadioBox extends StatefulWidget {
  final Function(String? value) callback;
  const RadioBox({
    required this.callback,
    super.key,
  });

  @override
  State<RadioBox> createState() => _RadioBoxState();
}

class _RadioBoxState extends State<RadioBox> {
  String genderList = 'Male';
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            "Select  Your Gender :",
            style: TextStyle(fontSize: 17, color: Colors.grey.shade700),
          ),
          SizedBox(
            height: 5,
          ),
          Row(
            children: [
              Radio<String>(
                value: 'Male',
                groupValue: genderList,
                onChanged: (value) {
                  setState(() {
                    genderList = value!;
                    widget.callback(value);
                  });
                },
              ),
              Text(
                "Male",
                style: TextStyle(
                  fontSize: 16.5,
                  color: Colors.grey.shade800,
                ),
              ),
              Radio<String>(
                value: 'Female',
                groupValue: genderList,
                onChanged: (value) {
                  setState(() {
                    genderList = value!;
                    widget.callback(value);
                  });
                },
              ),
              Text(
                "Female",
                style: TextStyle(
                  fontSize: 16.5,
                  color: Colors.grey.shade800,
                ),
              ),
              Radio<String>(
                value: 'Others',
                groupValue: genderList,
                onChanged: (value) {
                  setState(() {
                    genderList = value!;
                    widget.callback(value);
                  });
                },
              ),
              Text(
                "Others",
                style: TextStyle(
                  fontSize: 16.5,
                  color: Colors.grey.shade800,
                ),
              ),
            ],
          )
        ],
      ),
    );
  }
}
