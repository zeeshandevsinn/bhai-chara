import 'package:flutter/material.dart';

class SelectedType extends ChangeNotifier{
   var selected = "All";

   void setSelectedtype(String value){
    selected = value;
    notifyListeners();
   }
}