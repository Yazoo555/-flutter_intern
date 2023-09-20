class Usermodel {
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
  String? pdf;

  Usermodel({
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
    this.pdf,
  });

  Map<String, dynamic> toJson() {
    return {
      'image': image, // Include the image field in toJson
      'image2': image2, // Include the image2 field in toJson

      'userid': userid,
      'fullname': fullname,
      'gender': gender,
      'dateofbirth': dateofbirth,
      'mobilenumber': mobilenumber,
      'martialstatus': martialstatus,
      'email': email,
      'password': password,
      'pdf': pdf, // Include the pdf field in toJson
    };
  }

  factory Usermodel.fromJson(Map<String, dynamic> json) {
    return Usermodel(
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
      pdf: json['pdf'], // Get the pdf field from json
    );
  }
}

List<Usermodel> signuplist = [];
