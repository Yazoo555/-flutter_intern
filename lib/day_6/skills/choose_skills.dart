import 'package:flutter/material.dart';

class ChooseSkills extends StatefulWidget {
  final Function(List<String>) onSkillChanged;
  ChooseSkills({required this.onSkillChanged, super.key});
  @override
  State<ChooseSkills> createState() => _ChooseSkillsState();
}

class _ChooseSkillsState extends State<ChooseSkills> {
  List<String> _selectedSkills = [];

  final List<String> allOptions = [
    "Skill-1",
    "Skill-2",
    "Skill-3",
    "Skill-4",
    "Skill-5"
  ]; // Replace with your options

  void _toggleOption(String option) {
    setState(() {
      if (_selectedSkills.contains(option)) {
        _selectedSkills.remove(option);
      } else {
        _selectedSkills.add(option);
      }
    });
    widget.onSkillChanged(_selectedSkills);
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          "Choose Skills",
          style: TextStyle(
            fontSize: 15,
          ),
        ),
        SizedBox(
          height: 16,
        ),
        Wrap(
          spacing: 8.5,
          runSpacing: 2.5,
          children: allOptions.map((option) {
            return Padding(
              padding: const EdgeInsets.all(3.0),
              child: Chip(
                label: Text(option),
                backgroundColor: _selectedSkills.contains(option)
                    ? Colors.orange.shade500
                    : Colors.grey.shade300,
                onDeleted: () {
                  _toggleOption(option);
                },
              ),
            );
          }).toList(),
        ),
      ],
    );
  }
}
