
import 'package:flutter/material.dart';

class NotifierSetting extends ChangeNotifier{

  // value
  ThemeData _themeData = ThemeData.light();

  // get
  ThemeData get getThemeData => _themeData;

  // set
  void setThemeData(ThemeData themeData){
    _themeData = themeData;
    notifyListeners();
  }
}
