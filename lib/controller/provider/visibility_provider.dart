import 'package:flutter/cupertino.dart';

class VisibilityProvider1 extends ChangeNotifier{
  bool show= true;

  toggle()
  {
    
   show= !show;
   notifyListeners();
  }
}

class VisibilityProvider2 extends ChangeNotifier{
  bool show= true;

  toggle()
  {
    
   show= !show;
   notifyListeners();
  }
}