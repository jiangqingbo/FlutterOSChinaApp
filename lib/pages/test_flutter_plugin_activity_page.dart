import 'package:flutter/material.dart';
import 'package:flutter_oschina_demo/utils/flutter_to_activity.dart';

///
/// author: bobo
/// create time: 2019/4/22 5:17 PM
/// email: jqbo84@163.com
///

void main() => runApp(TestFlutterPluginActivityPage());

class TestFlutterPluginActivityPage extends StatefulWidget {
  @override
  _TestFlutterPluginActivityPageState createState() => _TestFlutterPluginActivityPageState();
}

class _TestFlutterPluginActivityPageState extends State<TestFlutterPluginActivityPage> {
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(
          title: const Text('Flutter Plugin To Activity'),
        ),
        body: Center(
          child: Column(
            children: <Widget>[
              RaisedButton(
                onPressed: () {
                  print('flutter jump to activity one');
                  FlutterToActivity.jumpToNative();
                },
                child: Text('jumpToNative'),
              ),

              RaisedButton(
                onPressed: () {
                  print('flutter jump to activity two');
                  FlutterToActivity.jumpToNativeWithValue();
                },
                child: Text('jumpToNativeWithValue'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}