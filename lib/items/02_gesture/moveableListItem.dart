

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:ptp_v2/notifier/02_03_notifier_listControl.dart';

class MoveAbleListItem extends StatefulWidget {
  final int index;
  const MoveAbleListItem({super.key, required this.index});
  @override
  State<MoveAbleListItem> createState() => MoveAbleListItemState();
}

class MoveAbleListItemState extends State<MoveAbleListItem> {

  bool onMove = false;


  @override
  Widget build(BuildContext context) {
    // 디바이스 너비
    double deviceWidth = MediaQuery.of(context).size.width;
    // 디바이스 높이
    double deviceHeight = MediaQuery.of(context).size.height;

    NotifierListControl notifierListControl = Provider.of<NotifierListControl>(context);

    // get parents position
    RenderBox parentsRenderBox = Provider.of<NotifierListControl>(context, listen: false).listKey.currentContext!.findRenderObject() as RenderBox;
    Offset parentsZeroGlobalPosition = parentsRenderBox.localToGlobal(Offset.zero);

    return GestureDetector(
      onLongPressStart: (detail){

        notifierListControl.setOnListMoveObjectWidget(
          Container(
            width: notifierListControl.listColors.isEmpty?0:deviceWidth/2,
            height: 50,
            decoration: BoxDecoration(
                color: notifierListControl.listColors[widget.index],
                borderRadius: BorderRadius.circular(20)
            ),
          ),
        );
        notifierListControl.setOnListMoveObjectOffset(
            Offset(
                detail.globalPosition.dx - parentsZeroGlobalPosition.dx - ((notifierListControl.listColors.isEmpty?0:deviceWidth/2)/2),
                detail.globalPosition.dy - parentsZeroGlobalPosition.dy - (50/2)
            )
        );

        notifierListControl.setListItemOnMove(true);
        setState(() {
          onMove = true;
        });
      },

      onLongPressMoveUpdate: (detail){
        notifierListControl.setOnListMoveObjectOffset(
            Offset(
                detail.globalPosition.dx - parentsZeroGlobalPosition.dx - ((notifierListControl.listColors.isEmpty?0:deviceWidth/2)/2),
                detail.globalPosition.dy - parentsZeroGlobalPosition.dy - (50/2)
            )
        );
      },

      onLongPressEnd: (detail){
        // notifierListControl.setOnListMoveObjectOffset(
        //     Offset(
        //         detail.globalPosition.dx - parentsZeroGlobalPosition.dx - ((notifierListControl.listColors.isEmpty?0:deviceWidth/2)/2),
        //         detail.globalPosition.dy - parentsZeroGlobalPosition.dy - (50/2)
        //     )
        // );
        notifierListControl.setOnListMoveObjectWidget(null);

        notifierListControl.setListItemOnMove(false);
        setState(() {
          onMove = false;
        });
        notifierListControl.moveListColorByIndex(widget.index, (detail.globalPosition.dy - parentsZeroGlobalPosition.dy)~/50);

      },
      onTap: (){
        notifierListControl.removeListColorByIndex(widget.index);
      },
      child:AnimatedContainer(
        width: notifierListControl.listColors.isEmpty?0:deviceWidth/2,
        height: onMove?0:50,
        decoration: BoxDecoration(
            color: notifierListControl.listColors[widget.index],
            borderRadius: BorderRadius.circular(20)
        ),
        duration: const Duration(milliseconds: 0),
      ),
    );
  }
}

