
// offset
// child(widget)

import 'package:flutter/material.dart';

class MoveAbleItem extends StatefulWidget {
  final Size size;
  final Widget child;
  final Offset? offset;

  const MoveAbleItem({super.key, required this.size, required this.child, this.offset});
  @override
  State<MoveAbleItem> createState() => _MoveAbleItemState();
}

class _MoveAbleItemState extends State<MoveAbleItem> {

  Offset point = const Offset(0,0);
  double correctionDx = 0;
  double correctionDy = 0;


  @override
  void initState() {
    // TODO: implement initState
    WidgetsBinding.instance.addPostFrameCallback((_) {
      if(widget.offset != null){
        point = widget.offset!;
        correctionDx = widget.offset!.dx;
        correctionDy = widget.offset!.dy;
      }
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {

    return Positioned(
      top: point.dy,
      left: point.dx,
      child: GestureDetector(
        onLongPressStart: (a){
          setState(() {
            point = Offset(
                a.localPosition.dx+correctionDx-(widget.size.width/2),
                a.localPosition.dy+correctionDy-(widget.size.height/2)
            );
          });
        },
        onLongPressMoveUpdate: (a){
          setState(() {
            point = Offset(
                a.localPosition.dx+correctionDx-(widget.size.width/2),
                a.localPosition.dy+correctionDy-(widget.size.height/2)
            );
          });
        },
        onLongPressEnd: (a){
          correctionDx = point.dx;
          correctionDy = point.dy;
        },
        child: widget.child,
      ),
    );
  }
}