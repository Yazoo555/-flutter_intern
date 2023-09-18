// import 'dart:io';

class Usermodel {
  // File gallerypic;
  // File camerapic;
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
    //   required this.camerapic,
    // required this.gallerypic,
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

    return {
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

    return Usermodel(
      // gallerypic: File(imagepath),
      // camerapic: File(coverpath),
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
