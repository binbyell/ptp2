
import 'dart:math';

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:ptp_v2/items/02_gesture/moveableItem.dart';
import 'package:ptp_v2/notifier/02_03_notifier_listControl.dart';

class PageMoveContainer extends StatefulWidget {
  final String? paraString;

  const PageMoveContainer({super.key, this.paraString});

  @override
  State<PageMoveContainer> createState() => PageMoveContainerState();
}

class PageMoveContainerState extends State<PageMoveContainer> {

  bool onMove = false;

  @override
  void initState() {
    WidgetsBinding.instance.addPostFrameCallback((_) {

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
      appBar: AppBar(),
      body: Column(
        children: [
          GestureDetector(
            child: Container(
                width: deviceWidth,
                height: deviceHeight * 0.6,
                decoration: BoxDecoration(
                    color: Colors.transparent, border: Border.all()),
                child: Stack(
                  children: [
                    for(int a = 0; a<notifierListControl.itemColors.length; a++)
                      MoveAbleItem(
                        size: const Size(100, 100),
                        child: Container(
                          width: 100,
                          height: 100,
                          decoration: BoxDecoration(
                              shape: BoxShape.circle, color: notifierListControl.itemColors[a]),
                        ),
                      ),
                  ],
                )),
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
                          notifierListControl.addColor(getRanColor());
                        },
                        child: const Text("+")),

                  ],
                ),
                const Text("갯수 늘리면 오브젝트 갯수 늘어나요.\n각 오브젝트들은 꾹 눌린 다음 이동시킬 수 있어요."),
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
