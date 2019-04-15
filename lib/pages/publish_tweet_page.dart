import 'package:flutter/material.dart';

///
/// author: bobo
/// create time: 2019/4/11 10:56 AM
/// email: jqbo84@163.com
///

class PublishTweetPage extends StatefulWidget {
  @override
  _PublishTweetPageState createState() => _PublishTweetPageState();
}

class _PublishTweetPageState extends State<PublishTweetPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('发布动弹'),
      ),
    );
  }
}
