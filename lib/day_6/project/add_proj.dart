import 'package:day_6_cv/day_6/project/pro_field.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class AddOtherProject extends StatefulWidget {
  const AddOtherProject({super.key});

  @override
  State<AddOtherProject> createState() => _AddOtherProjectState();
}

enum org { Yes, No }

extension OrgExtension on org {
  String get orgStringValue {
    switch (this) {
      case org.Yes:
        return 'Yes';
      case org.No:
        return 'No';
      default:
        return '';
    }
  }
}

class _AddOtherProjectState extends State<AddOtherProject> {
  org? organizationValue = org.Yes;

  TextEditingController orgNameController = TextEditingController();
  TextEditingController titleController = TextEditingController();
  TextEditingController descriptionController = TextEditingController();
  final GlobalKey<FormState> _projectKey = GlobalKey<FormState>();

  String _pStartDate = "";
  String _pEndDate = "";
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          title: Text("Projects"),
          backgroundColor: Colors.deepOrangeAccent.shade200,
          elevation: 1,
        ),
        body: SingleChildScrollView(
          child: Container(
            child: Padding(
              padding: const EdgeInsets.all(14.0),
              child: Form(
                key: _projectKey,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text("Project Title",
                        style: TextStyle(
                            fontWeight: FontWeight.w400, fontSize: 16)),
                    SizedBox(
                      height: 10,
                    ),
                    TextFormField(
                      controller: titleController,
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return "This Field cannot be Empty";
                        } else if (RegExp(r'[^a-zA-Z ]').hasMatch(value)) {
                          return "Please Enter Only Texts";
                        } else if (orgNameController.text.length > 10) {
                          return "Only 10 Characters are valid";
                        }
                        return null;
                      },
                      decoration: InputDecoration(
                        hintText: "Project Title ",
                        enabledBorder: OutlineInputBorder(
                          borderSide: BorderSide(color: Colors.black),
                          borderRadius: BorderRadius.circular(12.0),
                        ),
                        focusedBorder: OutlineInputBorder(
                          borderSide:
                              BorderSide(color: Colors.orangeAccent.shade700),
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
                    SizedBox(
                      height: 12,
                    ),
                    Text("Description"),
                    SizedBox(
                      height: 12,
                    ),
                    TextFormField(
                      controller: descriptionController,
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return "This Field cannot be Empty";
                        } else if (RegExp(r'[^a-zA-Z ]').hasMatch(value)) {
                          return "Please Enter Only Texts";
                        } else if (orgNameController.text.length > 100) {
                          return "Limited to 100 Characters ";
                        }
                        return null;
                      },
                      maxLines: 4,
                      decoration: InputDecoration(
                        hintText: "Add Description",
                        enabledBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(12),
                          borderSide: BorderSide(color: Colors.black),
                        ),
                        focusedBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(12),
                          borderSide:
                              BorderSide(color: Colors.orangeAccent.shade700),
                        ),
                        errorBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(12),
                          borderSide: BorderSide(color: Colors.black),
                        ),
                        focusedErrorBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(12),
                          borderSide: BorderSide(color: Colors.black),
                        ),
                      ),
                    ),
                    SizedBox(
                      height: 18,
                    ),
                    Row(
                      children: [
                        Text("Start Date"),
                        Spacer(),
                        Text("End Date"),
                      ],
                    ),
                    Padding(
                      padding: const EdgeInsets.all(16.0),
                      child: Row(
                        children: [
                          GestureDetector(
                            child: Icon(
                              Icons.calendar_today,
                              size: 45,
                            ),
                            onTap: () async {
                              DateTime? pickedDate = await showDatePicker(
                                context: context,
                                initialDate: DateTime.now(),
                                firstDate: DateTime(2000),
                                lastDate: DateTime.now(),
                              );
                              String formattedDate =
                                  DateFormat(DateFormat.YEAR_MONTH_DAY)
                                      .format(pickedDate!);
                              setState(() {
                                _pStartDate = formattedDate.toString();
                              });
                            },
                          ),
                          Spacer(),
                          GestureDetector(
                            child: Icon(
                              Icons.calendar_today,
                              size: 45,
                            ),
                            onTap: () async {
                              DateTime? endDatePicked = await showDatePicker(
                                context: context,
                                initialDate: DateTime.now(),
                                firstDate: DateTime(2000),
                                lastDate: DateTime(2023, 12, 31),
                              );
                              String formattedEndDate =
                                  DateFormat(DateFormat.YEAR_MONTH_DAY)
                                      .format(endDatePicked!);
                              setState(() {
                                _pEndDate = formattedEndDate.toString();
                              });
                            },
                          ),
                        ],
                      ),
                    ),
                    Row(
                      children: [
                        Text(_pStartDate),
                        Spacer(),
                        Text(_pEndDate),
                      ],
                    ),
                    Row(
                      children: [
                        Text("Linked With Organization ?",
                            style: TextStyle(
                                fontWeight: FontWeight.w400, fontSize: 16)),
                        Radio(
                          value: org.Yes,
                          groupValue: organizationValue,
                          onChanged: (value) {
                            setState(() {
                              organizationValue = value;
                              print(organizationValue?.orgStringValue);
                            });
                          },
                        ),
                        Text("Yes"),
                        Radio(
                          value: org.No,
                          groupValue: organizationValue,
                          onChanged: (value) {
                            setState(() {
                              organizationValue = value;
                              print(organizationValue?.orgStringValue);
                            });
                          },
                        ),
                        Text("No"),
                      ],
                    ),
                    SizedBox(
                      height: 5,
                    ),
                    Visibility(
                      visible: organizationValue == org.Yes,
                      child: Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text("Organization Name",
                                style: TextStyle(
                                    fontWeight: FontWeight.w400, fontSize: 16)),
                            const SizedBox(
                              height: 12.0,
                            ),
                            TextFormField(
                              validator: (value) {
                                if (value == null || value.isEmpty) {
                                  return "Please enter organization name";
                                } else if (RegExp(r'[^a-zA-Z ]')
                                    .hasMatch(value)) {
                                  return "It only accepts text";
                                } else if (orgNameController.text.length > 10) {
                                  return "Words cannot be more than 10";
                                }
                                return null;
                              },
                              controller: orgNameController,
                              decoration: InputDecoration(
                                hintText: "Organization Name",
                                enabledBorder: OutlineInputBorder(
                                  borderSide: BorderSide(color: Colors.black),
                                  borderRadius: BorderRadius.circular(15.0),
                                ),
                                focusedBorder: OutlineInputBorder(
                                  borderSide: BorderSide(
                                      color: Colors.orangeAccent.shade700),
                                  borderRadius: BorderRadius.circular(15.0),
                                ),
                                errorBorder: OutlineInputBorder(
                                  borderSide: BorderSide(color: Colors.black),
                                  borderRadius: BorderRadius.circular(15.0),
                                ),
                                focusedErrorBorder: OutlineInputBorder(
                                  borderSide: BorderSide(color: Colors.black),
                                  borderRadius: BorderRadius.circular(15.0),
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                    const SizedBox(
                      height: 25.0,
                    ),
                    Align(
                      alignment: Alignment.center,
                      child: ElevatedButton(
                        style: ElevatedButton.styleFrom(
                          backgroundColor: Colors.orange.shade500,
                          fixedSize: const Size(180, 50),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(17.0),
                          ),
                        ),
                        onPressed: () {
                          if (_projectKey.currentState!.validate()) {
                            final newProject = ProjectData(
                              projectTitle: titleController.text,
                              pDescription: descriptionController.text,
                              startDate: _pStartDate,
                              endDate: _pEndDate,
                              orgName: orgNameController.text,
                            );
                            Navigator.pop(context, newProject);
                            showDialog(
                              context: context,
                              builder: (context) => AlertDialog(
                                title: Text("Project added"),
                                backgroundColor: Colors.purple.shade400,
                                icon: Icon(
                                  Icons.check_circle,
                                  size: 45,
                                ),
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(17.0),
                                ),
                                iconColor: Colors.white,
                                titleTextStyle: TextStyle(
                                    color: Colors.white, fontSize: 25),
                              ),
                            );
                          }
                        },
                        child: Text("ADD"),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
