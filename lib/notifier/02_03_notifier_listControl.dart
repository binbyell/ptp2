
import 'package:flutter/material.dart';

class NotifierListControl extends ChangeNotifier{

  /// value
  int _itemCount = 0;
  List<Color> itemColors = [];

  /// get
  int get getItemCount => _itemCount;

  /// set
  void itemCountIncrease(){
    _itemCount ++;
    notifyListeners();
  }
  void itemCountDecrease(){
    if(_itemCount > 0){
      _itemCount --;
      notifyListeners();
    }
  }
  void addColor(Color color){
    itemColors.add(color);
  }
  void removeLastColor(){
    itemColors.removeLast();
    notifyListeners();
  }
  void insertColor(int index){
    if(index >= itemColors.length){
      throw FormatException();
    }
  }
}
