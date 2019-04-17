import 'package:flutter/material.dart';

///
/// author: bobo
/// create time: 2019/4/11 10:03 AM
/// email: jqbo84@163.com
///

class NavigationIconView {
  //item
  final BottomNavigationBarItem item;

  // title
  final String title;

  // icon path
  final String iconPath;

  // actived icon path
  final String activeIconPath;

  NavigationIconView(
      {@required this.title,
      @required this.iconPath,
      @required this.activeIconPath})
      : item = BottomNavigationBarItem(
            icon: Image.asset(
              iconPath,
              width: 20.0,
              height: 20.0,
            ),
            activeIcon: Image.asset(
              activeIconPath,
              width: 20.0,
              height: 20.0,
            ),
            title: Text(title));
}
