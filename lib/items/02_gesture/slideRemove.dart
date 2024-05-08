

import 'package:flutter/material.dart';

class SlideRemove extends StatefulWidget{
  const SlideRemove({
    super.key,
    required this.width,
    required this.height,
    this.backgroundDecoration,
    this.itemWidget,
  }):moveDistance = width * 0.3;

  final double width;
  final double height;
  final BoxDecoration? backgroundDecoration;
  final Widget? itemWidget;

  final double moveDistance;

  @override
  State<SlideRemove> createState() => _SlideRemoveState();
}

class _SlideRemoveState extends State<SlideRemove> {
  SlideDirection slideDirection = SlideDirection.undefined;
  bool nowOnMove = false;

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return GestureDetector(
      onHorizontalDragEnd: (s){
        if(s.primaryVelocity == null){
          return;
        }
        if(nowOnMove == false){
          return;
        }
        if(s.primaryVelocity!.sign < 0){
          setState(() {
            slideDirection = SlideDirection.left;
            nowOnMove = false;
          });
        }
        if(s.primaryVelocity!.sign >0){
          setState(() {
            slideDirection = SlideDirection.right;
            nowOnMove = false;
          });
        }
      },
      onLongPress: (){
        setState(() {
          nowOnMove = true;
        });
      },
      onTap: (){
        setState(() {
          slideDirection = SlideDirection.undefined;
          showDialog(
              context: context,
              builder: (context){
                return AlertDialog(
                  contentPadding: EdgeInsets.zero,
                  content: SizedBox(
                    width: widget.width * 0.6,
                    height: widget.height,
                    child: const Center(child: Text("대충 적당한 글"),),
                  ),
                );
              }
          );
        });
      },
      child: Container(
        width: widget.width,
        height: widget.height,
        decoration: widget.backgroundDecoration,
        child: Stack(
          children: [
            AnimatedPositioned(
              duration: const Duration(milliseconds: 200),
              left: getSlideValue(slideDirection),
              child: Container(
                width: widget.width + (widget.moveDistance * 2),
                height: widget.height,
                child: Row(
                  children: [
                    SizedBox(
                      width: widget.moveDistance,
                      height: widget.height,
                      child: Icon(Icons.add),
                    ),
                    Container(
                      width: widget.width,
                      height: widget.height,
                      decoration: const BoxDecoration(color: Colors.blueGrey),
                      child: widget.itemWidget,
                    ),
                    SizedBox(
                      width: widget.moveDistance,
                      height: widget.height,
                      child: IconButton(
                        icon: Icon(Icons.delete),
                        onPressed: (){

                        },
                      ),
                    ),
                  ],
                ),
              ),
            ),


            Positioned(
              child: Visibility(
                visible: nowOnMove,
                child: Container(
                  decoration: const BoxDecoration(shape: BoxShape.circle, color: Colors.red),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  double getSlideValue(SlideDirection slideDirection){
    switch(slideDirection){
      case SlideDirection.left:
        return -widget.moveDistance * 2;
      case SlideDirection.right:
        return 0;
      case SlideDirection.undefined:
        return -widget.moveDistance;
    }
  }
}

enum SlideDirection{
  left('left', '왼쪽'),
  right('right', '오른쪽'),
  undefined('undefined', '');

  const SlideDirection(this.direction, this.displayName);
  final String direction;
  final String displayName;

  factory SlideDirection.getByDirection(String direction){
    return SlideDirection.values.firstWhere((value) => value.direction == direction,
        orElse: () => SlideDirection.undefined);
  }
}
