import 'package:flutter/material.dart';

class EducationData {
  final String orgName;
  final String level;
  final String startDate;
  final String endDate;
  final String achievments;
  EducationData({
    required this.orgName,
    required this.level,
    required this.startDate,
    required this.endDate,
    required this.achievments,
  });
  Map<String, dynamic> toJson() {
    return {
      'orgName': orgName,
      'level': level,
      'startDate': startDate,
      'endDate': endDate,
      'achievements': achievments,
    };
  }

  factory EducationData.fromJson(Map<String, dynamic> json) {
    return EducationData(
      orgName: json['orgName'],
      level: json['level'],
      startDate: json['startDate'],
      endDate: json['endDate'],
      achievments: json['achievements'].toString(),
    );
  }
}

class EducationField extends StatelessWidget {
  final EducationData? educationData;
  final VoidCallback deleteOnTap;
  const EducationField(
      {this.educationData, required this.deleteOnTap, Key? key})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    // ignore: unnecessary_null_comparison
    return EducationData != null
        ? Padding(
            padding: const EdgeInsets.only(left: 8.0, right: 8.0, bottom: 8.0),
            child: Container(
              decoration: BoxDecoration(
                border: Border.all(color: Colors.black),
                borderRadius: BorderRadius.circular(18.0),
              ),
              width: double.infinity,
              child: Padding(
                padding: const EdgeInsets.only(left: 8.0, right: 8.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      children: [
                        Text("Organizaton Name: ${educationData!.orgName}"),
                        Spacer(),
                        GestureDetector(
                          child: Icon(
                            Icons.delete,
                            color: Colors.orange.shade700,
                          ),
                          onTap: deleteOnTap,
                        )
                      ],
                    ),
                    Text("Level: ${educationData!.level}"),
                    Text("Start Date: ${educationData!.startDate}"),
                    Text("End Date: ${educationData!.endDate}"),
                    Text("Achievements: ${educationData!.achievments}"),
                  ],
                ),
              ),
            ),
          )
        : Container();
  }
}
