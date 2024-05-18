
// offset
// child(widget)

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:ptp_v2/notifier/02_03_notifier_listControl.dart';

class MoveAbleItem extends StatefulWidget {
  final Widget child;
  final VoidCallback? callbackAction;
  final int index;

  const MoveAbleItem({super.key, required this.child, required this.index, this.callbackAction});
  @override
  State<MoveAbleItem> createState() => _MoveAbleItemState();
}

class _MoveAbleItemState extends State<MoveAbleItem> {

  double correctionDx = 0;
  double correctionDy = 0;
  Size childSize = const Size(0,0);

  GlobalKey key = GlobalKey();

  bool onSelfMove = false;


  @override
  void initState() {
    // TODO: implement initState
    WidgetsBinding.instance.addPostFrameCallback((_) {
      if(key.currentContext != null){
        RenderBox renderBox = key.currentContext!.findRenderObject() as RenderBox;
        childSize = renderBox.size;
      }
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {

    NotifierListControl notifierListControl = Provider.of<NotifierListControl>(context);

    return AnimatedPositioned(
      duration: onSelfMove?const Duration(milliseconds: 0):Provider.of<NotifierListControl>(context, listen: false).duration,
      top: notifierListControl.itemOffsets[widget.index].dy,//point.dy,
      left: notifierListControl.itemOffsets[widget.index].dx,
      child: GestureDetector(
        onLongPressStart: (a){
          setState(() {
            onSelfMove = true;
            correctionDx = notifierListControl.itemOffsets[widget.index].dx;
            correctionDy = notifierListControl.itemOffsets[widget.index].dy;
          });
          notifierListControl.moveOffset(
              offset: Offset(
                  a.localPosition.dx+correctionDx-(childSize.width/2),
                  a.localPosition.dy+correctionDy-(childSize.height/2)
              ),
              index: widget.index
          );
          // notifierListControl.itemOffsets[widget.index] = Offset(
          //     a.localPosition.dx+correctionDx-(childSize.width/2),
          //     a.localPosition.dy+correctionDy-(childSize.height/2)
          // );
        },
        onLongPressMoveUpdate: (a){
          notifierListControl.moveOffset(
              offset: Offset(
                  a.localPosition.dx+correctionDx-(childSize.width/2),
                  a.localPosition.dy+correctionDy-(childSize.height/2)
              ),
              index: widget.index
          );
          // notifierListControl.itemOffsets[widget.index] = Offset(
          //     a.localPosition.dx+correctionDx-(childSize.width/2),
          //     a.localPosition.dy+correctionDy-(childSize.height/2)
          // );
        },
        onLongPressEnd: (a){
          setState(() {
            onSelfMove = false;
          });
          correctionDx = notifierListControl.itemOffsets[widget.index].dx;
          correctionDy = notifierListControl.itemOffsets[widget.index].dy;
        },
        onTap: (){
          if(widget.callbackAction!= null){
            widget.callbackAction!();
          }
        },
        child: SizedBox(
          key: key,
          child: widget.child,
        ),
      ),
    );
  }
}