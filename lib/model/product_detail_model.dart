import 'package:bhai_chara/view/home-screens/mapScreen.dart';

class ProductDetailModel {
  String? price;
  String? age;
  String? title;
  String? description;
  String? category;
  String? subcategory;
  List<String>? urlImage;
  bool? isFree;
  String? time;
  String? uid;
  double? lat;
  double? lng;
  String? currentLocation;
  ProductDetailModel(
      {this.price,
      this.age,
      this.title,
      this.description,
      this.category,
      this.subcategory,
      this.urlImage,
      this.isFree,
      this.time,
      this.uid,
      this.lat,
      this.lng,
      this.currentLocation});

  ProductDetailModel.fromJson(Map<String, dynamic> json) {
    price = json['price'];
    age = json['age'];
    title = json['title'];
    description = json['description'];
    category = json['category'];
    subcategory = json['subcategory'];
    urlImage = json['urlImage'].cast<String>();
    isFree = json['isFree'];
    time = json['Time'];
    uid = json['uid'];
    lat = json['lat'];
    lng = json['lng'];
    currentLocation = json['currentadress'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['price'] = this.price;
    data['age'] = this.age;
    data['title'] = this.title;
    data['description'] = this.description;
    data['category'] = this.category;
    data['subcategory'] = this.subcategory;
    data['urlImage'] = this.urlImage;
    data['isFree'] = this.isFree;
    data['Time'] = this.time;
    data['uid'] = this.uid;
    data['currentadress'] = this.currentLocation;
    return data;
  }
}
