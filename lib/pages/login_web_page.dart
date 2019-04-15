import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_oschina_demo/utils/constants.dart'
    show AppColors, AppInfos, AppUrls;
import 'package:flutter_oschina_demo/utils/data_utils.dart';
import 'package:flutter_oschina_demo/utils/net_utils.dart';
import 'package:flutter_webview_plugin/flutter_webview_plugin.dart';

///
/// author: bobo
/// create time: 2019/4/11 4:07 PM
/// email: jqbo84@163.com
///

class LoginWebPage extends StatefulWidget {
  @override
  _LoginWebPageState createState() => _LoginWebPageState();
}

class _LoginWebPageState extends State<LoginWebPage> {
  FlutterWebviewPlugin _flutterWebviewPlugin = FlutterWebviewPlugin();
  bool isLoading = true;


  @override
  void initState() {
    super.initState();
    //监听url变化
    _flutterWebviewPlugin.onUrlChanged.listen((url){
      https://www.oschina.net/action/oauth2/authorize?response_type=code&client_id=GZBDubRTluvPuvA4vfce&redirect_uri=http://www.huyunit.com/
      print('LoginWebPage onUrlChanged: $url');
      if(mounted){
        setState(() {
          isLoading = false;
        });
      }

//      https://www.dongnaoedu.com/?code=6hHYoH&state=
      if (url != null && url.length > 0 && url.contains('?code=')) {
        //登录成功了
        //提取授权码code
        String code = url.split('?')[1].split('&')[0].split('=')[1];
        Map<String, dynamic> params = Map<String, dynamic>();
        params['client_id'] = AppInfos.CLIENT_ID;
        params['client_secret'] = AppInfos.CLIENT_SECRET;
        params['grant_type'] = 'authorization_code';
        params['redirect_uri'] = AppInfos.REDIRECT_URI;
        params['code'] = '$code';
        params['dataType'] = 'json';
        NetUtils.get(AppUrls.OAUTH2_TOKEN, params).then((data) {
//{"access_token":"43e77800-17c7-40db-b848-c9d14eae69af","refresh_token":"58746a64-414c-432e-b374-808c9af7f638","uid":133912,"token_type":"bearer","expires_in":600756}
          print('getTokenAPI: $data');
          if (data != null) {
            Map<String, dynamic> map = json.decode(data);
            if (map != null && map.isNotEmpty) {
              //保存token等信息
              DataUtils.saveLoginInfo(map);
              //弹出当前路由，并返回refresh通知我的界面刷新数据
              Navigator.pop(context, 'refresh');
            }
          }
        });
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    List<Widget> _appBarTitle = [
      Text(
        '登录开源中国',
        style: TextStyle(
          color: Color(AppColors.APP_BAR),
        ),
      ),
    ];
    if (isLoading) {
      _appBarTitle.add(SizedBox(
        width: 10.0,
      ));
      _appBarTitle.add(CupertinoActivityIndicator());
    }

    //authorize?response_type=code&client_id=s6BhdRkqt3&state=xyz&redirect_uri=https
    return WebviewScaffold(
      appBar: AppBar(
        title: Row(
          children: _appBarTitle,
        ),
      ),
      url: AppUrls.OAUTH2_AUTHORIZE +
          '?response_type=code&client_id=' +
          AppInfos.CLIENT_ID +
          '&redirect_uri=' +
          AppInfos.REDIRECT_URI,
      //允许执行js
      withJavascript: true,
      //允许本地存储
      withLocalStorage: true,
      //允许网页缩放
      withZoom: true,
    );
  }
}
