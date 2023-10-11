import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:social_app/Model/postModel.dart';
import 'package:social_app/Model/user_Model.dart';
import 'package:social_app/User_Profile/addpost.dart';
import 'package:social_app/User_Profile/profilescrn.dart';
import 'package:social_app/User_Profile/seeuserprof.dart';
import 'package:social_app/pages/signup.dart';

UserModel? loginUsers;

class HomeScreen extends StatefulWidget {
  final List<UserModel> usersData;
  const HomeScreen({super.key, required this.usersData});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

Future<void> _refresh() {
  return Future.delayed(
    const Duration(seconds: 3),
  );
}

class _HomeScreenState extends State<HomeScreen> {
  List<PostModel> userPostData = [];

  Future<List<String>> getProfileData() async {
    SharedPreferences pref = await SharedPreferences.getInstance();
    String? profileString = pref.getString('profileData');

    if (profileString != null) {
      try {
        final decodeprofileData = json.decode(profileString) as List<dynamic>;
        setState(() {
          userPostData =
              decodeprofileData.map((e) => PostModel.fromJson(e)).toList();
        });
      } catch (e) {
        rethrow;
      }
    } else {
      userPostData = [];
    }
    return [];
  }

  Future<List<String>> getUserId() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String? userIdData = prefs.getString('userID');

    if (userIdData != null) {
      try {
        // final decodedData = json.decode(userIdData) as List<dynamic>;
        loginUsers = widget.usersData.firstWhere(
          (user) => user.id.toString() == userIdData,
        );
      } catch (e) {
        rethrow;
      }
    } else {
      loginUsers;
    }
    return [];
  }

  void ready() async {
    await getUserId();
    await getProfileData();
  }

  @override
  void initState() {
    ready();
    super.initState();
  }

  Future<void> userLike(String postId) async {
    setState(
      () {
        final postIndex =
            userPostData.indexWhere((post) => post.postId == postId);
        if (postIndex != -1) {
          if (userPostData[postIndex].postLikedBy.contains(loginUsers!.id)) {
            userPostData[postIndex].postLikedBy.remove(loginUsers!.id);
          } else {
            userPostData[postIndex].postLikedBy.add(loginUsers!.id.toString());
          }
        }
      },
    );
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String updatedPosts = jsonEncode(userPostData);
    prefs.setString('profileData', updatedPosts);
    getProfileData();
  }

