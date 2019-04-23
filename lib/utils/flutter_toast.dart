import 'package:flutter/services.dart';

///
/// author: bobo
/// create time: 2019/4/22 5:12 PM
/// email: jqbo84@163.com
///

class FlutterToast {
  static const MethodChannel _channel = const MethodChannel('com.huyunit.flutter.flutter_oschina_demo/flutter_toast');

  static Future<Null> showToast(String msg,
      {String duration, int textColor, double textSize}) async {
    _channel.invokeMethod('showToast', {
      'msg': msg,
      'duration': duration,
      'textColor': textColor,
      'textSize': textSize,
    });
    return null;
  }
}
