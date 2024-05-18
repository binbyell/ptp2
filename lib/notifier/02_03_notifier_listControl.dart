
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

class NotifierListControl extends ChangeNotifier{

  /// key
  GlobalKey listKeyForIndex = GlobalKey();
  GlobalKey listKeyForMove = GlobalKey();

  /// value
  int _itemCount = 0;
  List<Color> itemColors = [];
  List<Color> listColors = [];
  List<Offset> itemOffsets = [];

  double appbarHeight = 80;

  Duration duration = const Duration(milliseconds: 200);
  Widget? _onListMoveObjectWidget;
  Offset? _onListMoveObjectOffset;

  bool _listItemOnMove = false;

  /// get
  int get getItemCount => _itemCount;
  Widget? get getOnListMoveObjectWidget => _onListMoveObjectWidget;
  Offset? get getOnListMoveObjectOffset => _onListMoveObjectOffset;
  bool get getListItemOnMove => _listItemOnMove;

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
  void addColor({required Color color, Offset? offset}){
    itemColors.add(color);

    itemOffsets.add(offset??const Offset(0, 0));
  }
  void addList(Color color){
    if(listColors.isEmpty){
      for (int index = 0; index<itemOffsets.length; index++) {
        itemOffsets[index] = Offset(itemOffsets[index].dx/2, itemOffsets[index].dy);
      }
    }
    listColors.add(color);
    notifyListeners();
  }
  void removeLastColor(){
    itemColors.removeLast();
    notifyListeners();
  }
  void removeListColorByIndex(int index){
    bool beforeBeingZero = listColors.isNotEmpty;
    listColors.removeAt(index);

    // 우측 리스트 차있다가 비게되는 경우 우측 아이템 이동
    if(listColors.isEmpty && beforeBeingZero){
      for (int index = 0; index<itemOffsets.length; index++) {
        itemOffsets[index] = Offset(itemOffsets[index].dx*2, itemOffsets[index].dy);
      }
    }
    notifyListeners();
  }
  void moveListColorByIndex(int indexBefore, int indexAfter){

    Color item = listColors[indexBefore];
    listColors.removeAt(indexBefore);

    if(indexAfter > listColors.length){
      listColors.add(item);
    }
    else if(indexAfter < 0){
      listColors.insert(0, item);
    }
    else{
      listColors.insert(indexAfter, item);
    }

    notifyListeners();
  }
  void insertColor(int index){
    if(index >= itemColors.length){
      throw FormatException();
    }
  }
  void moveOffset({required Offset offset, required int index}){
    if(index >= itemOffsets.length){
      throw Error();
    }
    itemOffsets[index] = offset;
    notifyListeners();
  }

  void setOnListMoveObjectWidget(Widget? widget){
    _onListMoveObjectWidget = widget;
    notifyListeners();
  }

  void setOnListMoveObjectOffset(Offset? offset){
    _onListMoveObjectOffset = offset;
    notifyListeners();
  }

  void setListItemOnMove(bool onMove){
    _listItemOnMove = onMove;
    notifyListeners();
  }
}

class ListMoveObject{
  ListMoveObject({
    this.objectWidget,
    this.objectOffset,
  });

  Widget? objectWidget;
  Offset? objectOffset;

  void setWidget(Widget? widget){
    objectWidget = widget;
  }
  void setOffset(Offset? offset){
    objectOffset = offset;
  }
}