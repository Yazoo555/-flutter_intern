import 'package:flutter/material.dart';

class GenderField extends StatefulWidget {
  final Function(String?) onGenderChanged;
  final String? selectedGender;
//  find out what is this and use HERE..
  const GenderField(
      {required this.onGenderChanged, required this.selectedGender, super.key});

  @override
  State<GenderField> createState() => _GenderFieldState();
}

class _GenderFieldState extends State<GenderField> {
  String selectedGender = 'Male';
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(14.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            "Gender",
            style: TextStyle(fontSize: 18),
          ),
          SizedBox(
            height: 10,
          ),
          Row(
            children: [
              Radio(
                value: "Male",
                groupValue: selectedGender,
                onChanged: (value) {
                  setState(() {
                    selectedGender = value!;
                  });
                  widget.onGenderChanged(value);
                },
              ),
              Text(
                "Male",
                style: TextStyle(fontStyle: FontStyle.normal, fontSize: 15),
              ),
              //
              SizedBox(
                width: 20,
              ),

              Radio(
                value: "female",
                groupValue: selectedGender,
                onChanged: (value) {
                  setState(() {
                    selectedGender = value!;
                  });
                  widget.onGenderChanged(value);
                },
              ),
              Text(
                "Female",
                style: TextStyle(fontStyle: FontStyle.normal, fontSize: 15),
              ),

              SizedBox(
                width: 20,
              ),

              Radio(
                value: "Others",
                groupValue: selectedGender,
                onChanged: (value) {
                  setState(() {
                    selectedGender = value!;
                  });
                  widget.onGenderChanged(value);
                },
              ),

              Text(
                "Others",
                style: TextStyle(fontStyle: FontStyle.normal, fontSize: 15),
              ),
            ],
          )
        ],
      ),
    );
  }
}
