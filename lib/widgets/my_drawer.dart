import 'package:flutter/material.dart';
import 'package:flutter_oschina_demo/pages/about_page.dart';
import 'package:flutter_oschina_demo/pages/publish_tweet_page.dart';
import 'package:flutter_oschina_demo/pages/setting_page.dart';
import 'package:flutter_oschina_demo/pages/tweet_black_house.dart';

///
/// author: bobo
/// create time: 2019/4/11 10:55 AM
/// email: jqbo84@163.com
///

class MyDrawer extends StatelessWidget {
  final String headImgPath;
  final List menuTitles;
  final List menuIcons;

  MyDrawer(
      {Key key,
      @required this.headImgPath,
      @required this.menuTitles,
      @required this.menuIcons})
      : assert(headImgPath != null),
        assert(menuTitles != null),
        assert(menuIcons != null),
        super(key: key);

  @override
  Widget build(BuildContext context) {
    return Drawer(
      elevation: 0.0,
      child: ListView.separated(
        padding: const EdgeInsets.all(0.0),
        itemCount: menuTitles.length + 1,
        itemBuilder: (context, index) {
          if (index == 0) {
            return Image.asset(
              headImgPath,
              fit: BoxFit.cover,
            );
          }
          index -= 1;
          return ListTile(
            leading: Icon(menuIcons[index]),
            title: Text(menuTitles[index]),
            trailing: Icon(Icons.arrow_forward_ios),
            onTap: () {
              switch (index) {
                case 0:
                  _navPush(context, PublishTweetPage());
                  break;
                case 1:
                  _navPush(context, TweetBlackHouse());
                  break;
                case 2:
                  _navPush(context, AboutPage());
                  break;
                case 3:
                  _navPush(context, SettingPage());
                  break;
              }
            },
          );
        },
        separatorBuilder: (context, index) {
          if (index == 0) {
            return Divider(
              height: 0.0,
            );
          } else {
            return Divider(
              height: 1.0,
            );
          }
        },
      ),
    );
  }

  _navPush(BuildContext context, Widget page) {
    Navigator.of(context).pop(); //把drawer收起
    Navigator.push(context, MaterialPageRoute(builder: (context) => page));
  }
}
