import 'package:day_6_cv/day_6/education/edu_field.dart';
import 'package:day_6_cv/day_6/project/pro_field.dart';
import '../workExperience/work_experience.dart';

class CvData {
  String id;
  String firstName;
  String middleName;
  String lastName;
  int age;
  String? gender;
  List<String> skills;
  List<WorkExperienceData> workExperiences;
  List<ProjectData> projectDatas;
  List<EducationData> educationDatas;
  List<String> languages;
  List<String> interestAreas;
  CvData({
    required this.id,
    required this.firstName,
    required this.middleName,
    required this.lastName,
    required this.age,
    this.gender,
    this.skills = const [],
    this.workExperiences = const [],
    this.projectDatas = const [],
    this.educationDatas = const [],
    this.languages = const [],
    this.interestAreas = const [],
  });
  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'firstName': firstName,
      'middleName': middleName,
      'lastName': lastName,
      'age': age,
      'gender': gender,
      'skills': skills,
      'workExperiences': workExperiences.map((e) => e.toJson()).toList(),
      'projectDatas': projectDatas.map((e) => e.toJson()).toList(),
      'educationDatas': educationDatas.map((e) => e.toJson()).toList(),
      'languages': languages,
      'interestAreas': interestAreas,
    };
  }

  factory CvData.fromJson(Map<String, dynamic> json) {
    return CvData(
      id: json['id'],
      firstName: json['firstName'],
      middleName: json['middleName'],
      lastName: json['lastName'],
      age: json['age'],
      gender: json['gender'],
      skills: List<String>.from(json['skills']),
      workExperiences: List<WorkExperienceData>.from(
        json['workExperiences'].map((e) => WorkExperienceData.fromJson(e)),
      ),
      projectDatas: List<ProjectData>.from(
        json['projectDatas'].map((e) => ProjectData.fromJson(e)),
      ),
      educationDatas: List<EducationData>.from(
          json['educationDatas'].map((e) => EducationData.fromJson(e))),
      languages: List<String>.from(json['languages']),
      interestAreas: List<String>.from(json['interestAreas']),
    );
  }
}
