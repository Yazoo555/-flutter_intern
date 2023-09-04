import 'package:day_6_cv/day_6/age/age_field.dart';
import 'package:day_6_cv/day_6/name/all_name_field.dart';
import 'package:day_6_cv/day_6/skills/choose_skills.dart';
import 'package:flutter/material.dart';
import 'gender/gender_field.dart';

class CvPage extends StatefulWidget {
  CvPage({super.key});

  @override
  State<CvPage> createState() => _CvPageState();
}

class _CvPageState extends State<CvPage> {
  TextEditingController firstNameController = TextEditingController();
  TextEditingController middleNameController = TextEditingController();
  TextEditingController lastNameController = TextEditingController();
  TextEditingController ageController = TextEditingController();
  String? selectedGender = "";

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey.shade100,
      appBar: AppBar(
        title: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Text(
            "C.V",
            style: TextStyle(
              fontSize: 22,
            ),
          ),
        ),
        elevation: .6,
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(4.0),
          child: Column(
            children: [
              Text(
                "Curriculum Vitae",
                style: TextStyle(
                    fontSize: 30,
                    fontWeight: FontWeight.w400,
                    color: Colors.deepOrangeAccent),
              ),
              const SizedBox(
                height: 8,
              ),
              AllNameField(
                  name: "First Name",
                  controller: firstNameController,
                  hintText: "First-Name"),
              AllNameField(
                  name: "Middle Name",
                  controller: middleNameController,
                  hintText: "Middle-Name"),
              AllNameField(
                  name: "Last Name",
                  controller: lastNameController,
                  hintText: "Last-Name"),
              AgeField(
                hintText: "Age",
                ageController: ageController,
              ),
              GenderField(
                onGenderChanged: (gender) {
                  setState(() {
                    selectedGender = gender;
                  });
                },
                selectedGender: selectedGender,
              ),
              ChooseSkills(),
            ],
          ),
        ),
      ),
    );
  }
}