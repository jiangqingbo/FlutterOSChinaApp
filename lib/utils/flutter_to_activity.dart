import 'package:flutter/services.dart';

///
/// author: bobo
/// create time: 2019/4/22 5:12 PM
/// email: jqbo84@163.com
///

class FlutterToActivity {
  static const MethodChannel _jumpToActivity = const MethodChannel('com.huyunit.flutter.flutter_oschina_demo/flutter_to_activity');

  static Future<Null> jumpToNative() async {
    String result = await _jumpToActivity.invokeMethod('oneActivity');
    print('1.返回结果：$result');
  }


  static Future<Null> jumpToNativeWithValue() async {

    Map<String, String> map = { "flutter": "这是一条来自flutter的参数" };

    String result = await _jumpToActivity.invokeMethod('twoActivity', map);

    print('2.返回结果：$result');
  }

}
