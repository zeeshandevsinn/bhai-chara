import 'package:cloud_firestore/cloud_firestore.dart';

class UserModel {
  String? email;
  String? name;
  String? password;
  String? uID;
  String? phoneNumber;
  String?image;
  bool? isEmailVerified;
  bool? isPhoneVerified;
  String ?createdTime;
  int?lat;
  int?long;

  UserModel(
      {this.email,
      this.name,
      this.lat,
      this.long,
      this.password,
      this.image,
      this.uID,
      this.phoneNumber,
      this.isEmailVerified,
      this.createdTime,
      this.isPhoneVerified});

  UserModel.fromJson(Map<String, dynamic> json) {
    lat=json['latitude'];
    long=json['longitude'];
    email = json['Email'];
    image=json['image']??"";
    name = json['Name'];
    password = json['Password'];
    uID = json['UID'];
    isEmailVerified = json['isEmailVerified'];
    isPhoneVerified = json['isPhoneVerified'];
    phoneNumber = json['phoneNumber'];
    createdTime=json['createdTime'].toString();

  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = Map<String, dynamic>();
    data['createdTime']=createdTime;
    data['latitude']=lat;
    data['longitude']=long;
    data['Email'] = email;
    data['image']=image;
    data['Name'] = name;
    data['Password'] = password;
    data['UID'] = uID;
    data['isEmailVerified'] = isEmailVerified;
    data['isPhoneVerified'] = isPhoneVerified;
        data['phoneNumber'] = this.phoneNumber;
    return data;
  }
}
