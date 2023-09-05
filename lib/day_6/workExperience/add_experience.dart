import 'package:day_6_cv/day_6/workExperience/work_experience.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class AddWorkExperience extends StatefulWidget {
  const AddWorkExperience({super.key});

  @override
  State<AddWorkExperience> createState() => _AddWorkExperienceState();
}

class _AddWorkExperienceState extends State<AddWorkExperience> {
  final GlobalKey<FormState> _experienceKey = GlobalKey<FormState>();

  String _startDate = '';
  String _endDate = '';
  TextEditingController jobController = TextEditingController();
  TextEditingController summaryController = TextEditingController();
  TextEditingController companyNameController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
          title: Text("Work Experiences"),
          centerTitle: true,
          elevation: .6,
          backgroundColor: Colors.deepOrangeAccent.shade200),
      body: Column(
        children: [
          Text("Job Title"),
          SizedBox(
            height: 8,
          ),
          Form(
            key: _experienceKey,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                TextFormField(
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'This field cannot be null';
                    } else if (jobController.text.length > 10) {
                      return 'Should be only 10 characters';
                    }
                    return null;
                  },
                  controller: jobController,
                  decoration: InputDecoration(
                    hintText: "Job - Title",
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
                  height: 10,
                ),
                Text("Summary"),
                SizedBox(
                  height: 10,
                ),
                TextFormField(
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return "This field cannot be empty";
                    } else if (summaryController.text.length > 100) {
                      return "Only limited to 100 characters";
                    }
                    return null;
                  },
                  controller: summaryController,
                  maxLines: 7,
                  decoration: InputDecoration(
                    hintText: "Summary Info",
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
                  height: 10,
                ),
                Text("Company Name"),
                SizedBox(
                  height: 10,
                ),
                TextFormField(
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return "This field cannot be empty";
                    } else if (companyNameController.text.length > 10) {
                      return "Should be only 10 characters";
                    }
                    return null;
                  },
                  controller: companyNameController,
                  maxLines: 7,
                  decoration: InputDecoration(
                    hintText: "Company Name",
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
                  height: 10,
                ),
                Row(
                  children: [
                    Text("Start Date"),
                    Spacer(),
                    Text("End Date"),
                  ],
                ),
                Row(
                  children: [
                    InkWell(
                      child: Icon(Icons.calendar_today, size: 40),
                      splashColor: Colors.blue.shade400,
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
                          _startDate = formattedDate.toString();
                        });
                      },
                    ),
                    Spacer(),
                    InkWell(
                      child: Icon(Icons.calendar_today, size: 40),
                      splashColor: Colors.blue.shade400,
                      onTap: () async {
                        DateTime? pickedDate = await showDatePicker(
                          context: context,
                          initialDate: DateTime.now(),
                          firstDate: DateTime(2000),
                          lastDate: DateTime(2023, 12, 31),
                        );
                        String formattedEndDate =
                            DateFormat(DateFormat.YEAR_MONTH_DAY)
                                .format(pickedDate!);
                        setState(() {
                          _startDate = formattedEndDate.toString();
                        });
                      },
                    ),
                  ],
                ),
                Row(
                  children: [Text(_startDate), Spacer(), Text(_endDate)],
                ),
                SizedBox(
                  height: 12,
                ),
                Align(
                  alignment: Alignment.center,
                  child: ElevatedButton(
                    style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.black,
                        fixedSize: const Size(200, 50),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(18.0),
                        )),
                    onPressed: () {
                      if (_experienceKey.currentState!.validate()) {
                        WorkExperienceData newWorkExperience =
                            WorkExperienceData(
                          companyName: companyNameController.text,
                          jobTitle: jobController.text,
                          summary: summaryController.text,
                          startDate: _startDate,
                          endDate: _endDate,
                        );
                        Navigator.pop(context, newWorkExperience);
                        //showing alert dialog when data submitted
                        showDialog(
                          context: context,
                          builder: (context) => AlertDialog(
                            title: Text("Work Expeirence Added"),
                            backgroundColor: Colors.blueGrey,
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
                      }
                    },
                    child: Text(
                      "Add",
                      style: TextStyle(fontSize: 20.0),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
