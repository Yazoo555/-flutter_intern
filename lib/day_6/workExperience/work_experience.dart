import 'package:flutter/material.dart';

class WorkExperienceData {
  final String companyName;
  final String jobTitle;
  final String summary;
  final String startDate;
  final String endDate;
  WorkExperienceData({
    required this.companyName,
    required this.jobTitle,
    required this.summary,
    required this.startDate,
    required this.endDate,
  });
  Map<String, dynamic> toJson() {
    return {
      'companyName': companyName,
      'jobTitle': jobTitle,
      'summary': summary,
      'startDate': startDate,
      'endDate': endDate,
    };
  }

  factory WorkExperienceData.fromJson(Map<String, dynamic> json) {
    return WorkExperienceData(
      companyName: json['companyName'],
      jobTitle: json['jobTitle'],
      summary: json['summary'],
      startDate: json['startDate'].toString(),
      endDate: json['endDate'].toString(),
    );
  }
}

class WorkExperienceField extends StatelessWidget {
  final WorkExperienceData? workExperienceData;
  final VoidCallback deleteOnTap;

  const WorkExperienceField({
    super.key,
    this.workExperienceData,
    required this.deleteOnTap,
  });

  @override
  Widget build(BuildContext context) {
    return workExperienceData != null
        ? Padding(
            padding: const EdgeInsets.all(22),
            child: Container(
              width: double.infinity,
              decoration: BoxDecoration(
                border: Border.all(color: Colors.grey),
                borderRadius: BorderRadius.circular(12.0),
              ),
              child: Padding(
                padding: const EdgeInsets.only(left: 6.0, right: 6.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      children: [
                        Text("Job Title: ${workExperienceData!.jobTitle}"),
                        Spacer(),
                        GestureDetector(
                          child: Icon(
                            Icons.delete,
                            color: Colors.red,
                          ),
                          onTap: deleteOnTap,
                        ),
                      ],
                    ),
                    Text("Summary: ${workExperienceData!.summary}"),
                    Text("Company Name: ${workExperienceData!.companyName}"),
                    Text("Start Date: ${workExperienceData!.startDate}"),
                    Text("End Date: ${workExperienceData!.endDate}"),
                  ],
                ),
              ),
            ),
          )
        : Container();
  }
}
