class UserModel {
  String? email;
  String? name;
  String? password;
  String? uID;
  String? phoneNumber;
  bool? isEmailVerified;
  bool? isPhoneVerified;

  UserModel(
      {this.email,
      this.name,
      this.password,
      this.uID,
      this.phoneNumber,
      this.isEmailVerified,
      this.isPhoneVerified});

  UserModel.fromJson(Map<String, dynamic> json) {
    email = json['Email'];
    name = json['Name'];
    password = json['Password'];
    uID = json['UID'];
    isEmailVerified = json['isEmailVerified'];
    isPhoneVerified = json['isPhoneVerified'];
    phoneNumber = json['phoneNumber'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['Email'] = this.email;
    data['Name'] = this.name;
    data['Password'] = this.password;
    data['UID'] = this.uID;
    data['isEmailVerified'] = this.isEmailVerified;
    data['isPhoneVerified'] = this.isPhoneVerified;
    data['phoneNumber'] = this.phoneNumber;
    return data;
  }
}
