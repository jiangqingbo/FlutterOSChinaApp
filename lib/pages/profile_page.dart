import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_oschina_demo/common/event_bus.dart';
import 'package:flutter_oschina_demo/pages/login_web_page.dart';
import 'package:flutter_oschina_demo/pages/my_message_page.dart';
import 'package:flutter_oschina_demo/pages/profile_detail_page.dart';
import 'package:flutter_oschina_demo/utils/constants.dart';
import 'package:flutter_oschina_demo/utils/data_utils.dart';
import 'package:flutter_oschina_demo/utils/net_utils.dart';

///
/// author: bobo
/// create time: 2019/4/11 10:51 AM
/// email: jqbo84@163.com
///

class ProfilePage extends StatefulWidget {
  @override
  _ProfilePageState createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {
  List menuTitles = [
    '我的消息',
    '阅读记录',
    '我的博客',
    '我的问答',
    '我的活动',
    '我的团队',
    '邀请好友',
  ];

  List menuIcons = [
    Icons.message,
    Icons.print,
    Icons.error,
    Icons.phone,
    Icons.send,
    Icons.people,
    Icons.person,
  ];

  String userAvatar;
  String userName;

  @override
  void initState() {
    super.initState();
    //尝试显示用户信息
    _showUserInfo();
    eventBus.on<LoginEvent>().listen((event) {
      //获取用户信息并显示
      print('正在获取用户信息....');
      _getUserInfo();
    });
    eventBus.on<LogoutEvent>().listen((event) {
      _showUserInfo();
    });
  }

  @override
  Widget build(BuildContext context) {
    return ListView.separated(
        itemBuilder: (context, index) {
          if (index == 0) {
            return _buildHeader();
          }
          index -= 1;
          if (index == menuTitles.length) {
            return _buildFooter();
          }
          return ListTile(
            leading: Icon(menuIcons[index]),
            title: Text(menuTitles[index]),
            trailing: Icon(Icons.arrow_forward_ios),
            onTap: () {
              DataUtils.isLogin().then((isLogin) {
                if (isLogin) {
                  switch (index) {
                    case 0:
                      _navPush(context, MyMessagePage());
                      break;
                    case 1:
                      break;
                    case 2:
                      break;
                    case 3:
                      break;
                  }
                } else {
                  _login();
                }
              });
            },
          );
        },
        separatorBuilder: (context, index) {
          return Divider();
        },
        itemCount: menuTitles.length + 2);
  }

  void _navPush(BuildContext context, Widget page){
    Navigator.of(context).push(MaterialPageRoute(builder: (context) => page));
  }

  Container _buildHeader() {
    return Container(
      height: 200.0,
      color: Color(AppColors.APP_THEME),
      child: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            // 头像
            GestureDetector(
              child: Container(
                width: 80.0,
                height: 80.0,
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  border: Border.all(
                    color: Color(0xffffffff),
                    width: 2.0,
                  ),
                  image: DecorationImage(
                      image: userAvatar != null
                          ? NetworkImage(userAvatar)
                          : AssetImage('assets/images/ic_avatar_default.png'),
                      fit: BoxFit.cover),
                ),
              ),
              onTap: () {
                //执行授权
                _authorize();
              },
            ),
            SizedBox(
              height: 10.0,
            ),
            Text(
              userName ?? '点击头像登录',
              style: TextStyle(
                color: Color(0xffffffff),
              ),
            )
          ],
        ),
      ),
    );
  }

  Container _buildFooter() {
    return Container(
      width: MediaQuery.of(context).size.width,
      height: 85.0,
      padding: EdgeInsets.all(20.0),
      child: SizedBox(
        width: MediaQuery.of(context).size.width - 40.0,
        height: 45.0,
        child: RaisedButton(
          onPressed: _logout,
          child: Text('退出登录',
              style: TextStyle(color: Color(0xff333333), fontSize: 18.0)),
        ),
      ),
    );
  }

  //授权
  _authorize() {
    DataUtils.isLogin().then((isLogin) {
      if (!isLogin) {
        // 没有登录，去登录
        _login();
      } else {
        //详情
        Navigator.of(context)
            .push(MaterialPageRoute(builder: (context) => ProfileDetailPage()));
      }
    });
  }

  /* 登录方法 */
  _login() async {
    final result = await Navigator.of(context)
        .push(MaterialPageRoute(builder: (context) => LoginWebPage()));
    if (result != null && result == 'refresh') {
      print('登录成功！！');
      //登录成功
      eventBus.fire(LoginEvent());
    }
  }

  _showUserInfo() {
    DataUtils.isLogin().then((isLogin) {
      if (isLogin) {
        DataUtils.getUserInfo().then((user) {
          if (null != user) {
            setState(() {
              userAvatar = user.avatar;
              userName = user.name;
            });
          } else {
            setState(() {
              userAvatar = null;
              userName = null;
            });
          }
        });
      } else {
        setState(() {
          userAvatar = null;
          userName = null;
        });
      }
    });
  }

  _getUserInfo() {
    DataUtils.getAccessToken().then((token) {
      Map<String, dynamic> params = Map<String, dynamic>();
      params['access_token'] = token;
      params['dataType'] = 'json';
      NetUtils.get(AppUrls.GET_USER_INFO, params).then((data) {
        //{"gender":"male","name":"江清波","location":"上海 浦东","id":133912,"avatar":"https://static.oschina.net/uploads/user/66/133912_50.jpg?t=1453255864000","email":"jqbo84@163.com","url":"https://my.oschina.net/409734331"}
        print('getUserInfo: $data');
        Map<String, dynamic> map = json.decode(data);
        if (map != null && map.isNotEmpty) {
          //保存用户等信息
          DataUtils.saveUserWithJsonString(data);
          DataUtils.saveUserInfo(map);
        }
        setState(() {
          userAvatar = map['avatar'];
          userName = map['name'];
        });
      });
    });
  }

  _logout() {
    showDialog(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            title: Text('提示'),
            content: SingleChildScrollView(
              child: ListBody(
                children: <Widget>[
                  Text('确定退出登录么?'),
                ],
              ),
            ),
            actions: <Widget>[
              FlatButton(
                child: Text('确定'),
                onPressed: () {
                  DataUtils.clearLoginInfo();
                  DataUtils.clearUserInfo();
                  //登出成功
                  eventBus.fire(LogoutEvent());
//                  setState(() {
//                    setState(() {
//                      userAvatar = null;
//                      userName = null;
//                    });
//                  });
                  Navigator.of(context).pop();
                },
              ),
              FlatButton(
                child: Text('取消'),
                onPressed: () {
                  Navigator.of(context).pop();
                },
              ),
            ],
          );
        });
  }
}
