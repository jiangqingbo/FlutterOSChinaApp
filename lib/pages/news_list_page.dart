import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_oschina_demo/common/event_bus.dart';
import 'package:flutter_oschina_demo/pages/login_web_page.dart';
import 'package:flutter_oschina_demo/utils/constants.dart';
import 'package:flutter_oschina_demo/utils/data_utils.dart';
import 'package:flutter_oschina_demo/utils/net_utils.dart';
import 'package:flutter_oschina_demo/widgets/news_list_item.dart';

///
/// author: bobo
/// create time: 2019/4/11 10:48 AM
/// email: jqbo84@163.com
///

class NewsListPage extends StatefulWidget {
  @override
  _NewsListPageState createState() => _NewsListPageState();
}

class _NewsListPageState extends State<NewsListPage> {
  bool isLogin = false;
  int curPage = 1;
  List newsList;

  ScrollController _scrollController;

  @override
  void initState() {
    super.initState();
    DataUtils.isLogin().then((isLogin) {
      if (!mounted) return;
      setState(() {
        this.isLogin = isLogin;
      });
    });
    eventBus.on<LoginEvent>().listen((event) {
      if (!mounted) return;
      setState(() {
        this.isLogin = true;
      });
      //获取新闻列表
      getNewsList(false);
    });
    eventBus.on<LogoutEvent>().listen((event) {
      if (!mounted) return;
      setState(() {
        this.isLogin = false;
      });
    });

    _scrollController = ScrollController()
      ..addListener(() {
        //判断是否滑到底
        if (_scrollController.position.pixels ==
            _scrollController.position.maxScrollExtent) {
          _loadMore();
        }
      });
  }

  @override
  void dispose() {
    super.dispose();
    _scrollController.dispose();
  }

  @override
  Widget build(BuildContext context) {
    if (!isLogin) {
      return Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Text('由于openapi限制，必须登录才能获取资讯！'),
            InkWell(
              onTap: () async {
                final result = await Navigator.of(context).push(
                    MaterialPageRoute(builder: (context) => LoginWebPage()));
                if (result != null && result == 'refresh') {
                  //登录成功
                  eventBus.fire(LoginEvent());
                }
              },
              child: Text('去登录'),
            ),
          ],
        ),
      );
    }

    return RefreshIndicator(
      displacement: 10.0,
      onRefresh: _pullToRefresh,
      child: buildListView(),
    );
  }

  Widget buildListView() {
    if (newsList == null) {
      getNewsList(false);
      return CupertinoActivityIndicator();
    }
    return ListView.builder(
        controller: _scrollController,
        itemCount: newsList.length + 1,
        itemBuilder: (context, index) {
          if(index == newsList.length){
            return Padding(
              padding: const EdgeInsets.all(10.0),
              child: Center(
                child: CircularProgressIndicator(),
              ),
            );
          }
          return NewsListItem(newsList: newsList[index]);
        });
  }

  //NEWS_LIST
  getNewsList(bool isLoadMore) async {
    DataUtils.isLogin().then((isLogin) {
      if (isLogin) {
        DataUtils.getAccessToken().then((accessToken) {
          if (accessToken == null || accessToken.length == 0) {
            return;
          }
          Map<String, dynamic> params = Map<String, dynamic>();
          params['access_token'] = accessToken;
          params['catalog'] = 1;
          params['page'] = curPage;
          params['pageSize'] = 10;
          params['dataType'] = 'json';

          NetUtils.get(AppUrls.NEWS_LIST, params).then((data) {
            print('NEWS_LIST: $data');
            if (data != null && data.isNotEmpty) {
              Map<String, dynamic> map = json.decode(data);
              List _newsList = map['newslist'];
              if (!mounted) return;
              setState(() {
                if (isLoadMore) {
                  newsList.addAll(_newsList);
                } else {
                  newsList = _newsList;
                }
              });
            }
          });
        });
      }
    });
  }

  Future<Null> _pullToRefresh() async {
    curPage = 1;
    getNewsList(false);
    return null;
  }

  Future _loadMore() async {
    curPage += 1;
    getNewsList(true);
  }
}
