
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:ptp_v2/items/02_gesture/slideRemove.dart';
import 'package:ptp_v2/notifier/02_notifier_gesture.dart';

class PageGesture extends StatefulWidget {
  final String? paraString;
  const PageGesture({super.key, this.paraString});
  @override
  State<PageGesture> createState() => PageGestureState();
}

class PageGestureState extends State<PageGesture> {

  List<int> tempList = [1, 2, 3];

  @override
  Widget build(BuildContext context) {
    // 디바이스 너비
    double deviceWidth = MediaQuery.of(context).size.width;
    // 디바이스 높이
    double deviceHeight = MediaQuery.of(context).size.height;

    NotifierGesture notifierSetting = Provider.of<NotifierGesture>(context);

    return Scaffold(
      appBar: AppBar(
        title: const Text("PageGesture"),
      ),
      // body: ListView.separated(
      //   itemCount: notifierSetting.tempList.length,
      //     itemBuilder: (context, index){
      //       return SlideRemove(
      //         width: deviceWidth,
      //         height: 100,
      //         backgroundDecoration: const BoxDecoration(color: Colors.transparent),
      //         itemWidget: Center(child: Text("${notifierSetting.tempList[index]}"),),
      //       );
      //     },
      //   separatorBuilder: (BuildContext context, int index) { return const Divider(); },
      // ),

      body: ListView.separated(
        itemCount: tempList.length,

        itemBuilder: (context, index){
          return InkWell(
            onTap: (){
              setState(() {
                tempList.insert(index, index+1);
              });
            },
            onLongPress: (){
              setState(() {
                tempList.removeAt(index);
              });
            },
            child: Card(
              color: Colors.amber,
              child: Center(child: Text('${tempList[index]}')),
            ),
          );
        },
        separatorBuilder: (BuildContext context, int index) { return const Divider(); },
      ),
      /*
      body: GestureDetector(
          onPanStart: (DragStartDetails s){
            notifierSetting.onPanStart(s);
          },
          onPanUpdate: (DragUpdateDetails s){
            notifierSetting.onPanUpdate(s);

          },
          onPanEnd: (DragEndDetails s){
            // s.velocity.pixelsPerSecond
            notifierSetting.offsetClear();

          },
          // onHorizontalDragEnd: (DragEndDetails a){
          //   // print(a.velocity);
          // },
          child: Listener(
            child: Container(
              width: deviceWidth,
              height: deviceHeight,
              decoration: BoxDecoration(
                color: Colors.transparent,
              ),
              child:Column(
                children: [
                  Text("local:(${notifierSetting.getLocalOffset.dx.toStringAsFixed(3)}, ${notifierSetting.getLocalOffset.dy.toStringAsFixed(3)})"),
                  Text("global:(${notifierSetting.getGlobalOffset.dx.toStringAsFixed(3)}, ${notifierSetting.getGlobalOffset.dy.toStringAsFixed(3)})"),
                ],
              ),
            ),
          )
      ),
      */
    );
  }
}