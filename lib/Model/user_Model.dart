// ignore: file_names
import 'dart:io';

class UserModel {
  String? id;
  String? fullname;
  String? email;
  String? mobilenumber;
  String? gender;
  String? dob;
  String? password;
  String? martialStatus;
  File? image;
  String? imageUrl;

  UserModel(
      {required this.id,
      required this.fullname,
      required this.email,
      required this.mobilenumber,
      required this.gender,
      required this.dob,
      required this.password,
      required this.martialStatus,
      required this.image,
      this.imageUrl});

  Map<String, dynamic> toJson() {
    String imagePath = image != null ? image!.path : "";
    return {
      "id": id,
      "fullname": fullname,
      "email": email,
      "mobilenumber": mobilenumber,
      "gender": gender,
      "dob": dob,
      "password": password,
      "martialStatus": martialStatus,
      "image": imagePath,
      "imageUrl": imageUrl,
    };
  }

  factory UserModel.fromJson(Map<String, dynamic> json) {
    String imagePath = json["image"] ?? "";
    return UserModel(
      id: json["id"],
      fullname: json["fullname"],
      email: json["email"],
      mobilenumber: json["mobilenumber"],
      gender: json["gender"],
      dob: json["dob"],
      password: json["password"],
      martialStatus: json["martialStatus"],
      image: File(imagePath),
      imageUrl: json["imageUrl"],
    );
  }
  toLowerCase() {}
}

List<UserModel> signupList = [];
