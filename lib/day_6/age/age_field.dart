import 'package:flutter/material.dart';

class AgeField extends StatelessWidget {
  final String hintText;
  final TextEditingController ageController;

  const AgeField({
    required this.hintText,
    required this.ageController,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(10.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text("Age"),
          const SizedBox(
            height: 8.0,
          ),
          TextFormField(
            controller: ageController,
            keyboardType: TextInputType.number,
            validator: (value) {
              if (value == null || value.isEmpty) {
                return 'Enter your age';
              } else if (!RegExp(r"^[0-9]+$").hasMatch(value)) {
                return 'Invalid Input';
              } else if (ageController.text.length > 3) {
                return 'Invalid Age';
              }
              return null;
            },
            decoration: InputDecoration(
              hintText: hintText,
              enabledBorder: OutlineInputBorder(
                borderSide: BorderSide(color: Colors.black),
                borderRadius: BorderRadius.circular(12.0),
              ),
              focusedBorder: OutlineInputBorder(
                borderSide: BorderSide(color: Colors.orangeAccent.shade700),
                borderRadius: BorderRadius.circular(12.0),
              ),
              errorBorder: OutlineInputBorder(
                borderSide: BorderSide(color: Colors.black),
                borderRadius: BorderRadius.circular(12.0),
              ),
              focusedErrorBorder: OutlineInputBorder(
                borderSide: BorderSide(color: Colors.black),
                borderRadius: BorderRadius.circular(12.0),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
