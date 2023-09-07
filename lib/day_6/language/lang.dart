import 'package:flutter/material.dart';

class LanguageField extends StatefulWidget {
  final Function(List<String>) onLanguagesChanged;
  const LanguageField({required this.onLanguagesChanged, Key? key})
      : super(key: key);

  @override
  State<LanguageField> createState() => _LanguageFieldState();
}

class _LanguageFieldState extends State<LanguageField> {
  List<Map<String, dynamic>> availableLanguage = [
    {
      'name': 'Nepali',
      'isChecked': false,
    },
    {
      'name': 'English',
      'isChecked': false,
    },
    {
      'name': 'Hindi',
      'isChecked': false,
    },
    {
      'name': 'Arabic',
      'isChecked': false,
    },
  ];
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 8),
      child: Container(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Padding(
              padding: const EdgeInsets.all(18.0),
              child: Text(
                "Languages",
                style: TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.w500,
                ),
              ),
            ),
            SingleChildScrollView(
              scrollDirection: Axis.vertical,
              child: Row(
                children: availableLanguage.map((language) {
                  return Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        Checkbox(
                          activeColor: Colors.orangeAccent.shade700,
                          value: language['isChecked'],
                          onChanged: (newValue) {
                            setState(() {
                              language['isChecked'] = newValue;
                              final selectedLanguages = availableLanguage
                                  .where((language) => language['isChecked'])
                                  .map((language) => language['name'])
                                  .toList()
                                  .cast<String>();
                              widget.onLanguagesChanged(selectedLanguages);
                            });
                          },
                        ),
                        Text(
                          language['name'],
                        )
                      ]);
                }).toList(),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
