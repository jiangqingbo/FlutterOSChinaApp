import 'package:flutter/material.dart';

///
/// author: bobo
/// create time: 2019/4/11 11:08 AM
/// email: jqbo84@163.com
///

class SettingPage extends StatefulWidget {
  @override
  _SettingPageState createState() => _SettingPageState();
}

class _SettingPageState extends State<SettingPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('设置'),
      ),
    );
  }
}
