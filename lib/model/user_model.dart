class UserModel {
  String? email;
  String? name;
  String? password;
  String? uID;
  String? phoneNumber;
  String?image;
  bool? isEmailVerified;
  bool? isPhoneVerified;

  UserModel(
      {this.email,
      this.name,
      this.password,
      this.image,
      this.uID,
      this.phoneNumber,
      this.isEmailVerified,
      this.isPhoneVerified});

  UserModel.fromJson(Map<String, dynamic> json) {
    email = json['Email'];
    image=json['image']??"";
    name = json['Name'];
    password = json['Password'];
    uID = json['UID'];
    isEmailVerified = json['isEmailVerified'];
    isPhoneVerified = json['isPhoneVerified'];
    phoneNumber = json['phoneNumber'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = Map<String, dynamic>();
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
