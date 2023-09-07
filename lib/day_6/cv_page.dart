import 'package:day_6_cv/day_6/age/age_field.dart';
import 'package:day_6_cv/day_6/name/all_name_field.dart';
import 'package:day_6_cv/day_6/project/add_proj.dart';
import 'package:day_6_cv/day_6/project/pro_field.dart';
import 'package:day_6_cv/day_6/skills/choose_skills.dart';
import 'package:day_6_cv/day_6/workExperience/add_experience.dart';
import 'package:day_6_cv/day_6/workExperience/work_experience.dart';
import 'package:flutter/material.dart';
import 'education/add_edu.dart';
import 'education/edu_field.dart';
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
  List<String> selectedSkills = [];
  List<WorkExperienceData> workExperiences = [];
  List<EducationData> educationDatas = [];
  ValueNotifier<bool> _valueNotifier = ValueNotifier(false);
  List<ProjectData> projectDatas = [];

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
                    builder: (BuildContext context, bool value, Widget? child) {
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
            ],
          ),
        ),
      ),
    );
  }
}
