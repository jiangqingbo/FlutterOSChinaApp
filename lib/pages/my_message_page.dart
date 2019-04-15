import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_oschina_demo/utils/constants.dart';
import 'package:flutter_oschina_demo/utils/data_utils.dart';
import 'package:flutter_oschina_demo/utils/net_utils.dart';

///
/// author: bobo
/// create time: 2019/4/15 2:43 PM
/// email: jqbo84@163.com
///

class MyMessagePage extends StatefulWidget {
  @override
  _MyMessagePageState createState() => _MyMessagePageState();
}

class _MyMessagePageState extends State<MyMessagePage> {
  List<String> _tabTitles = ['@我', '评论', '私信'];
  int curPage = 1;
  List messageList;
  List commentList;

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
        length: _tabTitles.length,
        child: Scaffold(
          appBar: AppBar(
            elevation: 0.0,
            title: Text(
              '消息中心',
              style: TextStyle(
                color: Color(AppColors.APP_BAR),
              ),
            ),
            iconTheme: IconThemeData(
              color: Color(AppColors.APP_BAR),
            ),
            bottom: TabBar(
                tabs: _tabTitles
                    .map((title) => Tab(
                          text: title,
                        ))
                    .toList(),
            labelColor: Color(0xffEE2C00),
              unselectedLabelColor: Color(0xff777777),
            ),
          ),
          body: TabBarView(children: [
            Center(
              child: Text('暂无内容'),
            ),
//            _buildCommentList(),
            Center(
              child: Text('暂无内容'),
            ),
            _buildMessageList(),
          ]),
        ));
  }

  ///------------------------------------ 私信 ---------------------------------

  Future<Null> _pullToRefresh() async {
    curPage = 1;
    _getMessageList();
    return null;
  }

  _buildMessageList() {
    if (messageList == null) {
      //获取私信
      _getMessageList();
      return Center(
        child: CupertinoActivityIndicator(),
      );
    }

    return RefreshIndicator(
        child: ListView.separated(
            itemBuilder: (context, index) {
              return Padding(
                padding: const EdgeInsets.all(10.0),
                child: Row(
                  children: <Widget>[
                    Image.network(messageList[index]['portrait']),
                    SizedBox(
                      width: 10.0,
                    ),
                    Expanded(
                      child: Column(
                        children: <Widget>[
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: <Widget>[
                              Text(
                                '${messageList[index]['sendername']}',
                                style: TextStyle(
                                    fontSize: 16.0,
                                    fontWeight: FontWeight.bold),
                              ),
                              Text(
                                '${messageList[index]['pubDate']}',
                                style: TextStyle(
                                    fontSize: 12.0, color: Color(0xffaaaaaa)),
                              ),
                            ],
                          ),
                          Text(
                            '${messageList[index]['content']}',
                            overflow: TextOverflow.ellipsis,
                            maxLines: 1,
                            style: TextStyle(fontSize: 12.0),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              );
            },
            separatorBuilder: (context, index) {
              return Divider();
            },
            itemCount: messageList.length),
        onRefresh: _pullToRefresh);
  }

  void _getMessageList() {
    DataUtils.isLogin().then((isLogin) {
      if (isLogin) {
        DataUtils.getAccessToken().then((accessToken) {
          print('accessToken: $accessToken');
          //拼装请求
          Map<String, dynamic> params = Map<String, dynamic>();
          params['dataType'] = 'json';
          params['page'] = curPage;
          params['pageSize'] = 10;
          params['access_token'] = accessToken;
          NetUtils.get(AppUrls.MESSAGE_LIST, params).then((data) {
            print('MESSAGE_LIST: $data');
            if (data != null && data.isNotEmpty) {
              Map<String, dynamic> map = json.decode(data);
              var _messageList = map['messageList'];
              setState(() {
                messageList = _messageList;
              });
            }
          });
        });
      }
    });
  }

  ///------------------------------------ 评论 ---------------------------------

  Future<Null> _commentPullToRefresh() async {
    curPage = 1;
    _getCommentList();
    return null;
  }

  _buildCommentList() {
    if (commentList == null) {
      //获取私信
      _getCommentList();
      return Center(
        child: CupertinoActivityIndicator(),
      );
    }

    return RefreshIndicator(
        child: ListView.separated(
            itemBuilder: (context, index) {
              return Padding(
                padding: const EdgeInsets.all(10.0),
                child: Row(
                  children: <Widget>[
                    Image.network(commentList[index]['commentPortrait']),
                    SizedBox(
                      width: 10.0,
                    ),
                    Expanded(
                      child: Column(
                        children: <Widget>[
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: <Widget>[
                              Text(
                                '${commentList[index]['commentAuthor']}',
                                style: TextStyle(
                                    fontSize: 16.0,
                                    fontWeight: FontWeight.bold),
                              ),
                              Text(
                                '${commentList[index]['pubDate']}',
                                style: TextStyle(
                                    fontSize: 12.0, color: Color(0xffaaaaaa)),
                              ),
                            ],
                          ),
                          Text(
                            '${commentList[index]['content']}',
                            overflow: TextOverflow.ellipsis,
                            maxLines: 1,
                            style: TextStyle(fontSize: 12.0),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              );
            },
            separatorBuilder: (context, index) {
              return Divider();
            },
            itemCount: commentList.length),
        onRefresh: _commentPullToRefresh);
  }

  void _getCommentList() {
    DataUtils.isLogin().then((isLogin) {
      if (isLogin) {
        DataUtils.getAccessToken().then((accessToken) {
          print('accessToken: $accessToken');
          //拼装请求
          Map<String, dynamic> params = Map<String, dynamic>();
          params['dataType'] = 'json';
          params['page'] = curPage;
          params['pageSize'] = 20;
          params['id'] = 133912;
          params['catalog'] = 4;
          params['access_token'] = accessToken;
          NetUtils.get(AppUrls.COMMENT_LIST, params).then((data) {
            print('COMMENT_LIST: $data');
            if (data != null && data.isNotEmpty) {
              Map<String, dynamic> map = json.decode(data);
              var _commentList = map['commentList'];
              setState(() {
                commentList = _commentList;
              });
            }
          });
        });
      }
    });
  }
}
