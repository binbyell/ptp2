
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:ptp_v2/notifier/01_notifier_setting.dart';

class PageSetting extends StatefulWidget {
  final String? paraString;
  const PageSetting({super.key, this.paraString});
  @override
  State<PageSetting> createState() => PageSettingState();
}

class PageSettingState extends State<PageSetting> {

  @override
  Widget build(BuildContext context) {

    NotifierSetting notifierSetting = Provider.of<NotifierSetting>(context);

    // 디바이스 너비
    double deviceWidth = MediaQuery.of(context).size.width;
    // 디바이스 높이
    double deviceHeight = MediaQuery.of(context).size.height;
    return Scaffold(
      appBar: AppBar(
        title: const Text("PageSetting"),
      ),
      body: Column(
        children: [

        ],
      ),
    );
  }
}