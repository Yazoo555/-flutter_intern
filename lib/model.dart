import 'dart:io';

class Usermodel {
  // File gallerypic;
  // File camerapic;
  String? image;
  String? image2;
  String? userid;
  String? fullname;
  String? gender;
  String? dateofbirth;
  String? mobilenumber;
  String? martialstatus;
  String? email;
  String? password;
  // File pdf;

  Usermodel({
    // required this.camerapic,
    // required this.gallerypic,
    this.image,
    this.image2,
    required this.userid,
    required this.fullname,
    required this.gender,
    required this.dateofbirth,
    required this.mobilenumber,
    required this.martialstatus,
    required this.email,
    required this.password,
    //   required this.pdf,
  });

  Map<String, dynamic> toJson() {
    //  String gallerypicPath = gallerypic.path;
    // String camerapicPath = camerapic.path;

    // String? imagePath = image != null ? image!.path : null;
    //  String? image2Path = image2 != null ? image2!.path : null;

    return {
      'image': image, // Include the image field in toJson
      'image2': image2, // Include the image2 field in toJson
      //  'gallerypic': gallerypicPath,
      //  'camerapic': camerapicPath,
      'userid': userid,
      'fullname': fullname,
      'gender': gender,
      'dateofbirth': dateofbirth,
      'mobilenumber': mobilenumber,
      'martialstatus': martialstatus,
      'email': email,
      'password': password,
      //  'pdf': pdf
    };
  }

  factory Usermodel.fromJson(Map<String, dynamic> json) {
    //String imagepath = json["gallerypic"] ?? "";
    // String coverpath = json["camerapic"] ?? "";
    String? imagepath = json['image'];
    String? image2path = json['image2'];

    return Usermodel(
      //  image: imagepath != null ? File(imagepath) : null,
      //  image2: image2path != null ? File(image2path) : null,
      // gallerypic: File(imagepath),
      // camerapic: File(coverpath),
      image: json['image'], // Get the image field from json
      image2: json['image2'], // Get the image2 field from json
      userid: json['userid'],
      fullname: json['fullname'],
      gender: json['gender'],
      dateofbirth: json['dateofbirth'],
      mobilenumber: json['mobilenumber'],
      martialstatus: json['martialstatus'],
      email: json['email'],
      password: json['password'],
      //   pdf: json['pdf'],
    );
  }
}

List<Usermodel> signuplist = [];
