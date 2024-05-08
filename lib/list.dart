
import 'package:flutter/material.dart';
import 'package:ptp_v2/page/01_page_setting.dart';
import 'package:ptp_v2/page/02_page_gesture/02_list.dart';

class ListScreen extends StatelessWidget{
  const ListScreen({super.key});

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
                    child: const Text("Change Theme"),
                    onPressed:(){
                      Navigator.of(context).push(MaterialPageRoute(builder: (context)=>const PageSetting()));
                    }
                ),
                OutlinedButton(
                    child: const Text("Gesture"),
                    onPressed:(){
                      Navigator.of(context).push(MaterialPageRoute(builder: (context)=>const PageGestureList()));
                    }
                ),
              ],
            )
        ),
      ),
    );
  }
}