  UserModel? postIdDetails;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: Text(
          "Waana Chat?",
          style: GoogleFonts.lato(
            textStyle: TextStyle(
              fontSize: 24,
              wordSpacing: 2.8,
              fontWeight: FontWeight.bold,
              // You can set other text styles here if needed
            ),
          ),
        ),
      ),
      body: SingleChildScrollView(
        child: RefreshIndicator(
          onRefresh: _refresh,
          child: Column(
            children: [
              SizedBox(
                height: 8,
              ),
              Padding(
                padding: const EdgeInsets.all(10.0),
                child: Row(
                  children: [
                    GestureDetector(
                      onTap: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => ProfileScreen(),
                          ),
                        );
                      },
                      child: Stack(
                        children: [
                          Container(
                            height: 60,
                            width: 60,
                            decoration: BoxDecoration(
                              shape: BoxShape.circle,
                              border: Border.all(
                                  color: Colors.blue.shade400, width: 4),
                            ),
                            child: ClipOval(
                              child: loginUsers != null &&
                                      loginUsers?.image != null &&
                                      loginUsers?.image?.path != ""
                                  ? Image(
                                      height: 60,
                                      width: 60,
                                      image: FileImage(loginUsers!.image!),
                                      fit: BoxFit.cover,
                                    )
                                  : Center(
                                      child: Image(
                                        height: 60,
                                        width: 60,
                                        fit: BoxFit.cover,
                                        image: AssetImage(
                                            '${loginUsers?.imageUrl}'),
                                      ),
                                    ),
                            ),
                          ),
                          Positioned(
                            bottom: 2,
                            right: 2,
                            child: Container(
                              height: 13,
                              width: 13,
                              decoration: BoxDecoration(
                                shape: BoxShape.circle,
                                color: Colors.greenAccent.shade400,
                                border:
                                    Border.all(color: Colors.white, width: 1),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                    SizedBox(
                      width: 8,
                    ),
                    Expanded(
                      child: InkWell(
                        onTap: () {
                          Navigator.pushReplacement(
                            context,
                            MaterialPageRoute(
                              builder: (context) => AddPost(
                                loginUsers: loginUsers,
                              ),
                            ),
                          );
                        },
                        child: Container(
                          height: 55,
                          decoration: BoxDecoration(
                            borderRadius:
                                BorderRadius.circular(5.0), // Rounded corners
                            border: Border.all(
                                color: Colors.black, width: 1.5), // Border
                            shape: BoxShape.rectangle,
                            gradient: LinearGradient(
                              colors: const [
                                Colors.blue,
                                Colors.orange,
                                Colors.redAccent
                              ],
                              begin: Alignment.centerLeft,
                              end: Alignment.centerRight,
                            ),
                            boxShadow: [
                              BoxShadow(
                                color: Colors.grey.withOpacity(0.5),
                                spreadRadius: 2,
                                blurRadius: 5,
                                offset: Offset(0, 3),
                              ),
                            ],
                          ),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: const [
                              Icon(
                                Icons.comment_sharp,
                                color: Colors
                                    .black, // Icon color matches the text color
                              ),
                              SizedBox(width: 8),
                              Text(
                                "What's on your mind !",
                                style: TextStyle(
                                  fontWeight: FontWeight.w500,
                                  fontSize: 21,
                                  color: Colors
                                      .white, // Text color matches the icon color
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              ListView.builder(
                shrinkWrap: true,
                reverse: true,
                physics: const NeverScrollableScrollPhysics(),
                itemCount: userPostData.length,
                itemBuilder: (BuildContext context, int index) {
                  var data = userPostData[index];
                  postIdDetails = widget.usersData
                      .firstWhere((user) => user.id == data.userId);

                  return Padding(
                    padding: const EdgeInsets.all(10.0),
                    child: Card(
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(16),
                      ),
                      elevation: 4,
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Padding(
                            padding: const EdgeInsets.all(16),
                            child: GestureDetector(
                              onTap: () {
                                Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                    builder: (context) => seeuserpro(
                                      // ignore: unnecessary_string_interpolations
                                      id: '${data.userId}',
                                    ),
                                  ),
                                );
                              },
                              child: Row(
                                children: [
                                  CircleAvatar(
                                    radius: 20,
                                    backgroundImage:
                                        postIdDetails?.image?.path != ""
                                            ? FileImage(postIdDetails!.image!)
                                                as ImageProvider<Object>
                                            : NetworkImage(
                                                "https://images3.alphacoders.com/133/thumbbig-1334089.webp",
                                              ),
                                  ),
                                  const SizedBox(width: 16),
                                  Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Text(
                                        '${postIdDetails!.fullname}',
                                        style: const TextStyle(
                                          fontSize: 18,
                                          fontWeight: FontWeight.bold,
                                        ),
                                      ),
                                      Text(
                                        data.createdAt,
                                        style: const TextStyle(
                                          fontSize: 14,
                                          color: Color.fromARGB(
                                              255, 109, 100, 100),
                                        ),
                                      ),
                                    ],
                                  ),
                                ],
                              ),
                            ),
                          ),
                          if (data.description != "")
                            Padding(
                              padding:
                                  const EdgeInsets.symmetric(horizontal: 16),
                              child: Text(
                                data.description,
                                style: const TextStyle(
                                  fontSize: 16,
                                  color: Colors.black,
                                ),
                              ),
                            ),
                          Container(
                            height: 400,
                            width: double.infinity,
                            margin: const EdgeInsets.symmetric(
                                horizontal: 16, vertical: 8),
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(16),
                              image: data.image?.path != ""
                                  ? DecorationImage(
                                      image: FileImage(data.image!),
                                      fit: BoxFit.cover,
                                    )
                                  : const DecorationImage(
                                      image: NetworkImage(
                                          "https://images3.alphacoders.com/133/thumbbig-1334089.webp"),
                                      fit: BoxFit.cover),
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.all(16),
                            child: Row(
                              children: [
                                IconButton(
                                  onPressed: () {
                                    setState(() async {
                                      await userLike(data.postId);
                                    });
                                  },
                                  icon: Icon(
                                    data.postLikedBy.contains(loginUsers!.id)
                                        ? Icons.favorite
                                        : Icons.favorite_border,
                                    color: data.postLikedBy
                                            .contains(loginUsers!.id)
                                        ? Colors.red
                                        : Colors.grey.shade700,
                                  ),
                                ),
                                Text(
                                  '${data.postLikedBy.length}',
                                  style: const TextStyle(fontSize: 16),
                                ),
                                const SizedBox(width: 8),
                                Text(
                                  'Likes',
                                  style: const TextStyle(fontSize: 16),
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                    ),
                  );
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}
