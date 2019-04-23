import 'package:flutter/material.dart';
import 'package:flutter_oschina_demo/utils/flutter_toast.dart';

///
/// author: bobo
/// create time: 2019/4/22 5:17 PM
/// email: jqbo84@163.com
///

void main() => runApp(TestFlutterToastPluginPage());

class TestFlutterToastPluginPage extends StatefulWidget {
  @override
  _TestFlutterToastPluginPageState createState() => _TestFlutterToastPluginPageState();
}

class _TestFlutterToastPluginPageState extends State<TestFlutterToastPluginPage> {
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(
          title: const Text('Flutter Toast Plugin Demo'),
        ),
        body: Center(
          child: RaisedButton(
            onPressed: () {
              print('吐司');
              FlutterToast.showToast(
                'Hello Custom Flutter Toast plugin!',
                duration: 'short',
                textColor: 0xffff0000,
                textSize: 16.0,
              );
            },
            child: Text('ShowToast'),
          ),
        ),
      ),
    );
  }
}