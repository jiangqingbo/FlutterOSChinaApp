import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';

///
/// author: bobo
/// create time: 2019/4/12 10:32 AM
/// email: jqbo84@163.com
///

class ToastUtils {
  static void show(String message) {
    Fluttertoast.showToast(
      msg: message,
      toastLength: Toast.LENGTH_SHORT,
      gravity: ToastGravity.BOTTOM,
      timeInSecForIos: 1,
      backgroundColor: Color(0xff8c8c8c),
      textColor: Color(0xff333333),
      fontSize: 16.0,
    );
  }
}
