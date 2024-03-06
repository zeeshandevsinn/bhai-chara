

// ignore_for_file: unnecessary_null_comparison

import 'dart:developer';
import 'dart:ui' as ui;

import 'package:bhai_chara/controller/provider/product/status.dart';
import 'package:bhai_chara/controller/services/Firebase_Manager.dart';
import 'package:bhai_chara/model/product_detail_model.dart';
import 'package:bhai_chara/model/user_model.dart';
import 'package:bhai_chara/utils/preferences.dart';
import 'package:bhai_chara/utils/showSnack.dart';
import 'package:bhai_chara/utils/utils.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';


import '../../../utils/push.dart';
import '../../../view/request_screen.dart';

class ProductDetailProvider extends ChangeNotifier {
  bool isLoading = false;
  UserModel? donnerDetail;
  ProductDetailModel? productDetailModel;
  List<Marker> markersData = [];
  bool isProductRequested = false;
  getDonerDetail(uid) async {
    // debugger();
    var data = await firebaseGetUserDetail(uid);
    // debugger();
    if (data != null) {
      donnerDetail = data;
       markersData.add(
          Marker(
            markerId: const MarkerId("1"),
            position: LatLng(data.lat?.toDouble()??233.004, data.long?.toDouble()??0.45454),
            icon: BitmapDescriptor.fromBytes(
                await getBytesFromAsset('assets/images/location.png', 80)),
          ),
        );
      return donnerDetail;
    }
  }


Future<Uint8List> getBytesFromAsset(String path, int width) async {
  final ByteData data = await rootBundle.load(path);
  final ui.Codec codec = await ui
      .instantiateImageCodec(data.buffer.asUint8List(), targetWidth: width);
  final ui.FrameInfo fi = await codec.getNextFrame();
  final ui.Image image = fi.image;
  final ByteData? byteData =
      await image.toByteData(format: ui.ImageByteFormat.png);
  return byteData!.buffer.asUint8List();
}



  getProductDetail(context, id) async {
    try {
      isLoading = true;
                  isProductRequested = false;

      notifyListeners();
      var data = await FirebaseFirestore.instance
          .collection(PRODUCT_COLLECTION)
          .doc(id)
          .get();
          // debugger();
      if (data != null) {
        productDetailModel = ProductDetailModel.fromJson(data.data()!);
        donnerDetail = await getDonerDetail(productDetailModel!.uid);

print(donnerDetail);
// debugger();
        notifyListeners();
      }
      isLoading = false;
      notifyListeners();
    } catch (e) {
      pop(context);
      showSnack(context: context, text: e.toString());
    }
  }

  getRequestedProduct(id) async {
    try {
// notifyListeners();
      var myID = FirebaseAuth.instance.currentUser?.uid;
      var data = await FirebaseFirestore.instance
          .collection(REQUEST_COLLECTION)
          .where(Filter.and(
            Filter("requester_id", isEqualTo: myID ),
            Filter("product_id", isEqualTo: id ),
          ))
          .get();
          print(data.docs.length);
          // debugger();
      isProductRequested =  data.docs.isNotEmpty;
      notifyListeners();
    } catch (e) {
     
    }
  }

  addRequest(context, {required productID,UserModel? user}) async {
    try {
        
      isLoading = true;
      notifyListeners();
      var data = productDetailModel!.toJson();
      var address = await Preferences.getAddress();
      // debugger();
      data["product_id"] = productID;
      data["requester_id"] = FirebaseAuth.instance.currentUser!.uid;
      data["request"] = ProductStatus.pending.name;
      data["requester_address"] = address ?? "";
      data["request_time"] = DateTime.now();
      data["requester_name"] = user!.name;
      data["requester_email"] = user.email;
      data["requester_phone"] = user.phoneNumber;
      data["requester_image"] = user.image;
      print(data);
    
      await FirebaseFirestore.instance.collection(REQUEST_COLLECTION).add(data);
      await getRequestedProduct(productID);
      isLoading = false;
      notifyListeners();

      push(context, RequestScreen());
    } catch (e) {
      isLoading = false;
      notifyListeners();
      showSnack(context: context, text: e.toString());
    }
  }
}
