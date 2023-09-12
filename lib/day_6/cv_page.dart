import 'dart:convert';
import 'package:day_6_cv/Svd_data.dart';
import 'package:day_6_cv/day_6/age/age_field.dart';
import 'package:day_6_cv/day_6/intrests%20Area/intrests.dart';
import 'package:day_6_cv/day_6/language/lang.dart';
import 'package:day_6_cv/day_6/name/all_name_field.dart';
import 'package:day_6_cv/day_6/project/add_proj.dart';
import 'package:day_6_cv/day_6/project/pro_field.dart';
import 'package:day_6_cv/day_6/shared_Pref/shared_model.dart';
import 'package:day_6_cv/day_6/skills/choose_skills.dart';
import 'package:day_6_cv/day_6/workExperience/add_experience.dart';
import 'package:day_6_cv/day_6/workExperience/work_experience.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'education/add_edu.dart';
import 'education/edu_field.dart';
import 'gender/gender_field.dart';

class CvPage extends StatefulWidget {
  const CvPage({Key? key}) : super(key: key);

  @override
  State<CvPage> createState() => _CvPageState();
}

class _CvPageState extends State<CvPage> {
  TextEditingController firstNameController = TextEditingController();
  TextEditingController middleNameController = TextEditingController();
  TextEditingController lastNameController = TextEditingController();
  TextEditingController ageController = TextEditingController();
  String? selectedGender = "";
  List<String> selectedSkills = [];
  List<WorkExperienceData> workExperiences = [];
  List<EducationData> educationDatas = [];
  List<String> selectedLanguage = [];
  List<String> selectedAreas = [];
  final ValueNotifier<bool> _valueNotifier = ValueNotifier(false);
  List<ProjectData> projectDatas = [];
  final GlobalKey<FormState> _key = GlobalKey<FormState>();
  List<CvData> cvDataList = [];

  void _onTapIcon(WorkExperienceData workExperience) {
    setState(() {
      workExperiences.remove(workExperience);
    });
  }

  void _onTapEducation(EducationData educationData) {
    setState(() {
      educationDatas.remove(educationData);
    });
  }

  void _onTapProject(ProjectData projectData) {
    setState(() {
      projectDatas.remove(projectData);
    });
  }

  void _resetForm() {
    firstNameController.clear();
    middleNameController.clear();
    lastNameController.clear();
    ageController.clear();
    selectedGender = null;
    selectedSkills.clear();
    selectedLanguage.clear();
    selectedAreas.clear();
    setState(() {
      workExperiences.clear();
      educationDatas.clear();
      projectDatas.clear();
    });
  }

  CvData _prepareCvData() {
    final cvData = CvData(
      id: DateTime.now().toString(),
      firstName: firstNameController.text,
      middleName: middleNameController.text,
      lastName: lastNameController.text,
      age: int.tryParse(ageController.text) ?? 0,
      gender: selectedGender,
      skills: selectedSkills,
      workExperiences: workExperiences,
      projectDatas: projectDatas,
      educationDatas: educationDatas,
    );
    return cvData;
  }

