// ignore: file_names
import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:day_6_cv/day_6/education/edu_field.dart';
import 'package:day_6_cv/day_6/project/pro_field.dart';
import 'package:day_6_cv/day_6/workExperience/work_experience.dart';
import 'package:day_6_cv/day_6/shared_Pref/shared_model.dart';
import 'package:shared_preferences/shared_preferences.dart';

class SavedData extends StatefulWidget {
  const SavedData({Key? key}) : super(key: key);
  @override
  State<SavedData> createState() => _SavedDataState();
}

class _SavedDataState extends State<SavedData> {
  List<CvData> cvFullData = [];
  @override
  void initState() {
    _loadSaveData();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("User Saved Data"),
        elevation: 0,
        centerTitle: true,
        backgroundColor: Colors.black,
      ),
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              height: 670,
              child: ListView.builder(
                scrollDirection: Axis.vertical,
                itemCount: cvFullData.length,
                itemBuilder: (context, index) {
                  CvData cvData = cvFullData[index];
                  return Padding(
                    padding: const EdgeInsets.all(4.0),
                    child: Container(
                      decoration: BoxDecoration(
                          border: Border.all(color: Colors.black)),
                      child: Column(
                        children: [
                          Text(
                            "USER ${index + 1}",
                            style: TextStyle(
                                fontWeight: FontWeight.bold,
                                fontSize: 20,
                                color: Colors.red),
                          ),
                          Text("First Name: ${cvData.firstName}"),
                          Text("Middle Name: ${cvData.middleName}"),
                          Text("Last Name: ${cvData.lastName}"),
                          Text("Age: ${cvData.age}"),
                          Text("Gender: ${cvData.gender ?? 'Not chosen'}"),
                          Text("Skills: ${cvData.skills.join(',')}"),
                          Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Container(
                              decoration: BoxDecoration(
                                  border: Border.all(color: Colors.black26)),
                              height: 150,
                              child: ListView.builder(
                                itemCount: cvData.workExperiences.length,
                                itemBuilder: (context, index) {
                                  WorkExperienceData works =
                                      cvData.workExperiences[index];
                                  return ListTile(
                                    title: Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.center,
                                          children: [
                                            Text(
                                              "Job ${index + 1}",
                                              textAlign: TextAlign.center,
                                              style: TextStyle(
                                                  fontSize: 20,
                                                  fontWeight: FontWeight.bold,
                                                  color: Colors.purple),
                                            ),
                                          ],
                                        ),
                                        Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.center,
                                          children: [
                                            Column(
                                              children: [
                                                Text(
                                                    "Job Title: ${works.jobTitle}"),
                                                Text(
                                                    "Summary: ${works.summary}"),
                                                Text(
                                                    "Company Name: ${works.companyName}"),
                                                Text(
                                                    "Start Date: ${works.startDate}"),
                                                Text(
                                                    "End Date: ${works.endDate}"),
                                              ],
                                            ),
                                          ],
                                        )
                                      ],
                                    ),
                                  );
                                },
                              ),
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.all(4.0),
                            child: Container(
                              decoration: BoxDecoration(
                                border: Border.all(color: Colors.black26),
                              ),
                              height: 150,
                              child: ListView.builder(
                                scrollDirection: Axis.vertical,
                                itemCount: cvData.educationDatas.length,
                                itemBuilder: (context, index) {
                                  EducationData educationData =
                                      cvData.educationDatas[index];
                                  return ListTile(
                                    title: Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.center,
                                          children: [
                                            Text(
                                              "Education ${index + 1}",
                                              textAlign: TextAlign.center,
                                              style: TextStyle(
                                                  fontSize: 20,
                                                  fontWeight: FontWeight.bold,
                                                  color: Colors.purple),
                                            ),
                                          ],
                                        ),
                                        Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.center,
                                          children: [
                                            Column(
                                              children: [
                                                Text(
                                                    "Organization Name: ${educationData.orgName}"),
                                                Text(
                                                    "Level: ${educationData.level}"),
                                                Text(
                                                    "Achievements: ${educationData.achievments}"),
                                                Text(
                                                    "Start Date: ${educationData.startDate}"),
                                                Text(
                                                    "End Date: ${educationData.endDate}"),
                                              ],
                                            ),
                                          ],
                                        ),
                                      ],
                                    ),
                                  );
                                },
                              ),
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.all(4.0),
                            child: Container(
                              decoration: BoxDecoration(
                                border: Border.all(color: Colors.black26),
                              ),
                              height: 150,
                              child: ListView.builder(
                                scrollDirection: Axis.vertical,
                                itemCount: cvData.projectDatas.length,
                                itemBuilder: (context, index) {
                                  ProjectData projectData =
                                      cvData.projectDatas[index];
                                  return ListTile(
                                    title: Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.center,
                                          children: [
                                            Text(
                                              "Project ${index + 1}",
                                              textAlign: TextAlign.center,
                                              style: TextStyle(
                                                  fontSize: 20,
                                                  fontWeight: FontWeight.bold,
                                                  color: Colors.purple),
                                            ),
                                          ],
                                        ),
                                        Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.center,
                                          children: [
                                            Column(
                                              children: [
                                                Text(
                                                    "Project Title: ${projectData.projectTitle}"),
                                                Text(
                                                    "Description: ${projectData.pDescription}"),
                                                Text(
                                                    "Organization Name: ${projectData.orgName}"),
                                                Text(
                                                    "Start Date: ${projectData.startDate}"),
                                                Text(
                                                    "End Date: ${projectData.endDate}"),
                                              ],
                                            ),
                                          ],
                                        ),
                                      ],
                                    ),
                                  );
                                },
                              ),
                            ),
                          ),
                          Text(
                            "Languages: ${cvData.languages.join(',')}",
                            style: TextStyle(
                              fontSize: 16,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          Text(
                            "Interested Areas: ${cvData.interestAreas.join(',')}",
                            style: TextStyle(
                              fontSize: 16,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          SizedBox(
                            height: 25,
                          ),
                          Column(
                            children: [
                              Padding(
                                padding: const EdgeInsets.all(12.0),
                                child: ElevatedButton(
                                  style: ElevatedButton.styleFrom(
                                    backgroundColor: Colors.red,
                                    elevation: 4.0,
                                    fixedSize: Size(130, 50),
                                    shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(12),
                                    ),
                                  ),
                                  onPressed: _deleteSaveData,
                                  child: Text(
                                    "Delete Data",
                                    style: TextStyle(
                                      fontSize: 18,
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                ),
                              )
                            ],
                          )
                        ],
                      ),
                    ),
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }

  Future<List<CvData>> _loadSaveData() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    final jsonString = prefs.getString('cvData');
    if (jsonString != null) {
      try {
        final jsonList = jsonDecode(jsonString) as List<dynamic>;
        setState(() {
          cvFullData = jsonList.map((json) => CvData.fromJson(json)).toList();
        });
      } catch (e) {
        print("Error :$e");
      }
    }
    return [];
  }

  Future<void> _deleteSaveData() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.clear();
    setState(() {
      cvFullData = [];
    });
  }
}
