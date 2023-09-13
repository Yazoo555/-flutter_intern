import 'package:flutter/material.dart';

class ProjectData {
  final String projectTitle;
  final String pDescription;
  final String startDate;
  final String endDate;
  final String orgName;
  ProjectData({
    required this.projectTitle,
    required this.pDescription,
    required this.startDate,
    required this.endDate,
    required this.orgName,
  });
  Map<String, dynamic> toJson() {
    return {
      'projectTitle': projectTitle,
      'pDescription': pDescription,
      'startDate': startDate,
      'endDate': endDate,
      'orgName': orgName,
    };
  }

  factory ProjectData.fromJson(Map<String, dynamic> json) {
    return ProjectData(
      projectTitle: json['projectTitle'],
      pDescription: json['pDescription'],
      startDate: json['startDate'],
      endDate: json['endDate'],
      orgName: json['orgName'],
    );
  }
}

class ProjectField extends StatelessWidget {
  final ProjectData? projectData;
  final VoidCallback projectOnTap;
  const ProjectField({
    this.projectData,
    required this.projectOnTap,
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return projectData != null
        ? Padding(
            padding: const EdgeInsets.only(left: 8.0, right: 8.0, bottom: 8.0),
            child: Container(
              width: double.infinity,
              decoration: BoxDecoration(
                border: Border.all(color: Colors.grey),
                borderRadius: BorderRadius.circular(17.0),
              ),
              child: Padding(
                padding: const EdgeInsets.only(left: 8.0, right: 8.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      children: [
                        Text("Project Title: ${projectData!.projectTitle}"),
                        Spacer(),
                        GestureDetector(
                          child: Icon(
                            Icons.delete,
                            color: Colors.orangeAccent.shade700,
                          ),
                          onTap: projectOnTap,
                        )
                      ],
                    ),
                    Text("Description: ${projectData!.pDescription}"),
                    Text("Start Date: ${projectData!.startDate}"),
                    Text("End Date: ${projectData!.endDate}"),
                    Text("Organization Name: ${projectData!.orgName}"),
                  ],
                ),
              ),
            ),
          )
        : Container();
  }
}
