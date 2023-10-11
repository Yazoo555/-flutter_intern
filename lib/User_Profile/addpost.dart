import 'dart:convert';
import 'dart:io';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:social_app/Model/postModel.dart';
import 'package:social_app/Model/user_Model.dart';
import 'package:social_app/pages/mainscr.dart';
// ignore: depend_on_referenced_packages
import 'package:image_picker/image_picker.dart';
import 'package:social_app/pages/signup.dart';
import 'package:uuid/uuid.dart';

class AddPost extends StatefulWidget {
  final UserModel? loginUsers;
  const AddPost({super.key, required this.loginUsers});

  @override
  State<AddPost> createState() => _AddPostState();
}

class _AddPostState extends State<AddPost> {
  File? postImage;
  final ImagePicker picker = ImagePicker();
  //

  Future<void> takePhoto() async {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text("Choose an Option"),
          content: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              TextButton(
                onPressed: () {
                  Navigator.of(context).pop();
                  _getImage(ImageSource.camera);
                },
                child: Text(
                  "Camera",
                  style: TextStyle(fontSize: 18, color: Colors.amber.shade800),
                ),
              ),
              TextButton(
                onPressed: () {
                  Navigator.of(context).pop();
                  _getImage(ImageSource.gallery);
                },
                child: Text(
                  "Gallery",
                  style: TextStyle(fontSize: 18, color: Colors.green.shade800),
                ),
              ),
            ],
          ),
        );
      },
    );
  }

  Future<void> _getImage(ImageSource source) async {
    try {
      final pickedProfile = await picker.pickImage(source: source);
      if (pickedProfile == null) return;
      String imagePath = pickedProfile.path;
      File? img = File(imagePath);
      setState(() {
        postImage = img;
      });
    } on PlatformException {
      // Handle any exceptions here
    }
  }

  Map<String, dynamic> profileEmptyList = {};
  void postDetails() async {
    SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
    String? jsonString = sharedPreferences.getString('profileData');
    if (jsonString != null) {
      try {
        final jsonData = jsonDecode(jsonString);

        if (jsonData is List<dynamic>) {
          postList = jsonData.map((json) => PostModel.fromJson(json)).toList();
        } else if (jsonData is Map<String, dynamic>) {
          postList.add(PostModel.fromJson(jsonData));
        }
      } catch (e) {
        rethrow;
      }
    }
    postList.add(
      PostModel(
        postId: const Uuid().v4(),
        userId: widget.loginUsers!.id ?? " ",
        createdAt: DateTime.now().toString(),
        description: descController.text,
        image: postImage!,
        postLikedBy: [],
      ),
    );
    List<Map<String, dynamic>> profileDataList =
        postList.map((e) => e.toJson()).toList();
    String profileData = jsonEncode(profileDataList);
    sharedPreferences.setString('profileData', profileData);
  }

  final dkey = GlobalKey<FormState>();
  TextEditingController descController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      appBar: AppBar(
        leading: IconButton(
          icon: Icon(Icons.arrow_back),
          onPressed: () {
            Navigator.pushReplacement(
              context,
              MaterialPageRoute(
                builder: (context) => MainScreen(),
              ),
            );
          },
        ),
        backgroundColor: Colors.indigoAccent,
        title: Text(
          "Add Your Post",
          style: TextStyle(
            fontSize: 24,
            color: Colors.white,
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
      floatingActionButton: FloatingActionButton.extended(
        elevation: 5,
        onPressed: () {
          takePhoto();
        },
        icon: const Icon(Icons.add_a_photo),
        label: const Text('\t Add Image'),
        backgroundColor: Colors.indigoAccent,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Form(
          key: dkey,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                "Description",
                style: TextStyle(
                  fontSize: 20,
                  color: Colors.indigoAccent,
                  fontWeight: FontWeight.bold,
                ),
              ),
              const SizedBox(height: 10),
              TextFormField(
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return "Please enter a description";
                  }
                  return null; // Return null if validation succeeds
                },
                maxLines: 3,
                maxLength: 250,
                decoration: InputDecoration(
                  labelText: 'What\'s On Your Mind?',
                  hintText: 'Express Here',
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(12),
                  ),
                ),
                controller: descController,
              ),
              const SizedBox(height: 20),
              Container(
                height: 250,
                width: double.infinity,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(25),
                  color: Colors.grey.shade300,
                ),
                child: Center(
                  child: postImage == null
                      ? Text(
                          'Add Image',
                          style: TextStyle(fontSize: 20, color: Colors.black54),
                        )
                      : Image(
                          height: 300,
                          width: double.infinity,
                          image: FileImage(postImage!),
                          fit: BoxFit.cover,
                        ),
                ),
              ),
              SizedBox(
                height: 25,
              ),
              Center(
                child: ElevatedButton(
                  onPressed: () {
                    if (dkey.currentState!.validate()) {
                      setState(
                        () {
                          postDetails();
                          Navigator.pushReplacement(
                            context,
                            MaterialPageRoute(
                              builder: (context) => const MainScreen(),
                            ),
                          );
                        },
                      );
                    }
                  },
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.green,
                    elevation: 2, // Add elevation for a raised effect
                    shape: RoundedRectangleBorder(
                      borderRadius:
                          BorderRadius.circular(10), // Customize button shape
                    ),
                  ),
                  child: Container(
                    alignment: Alignment.center,
                    width: 160,
                    height: 60,
                    child: Text(
                      "POST",
                      style: TextStyle(
                        fontSize: 18,
                        color: Colors.white,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
