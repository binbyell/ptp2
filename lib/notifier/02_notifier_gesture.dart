
import 'package:flutter/material.dart';

class NotifierGesture extends ChangeNotifier{

  List<int> tempList = [1, 2, 3, 4];

  // value
  Offset _localOffset = const Offset(0, 0);
  Offset _globalOffset = const Offset(0, 0);

  // get
  Offset get getLocalOffset => _localOffset;
  Offset get getGlobalOffset => _globalOffset;

  // set
  void setLocalOffset(Offset offset){
    _localOffset = offset;
    notifyListeners();
  }
  void setGlobalOffset(Offset offset){
    _globalOffset = offset;
    notifyListeners();
  }

  // function
  void onPanStart(DragStartDetails s){
    setLocalOffset(s.localPosition);
    setGlobalOffset(s.globalPosition);
  }
  void onPanUpdate(DragUpdateDetails s){
    setLocalOffset(s.localPosition);
    setGlobalOffset(s.globalPosition);
  }
  void offsetClear({Offset? clearLocalPoint}){
    if(clearLocalPoint == null){
      _localOffset = const Offset(0, 0);
      _globalOffset= const Offset(0, 0);
    }
    else{

    }
    notifyListeners();
  }
}
