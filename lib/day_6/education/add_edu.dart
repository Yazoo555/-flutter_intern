import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'edu_field.dart';

class AddEducation extends StatefulWidget {
  const AddEducation({super.key});

  @override
  State<AddEducation> createState() => _AddEducationState();
}

class _AddEducationState extends State<AddEducation> {
  String _eStartDate = "";
  String _eEndDate = "";
  String _dropDownValue = "SEE";

  var items = [
    "SEE",
    "+2",
    "Bachelor",
    "Masters",
    "PHD",
  ];
  TextEditingController orgNameController = TextEditingController();
  TextEditingController acheivementController = TextEditingController();
  final GlobalKey<FormState> _eduKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          title: Text("Education"),
          backgroundColor: Colors.deepOrangeAccent.shade200,
          elevation: 1,
        ),
        body: Container(
          child: Padding(
            padding: const EdgeInsets.all(14.0),
            child: Form(
              key: _eduKey,
              child: SingleChildScrollView(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      "Education",
                      style:
                          TextStyle(fontWeight: FontWeight.w400, fontSize: 16),
                    ),
                    SizedBox(
                      height: 15,
                    ),
                    TextFormField(
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return "Enter Organization Name";
                        } else if (RegExp(r'[^a-zA-Z ]').hasMatch(value)) {
                          return "Numbers are not Valid.";
                        } else if (orgNameController.text.length > 10) {
                          return "Limited to 10 Characters ";
                        }
                        return null;
                      },
                      controller: orgNameController,
                      decoration: InputDecoration(
                        hintText: "Enter Organization ",
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
                        Text("Select Level"),
                        SizedBox(
                          width: 75,
                        ),

                        // see about dropdown Button and use in multiple case scenarios

                        DropdownButton(
                          value: _dropDownValue,
                          elevation: 1,
                          dropdownColor: Colors.grey.shade200,
                          onChanged: (String? newValue) {
                            setState(() {
                              _dropDownValue = newValue!;
                            });
                          },
                          items: items.map((String items) {
                            return DropdownMenuItem(
                              value: items,
                              child: Text(items),
                            );
                          }).toList(),
                        ),
                      ],
                    ),
                    SizedBox(
                      height: 15,
                    ),
                    Padding(
                      padding: const EdgeInsets.all(18.0),
                      child: Column(
                        children: [
                          GestureDetector(
                            child: Icon(
                              Icons.calendar_today,
                              size: 40,
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
                              setState(
                                () {
                                  _eStartDate = formattedDate.toString();
                                },
                              );
                            },
                          ),
                          SizedBox(
                            height: 10,
                          ),
                          Text("Start Date:"),
                          Text(_eStartDate),
                          SizedBox(
                            height: 30,
                          ),
                          GestureDetector(
                            child: Icon(
                              Icons.calendar_today,
                              size: 40,
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
                                _eEndDate = formattedEndDate.toString();
                              });
                            },
                          ),
                          SizedBox(
                            height: 10,
                          ),
                          Text("End Date:"),
                          Text(_eEndDate),
                        ],
                      ),
                    ),
                    SizedBox(
                      height: 10,
                    ),
                    Text("Acheivements"),
                    SizedBox(
                      height: 10,
                    ),
                    TextFormField(
                      controller: acheivementController,
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return "Enter Your Acheivements";
                        } else if (RegExp(r'[^a-zA-Z ]').hasMatch(value)) {
                          return "Numbers are not Valid.";
                        } else if (acheivementController.text.length > 100) {
                          return "Limited to 100 Characters ";
                        }
                        return null;
                      },
                      maxLines: 3,
                      decoration: InputDecoration(
                        hintText: 'Write Your Acheivements Here',
                        enabledBorder: OutlineInputBorder(
                          borderSide: BorderSide(color: Colors.black),
                          borderRadius: BorderRadius.circular(12),
                        ),
                        focusedBorder: OutlineInputBorder(
                          borderSide:
                              BorderSide(color: Colors.orangeAccent.shade700),
                          borderRadius: BorderRadius.circular(12),
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
                      height: 20,
                    ),
                    Align(
                      alignment: Alignment.center,
                      child: ElevatedButton(
                        style: ElevatedButton.styleFrom(
                          backgroundColor: Colors.orange.shade500,
                          fixedSize: const Size(180, 50),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(18.0),
                          ),
                        ),
                        onPressed: () {
                          if (_eduKey.currentState!.validate()) {
                            final newEdicationData = EducationData(
                              orgName: orgNameController.text,
                              level: _dropDownValue,
                              startDate: _eStartDate,
                              endDate: _eEndDate,
                              achievments: acheivementController.text,
                            );
                            Navigator.pop(context, newEdicationData);
                            showDialog(
                              context: context,
                              builder: (context) => AlertDialog(
                                title: Text("Education background added"),
                                backgroundColor: Colors.purple.shade400,
                                icon: Icon(
                                  Icons.check_circle_outline,
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
                    )
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
