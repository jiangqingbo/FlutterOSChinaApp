import 'package:flutter/material.dart';
import 'package:flutter_oschina_demo/home_page.dart';
import 'package:flutter_oschina_demo/utils/constants.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false, //去掉右上角debug标签
      title: 'Flutter oschina demo',
      theme: ThemeData(
        primaryColor: Color(AppColors.APP_THEME),
      ),
      home: HomePage(),
    );
  }
}