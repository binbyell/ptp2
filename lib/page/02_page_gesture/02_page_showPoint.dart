
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:provider/provider.dart';
import 'package:ptp_v2/notifier/02_notifier_gesture.dart';

class PageGestureShowPoint extends StatefulWidget {
  final String? paraString;
  const PageGestureShowPoint({super.key, this.paraString});
  @override
  State<PageGestureShowPoint> createState() => PageGestureShowPointState();
}

class PageGestureShowPointState extends State<PageGestureShowPoint> {

  int count = 0;

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
        body: Column(
          children: [
            GestureDetector(
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
              child: Container(
                  width: deviceWidth,
                  height: deviceHeight * 0.6,
                  decoration: BoxDecoration(
                      color: Colors.transparent,
                      border: Border.all()
                  ),
                  child:Stack(
                    children: [
                      Positioned.fill(
                        child: Column(
                          children: [
                            Text("local:(${notifierSetting.getLocalOffset.dx.toStringAsFixed(3)}, ${notifierSetting.getLocalOffset.dy.toStringAsFixed(3)})"),
                            Text("global:(${notifierSetting.getGlobalOffset.dx.toStringAsFixed(3)}, ${notifierSetting.getGlobalOffset.dy.toStringAsFixed(3)})"),
                          ],
                        ),
                      ),
                      for(int a = 0; a<count; a++)
                        AnimatedPositioned(
                          top: notifierSetting.getLocalOffset.dy - 10,
                          left: notifierSetting.getLocalOffset.dx - 10,
                          duration: Duration(milliseconds: a * 50),
                          child: Container(
                            width: 20,
                            height: 20,
                            decoration: const BoxDecoration(
                                shape: BoxShape.circle,
                                color: Colors.red
                            ),
                          ),
                        ),
                    ],
                  )
              ),
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
                            setState(() {
                              if(count > 0){
                                count --;
                              }
                            });
                          },
                          child: const Text("-")
                      ),
                      Text("$count"),
                      TextButton(
                          onPressed: (){
                            setState(() {
                              count ++;
                            });
                          },
                          child: const Text("+")),

                    ],
                  ),
                  const Text("갯수 늘리면 잔상 점 갯수 늘어나요"),
                ],
              ),
            )
          ],
        ),
    );
  }
}