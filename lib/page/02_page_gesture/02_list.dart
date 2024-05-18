import 'package:flutter/material.dart';
import 'package:ptp_v2/page/02_page_gesture/02_page_gesture.dart';
import 'package:ptp_v2/page/02_page_gesture/02_page_movecontainer.dart';
import 'package:ptp_v2/page/02_page_gesture/02_page_showPoint.dart';

class PageGestureList extends StatelessWidget{
  const PageGestureList({super.key});

  @override
  Widget build(BuildContext context){
    return Scaffold(
      appBar: AppBar(title:const Text("List Screen"),),
      body: Container(
        width:MediaQuery.of(context).size.width,
        height:MediaQuery.of(context).size.height,
        child:Center(
            child:ListView(
              children: [
                OutlinedButton(
                    child: const Text("gesture sample"),
                    onPressed:(){
                      Navigator.of(context).push(MaterialPageRoute(builder: (context)=>const PageGestureShowPoint()));
                    }
                ),
                OutlinedButton(
                    child: const Text("PageMoveContainer"),
                    onPressed:(){
                      Navigator.of(context).push(MaterialPageRoute(builder: (context)=>const PageMoveContainer()));
                    }
                ),
              ],
            )
        ),
      ),
    );
  }
}