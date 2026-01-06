import 'package:flutter/material.dart';

class VariableProvider extends ChangeNotifier {
  double x = 1;
  double y = 1;


  double setIncrement(double value) {
    return value = value + 1;
  }

  void setincrementX(double value) {
     x = value;
    notifyListeners();
  }

  void setincrementy(double value) {
    y = value;
    notifyListeners();
  }
}



// class VariableProvider {
//   static IncrementVariable(var variable) {
//     variable = variable + 1;
//     return variable;
//   }
// }