  Future<void> _saveData() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    final cvData = _prepareCvData();
    cvData.languages = selectedLanguage;
    cvData.interestAreas = selectedAreas;
    final jsonString = prefs.getString('cvData');
    List<CvData> cvDataList = [];
    if (jsonString != null) {
      try {
        final jsonData = jsonDecode(jsonString);
        if (jsonData is List<dynamic>) {
          cvDataList = jsonData.map((json) => CvData.fromJson(json)).toList();
        } else if (jsonData is Map<String, dynamic>) {
          cvDataList.add(CvData.fromJson(jsonData));
        }
      } catch (e) {
        print("Error data: $e");
      }
    }
    cvDataList.add(cvData);
    final jsonStringToSave =
        jsonEncode(cvDataList.map((cvData) => cvData.toJson()).toList());
    await prefs.setString('cvData', jsonStringToSave);
    setState(() {
      this.cvDataList = cvDataList;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey.shade100,
      appBar: AppBar(
        backgroundColor: Colors.grey.shade500,
        title: Padding(
          padding: const EdgeInsets.all(4.0),
          child: Text(
            "C.V",
            style: TextStyle(
              fontSize: 23,
            ),
          ),
        ),
        elevation: .5,
        toolbarHeight: 40.0,
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(4.0),
          child: Form(
            key: _key,
            // key has been added here for the validation of Form for Save button

            child: Column(
              children: [
                Text(
                  "Curriculum Vitae",
                  style: TextStyle(
                      fontSize: 35,
                      fontWeight: FontWeight.w500,
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
                ChooseSkills(onSkillChanged: (skill) {
                  setState(() {
                    selectedSkills = skill;
                  });
                }),
                Padding(
                  padding: const EdgeInsets.all(18),
                  child: Row(
                    children: [
                      Text(
                        "Work Experience",
                        style: TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                      Spacer(),
                      //

                      ElevatedButton(
                        onPressed: () async {
                          final newWorkExperiencee = await Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => AddWorkExperience(),
                            ),
                          );
                          if (newWorkExperiencee != null) {
                            setState(() {
                              workExperiences.add(newWorkExperiencee);
                            });
                          }
                        },
                        style: ButtonStyle(
                          backgroundColor: MaterialStateProperty.all<Color>(
                              Colors.orange.shade500),
                          shape:
                              MaterialStateProperty.all<RoundedRectangleBorder>(
                            RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(
                                  10.0), // Adjust the radius as needed
                            ),
                          ),
                        ),
                        child: Text("ADD"),
                      ),
                    ],
                  ),
                ),
                for (var workExperience in workExperiences)
                  WorkExperienceField(
                    workExperienceData: workExperience,
                    deleteOnTap: () => _onTapIcon(workExperience),
                  ),

//

                Padding(
                  padding: const EdgeInsets.all(18),
                  child: Row(
                    children: [
                      Text(
                        "Education",
                        style: TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                      Spacer(),
                      ElevatedButton(
                        style: ButtonStyle(
                          backgroundColor: MaterialStateProperty.all<Color>(
                              Colors.orange.shade500),
                          shape:
                              MaterialStateProperty.all<RoundedRectangleBorder>(
                            RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(
                                  10.0), // Adjust the radius as needed
                            ),
                          ),
                        ),
                        onPressed: () async {
                          final newEducationData = await Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => AddEducation(),
                            ),
                          );
                          if (newEducationData != null) {
                            setState(() {
                              educationDatas.add(newEducationData);
                            });
                          }
                        },
                        child: Text("ADD"),
                      ),
                    ],
                  ),
                ),
                for (var educationData in educationDatas)
                  EducationField(
                    educationData: educationData,
                    deleteOnTap: () => _onTapEducation(educationData),
                  ),

//

                SizedBox(
                  height: 10,
                ),
                Row(
                  children: [
                    Padding(
                      padding: const EdgeInsets.all(16),
                      child: Text(
                        "Other Projects",
                        style: TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                    ),
                    Spacer(),
                    ValueListenableBuilder(
                      valueListenable: _valueNotifier,
                      builder:
                          (BuildContext context, bool value, Widget? child) {
                        return Padding(
                          padding: const EdgeInsets.only(right: 22),
                          child: Switch(
                            value: value,
                            onChanged: (bool newValue) async {
                              _valueNotifier.value = newValue;
                              if (newValue) {
                                final newProjects = await Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                    builder: (context) => AddOtherProject(),
                                  ),
                                );
                                if (newProjects != null) {
                                  setState(() {
                                    projectDatas.add(newProjects);
                                    _valueNotifier.value = false;
                                  });
                                }
                              }
                            },
                            activeColor: Colors.orangeAccent.shade400,
                          ),
                        );
                      },
                    ),
                  ],
                ),
                for (var projectData in projectDatas)
                  ProjectField(
                    projectData: projectData,
                    projectOnTap: () => _onTapProject(projectData),
                  ),
                SizedBox(
                  height: 8,
                ),
                LanguageField(
                  onLanguagesChanged: (languages) {
                    setState(() {
                      selectedLanguage = languages;
                    });
                  },
                ),

                InterestArea(
                  onInterestArea: (areas) {
                    selectedAreas = areas;
                  },
                ),

                //
                //
                ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.orange.shade700,
                    fixedSize: Size(150, 45),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(18.0),
                    ),
                  ),
                  onPressed: () async {
                    if (_key.currentState!.validate()) {
                      await _saveData();
                      // ignore: use_build_context_synchronously
                      showDialog(
                        context: context,
                        builder: (context) => AlertDialog(
                          title: Text("Your Data has been saved Successfully"),
                          backgroundColor: Colors.purple.shade400,
                          icon: Icon(
                            Icons.check_circle_outline,
                            size: 45,
                          ),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(17.0),
                          ),
                          iconColor: Colors.white,
                          titleTextStyle:
                              TextStyle(color: Colors.white, fontSize: 25),
                        ),
                      );
                      _resetForm();
                    }
                  },
                  child: Text(
                    "Save",
                    style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                  ),
                ),

                const SizedBox(
                  height: 25,
                ),

                ElevatedButton(
                  style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.black,
                      fixedSize: Size(200, 45),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(18.0),
                      )),
                  onPressed: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => SavedData(),
                      ),
                    );
                  },
                  child: Text(
                    "View Data",
                    style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
