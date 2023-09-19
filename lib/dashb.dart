import 'package:flutter/material.dart';
import 'package:day_seven/model.dart';
import 'package:flutter/rendering.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'dart:io';
import 'package:syncfusion_flutter_pdfviewer/pdfviewer.dart'; // Import your Usermodel class

class Dashboard extends StatefulWidget {
  final Usermodel userData;

  const Dashboard({required this.userData, Key? key}) : super(key: key);

  @override
  State<Dashboard> createState() => _DashboardState();
}

class _DashboardState extends State<Dashboard> {
  File? imageFile;
  File? image2File;
  File? selectedPdfFile;

  @override
  void initState() {
    super.initState();
    // Load the user's images as File objects
    imageFile =
        widget.userData.image != null ? File(widget.userData.image!) : null;
    image2File =
        widget.userData.image2 != null ? File(widget.userData.image2!) : null;
    selectedPdfFile =
        widget.userData.pdf != null ? File(widget.userData.pdf!) : null;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("This is Dashboard"),
      ),
      body: Center(
        child: Padding(
          padding: const EdgeInsets.all(12.0),
          child: Column(
            children: [
              Text(
                "Welcome: ${widget.userData.fullname}",
                style:
                    const TextStyle(fontSize: 30, fontWeight: FontWeight.bold),
              ),

              const SizedBox(
                height: 15,
              ),

              Text(
                "Full Name: ${widget.userData.fullname}",
                style: const TextStyle(fontSize: 18),
              ),
              Text(
                "Email: ${widget.userData.email}",
                style: const TextStyle(fontSize: 18),
              ),
              Text(
                "Date of Birth: ${widget.userData.dateofbirth}",
                style: const TextStyle(fontSize: 18),
              ),
              Text(
                "Gender: ${widget.userData.gender}",
                style: const TextStyle(fontSize: 18),
              ),
              Text(
                "Mobile Number: ${widget.userData.mobilenumber}",
                style: const TextStyle(fontSize: 18),
              ),
              Text(
                "Marital Status: ${widget.userData.martialstatus}",
                style: const TextStyle(fontSize: 18),
              ),
              // Add more fields as needed
              const SizedBox(
                height: 25,
              ),

              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Row(
                  children: [
                    if (imageFile != null)
                      Image.file(
                        imageFile!,
                        width: 150,
                        height: 150,
                      ),
                    if (image2File != null)
                      Image.file(
                        image2File!,
                        width: 150,
                        height: 150,
                      ),
                  ],
                ),
              ),
              SizedBox(
                height: 15,
              ),
              if (selectedPdfFile != null)
                ElevatedButton(
                  onPressed: () async {
                    // Retrieve the PDF file path from shared preferences
                    SharedPreferences sharedPreferences =
                        await SharedPreferences.getInstance();
                    String? pdfPath = sharedPreferences.getString('pdfPath');
                    if (pdfPath != null) {
                      // Load the PDF file using the path
                      File pdfFile = File(pdfPath);

                      // Navigate to the PDF viewer page
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => PdfViewerPage(pdfFile: pdfFile),
                        ),
                      );
                    }
                  },
                  child: Text("Open PDF"),
                ),
            ],
          ),
        ),
      ),
    );
  }
}

class PdfViewerPage extends StatelessWidget {
  final File pdfFile;

  const PdfViewerPage({required this.pdfFile, Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("PDF Viewer"),
      ),
      body: Column(
        children: [
          if (pdfFile != null)
            Container(
              height: 500,
              child: SfPdfViewer.file(pdfFile),
            )
        ],
      ),
    );
  }
}
