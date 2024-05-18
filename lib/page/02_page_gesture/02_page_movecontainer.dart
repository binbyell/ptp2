
import 'dart:math';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:ptp_v2/items/02_gesture/moveableItem.dart';
import 'package:ptp_v2/items/02_gesture/moveableListItem.dart';
import 'package:ptp_v2/notifier/02_03_notifier_listControl.dart';

class PageMoveContainer extends StatefulWidget {
  final String? paraString;

  const PageMoveContainer({super.key, this.paraString});

  @override
  State<PageMoveContainer> createState() => PageMoveContainerState();
}

class PageMoveContainerState extends State<PageMoveContainer> {

  GlobalKey appbarKey = GlobalKey();

  @override
  void initState() {
    WidgetsBinding.instance.addPostFrameCallback((_) {
      if(appbarKey.currentContext != null){
        RenderBox renderBox = appbarKey.currentContext!.findRenderObject() as RenderBox;
        Provider.of<NotifierListControl>(context, listen: false).appbarHeight = renderBox.size.height;
        // print("appbar Size : ${renderBox.size.height}");
      }
    });
    // TODO: implement initState
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    // 디바이스 너비
    double deviceWidth = MediaQuery.of(context).size.width;
    // 디바이스 높이
    double deviceHeight = MediaQuery.of(context).size.height;

    NotifierListControl notifierListControl = Provider.of<NotifierListControl>(context);

    return Scaffold(
      appBar: AppBar(
        key: appbarKey,
      ),
      body: Column(
        children: [
          SizedBox(
              width: deviceWidth,
              height: deviceHeight * 0.6,
              child: Row(
                children: [
                  AnimatedContainer(
                    width: notifierListControl.listColors.isEmpty?deviceWidth:deviceWidth/2,
                    height: deviceHeight * 0.6,
                    decoration: BoxDecoration(
                        color: Colors.transparent, border: Border.all()),
                    duration: Provider.of<NotifierListControl>(context, listen: false).duration,
                    child: Stack(
                      children: [
                        for(int a = 0; a<notifierListControl.itemColors.length; a++)
                          MoveAbleItem(
                            index: a,
                            child: Container(
                              width: 100,
                              height: 100,
                              decoration: BoxDecoration(
                                  shape: BoxShape.circle, color: notifierListControl.itemColors[a]),
                            ),
                            callbackAction: (){
                              notifierListControl.addList(notifierListControl.itemColors[a]);
                            },
                          ),
                      ],
                    ),
                  ),
                  AnimatedContainer(
                      key: Provider.of<NotifierListControl>(context, listen: false).listKeyForMove,
                    width: notifierListControl.listColors.isEmpty?0:deviceWidth/2,
                    height: deviceHeight * 0.6,
                    duration: Provider.of<NotifierListControl>(context, listen: false).duration,
                    child: Stack(
                      children: [
                        Positioned.fill(
                          child: SingleChildScrollView(
                            scrollDirection: Axis.vertical,
                            child: Column(
                              children: [
                                SizedBox(
                                  key: Provider.of<NotifierListControl>(context, listen: false).listKeyForIndex,
                                  width: double.infinity,
                                  height: 0,
                                ),
                                for(int index = 0; index<notifierListControl.listColors.length; index++)
                                  MoveAbleListItem(
                                    index: index,),
                              ],
                            ),
                          ),
                        ),
                        Visibility(
                          visible: notifierListControl.getListItemOnMove,
                          child: Positioned(
                            top: notifierListControl.getOnListMoveObjectOffset!=null?notifierListControl.getOnListMoveObjectOffset!.dy:0,
                            left: notifierListControl.getOnListMoveObjectOffset!=null?notifierListControl.getOnListMoveObjectOffset!.dx:0,
                            child: notifierListControl.getOnListMoveObjectWidget??const SizedBox(),
                          ),
                        ),
                      ],
                    )
                  ),
                ],
              )
          ),
          Expanded(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [

                    TextButton(
                        onPressed: (){
                          notifierListControl.itemCountDecrease();
                        },
                        child: const Text("-")
                    ),
                    Text("${notifierListControl.getItemCount}"),
                    TextButton(
                        onPressed: (){
                          notifierListControl.itemCountIncrease();
                          notifierListControl.addColor(color: getRanColor());
                        },
                        child: const Text("+")),

                  ],
                ),
                const Text("갯수 늘리면 오브젝트 갯수 늘어나요.\n"
                    "각 오브젝트들은 꾹 눌린 다음 이동시킬 수 있어요.\n"
                    "각 오브젝트들은 한번 텝 하면 우측에 리스트가 추가되요.\n"
                    "우측에 추가된 리스트 아이템은 꾹 눌려서 이동시킬 수 있어요.\n"
                    "우측에 추가된 리스트 아이템은 한번 텝하면 사라져요.", textAlign: TextAlign.center,),
              ],
            ),
          )
        ],
      ),
    );
  }

  Color getRanColor(){
    final random = Random();
    return Color.fromARGB(
      255,
      random.nextInt(256),
      random.nextInt(256),
      random.nextInt(256),
    );
  }
}
