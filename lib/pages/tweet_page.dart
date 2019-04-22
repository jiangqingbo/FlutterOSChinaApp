import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_oschina_demo/common/event_bus.dart';
import 'package:flutter_oschina_demo/pages/login_web_page.dart';
import 'package:flutter_oschina_demo/utils/constants.dart';
import 'package:flutter_oschina_demo/utils/data_utils.dart';
import 'package:flutter_oschina_demo/utils/net_utils.dart';
import 'package:flutter_oschina_demo/widgets/tweet_list_item.dart';

///
/// author: bobo
/// create time: 2019/4/11 10:49 AM
/// email: jqbo84@163.com
///

class TweetPage extends StatefulWidget {
  @override
  _TweetPageState createState() => _TweetPageState();
}

class _TweetPageState extends State<TweetPage> with SingleTickerProviderStateMixin{
  List _tabTitles = ['最新', '热门'];
  List latestTweetList;
  List hotTweetList;
  int curPage = 1;
  ScrollController _controller = ScrollController();
  TabController _tabController;
  bool isLogin = false;

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: _tabTitles.length, vsync: this);
    _controller.addListener(() {
      var maxScroll = _controller.position.maxScrollExtent;
      var pixels = _controller.position.pixels;
      if (maxScroll == pixels) {
        curPage++;
        getTweetList(isLoadMore: false, isHot: false);
      }
    });
    DataUtils.isLogin().then((isLogin) {
      if (!mounted) return;
      setState(() {
        this.isLogin = isLogin;
      });
    });
    eventBus.on<LoginEvent>().listen((event) {
      if (!mounted) return;
      setState(() {
        this.isLogin = isLogin;
      });
      getTweetList(isLoadMore: false, isHot: false);
    });
    eventBus.on<LogoutEvent>().listen((event) {
//      _showUerInfo();
    });
  }

  getTweetList({bool isLoadMore, bool isHot}) async {
    DataUtils.isLogin().then((isLogin) {
      if (isLogin) {
        DataUtils.getAccessToken().then((accessToken) {
          if (accessToken == null || accessToken.length == 0) {
            return;
          }
          Map<String, dynamic> params = Map<String, dynamic>();
          params['access_token'] = accessToken;
          params['user'] = isHot ? -1 : 0;
          params['page'] = curPage;
          params['pageSize'] = 10;
          params['dataType'] = 'json';

          NetUtils.get(AppUrls.TWEET_LIST, params).then((data) {
            print('TWEET_LIST: $data');
            if (data != null && data.isNotEmpty) {
              Map<String, dynamic> map = json.decode(data);
              List _tweetList = map['tweetlist'];
              if (!mounted) return;
              setState(() {
                if (isLoadMore) {
                  if (isHot) {
                    latestTweetList.addAll(_tweetList);
                    hotTweetList.addAll(_tweetList);
                  }
                } else {
                  if (isHot) {
                    hotTweetList = _tweetList;
                  } else {
                    latestTweetList = _tweetList;
                  }
                }
              });
            }
          });
        });
      }
    });
  }

  @override
  void dispose() {
    super.dispose();
    _controller.dispose();
    _tabController.dispose();
  }

  @override
  Widget build(BuildContext context) {
    if (!isLogin) {
      return Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Text('必须登录才能查看动弹信息！'),
            InkWell(
              child: Container(
                padding: const EdgeInsets.all(10.0),
                child: Text(
                  '马上登录',
                  style: TextStyle(color: Color(0xff0000ff)),
                ),
              ),
              onTap: () async {
                //TODO 跳转登录
                final result = await Navigator.of(context).push(
                    MaterialPageRoute(builder: (context) => LoginWebPage()));
                if (result != null && result == 'refresh') {
                  //登录成功
                  eventBus.fire(LoginEvent());
                }
              },
            ),
          ],
        ),
      );
    }

    return Column(
      children: <Widget>[
        //tabbar
        Container(
          color: Color(AppColors.APP_THEME),
          child: TabBar(
              controller: _tabController,
              indicatorColor: Color(0xffffffff),
              labelColor: Color(0xffffffff),
              tabs: _tabTitles.map((title) {
                return Tab(
                  text: title,
                );
              }).toList()),
        ),
        Expanded(
            child: TabBarView(
              controller: _tabController,
              children: [_buildLatestTweetList(), _buildHotTweetList()],
            ))
        //list
      ],
    );
  }
  Future<Null> _pullToRefresh() async {
    curPage = 1;
    getTweetList(isLoadMore: false, isHot: false);
    return null;
  }

  Widget _buildLatestTweetList() {
    if (latestTweetList == null) {
      getTweetList(isLoadMore: false, isHot: false);
      return new Center(
        child: new CircularProgressIndicator(),
      );
    }
    return RefreshIndicator(
      onRefresh: _pullToRefresh,
      child: ListView.separated(
          controller: _controller,
          itemBuilder: (context, index) {
            if (index == latestTweetList.length) {
              return Padding(
                padding: const EdgeInsets.all(10.0),
                child: Center(
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: <Widget>[
                        CupertinoActivityIndicator(),
                        SizedBox(
                          width: 20.0,
                        ),
                        Text('正在加载...'),
                      ],
                    )),
              );
            }
            return TweetListItem(tweetData: latestTweetList[index]);
          },
          separatorBuilder: (context, index) {
            return Container(
              height: 10.0,
              color: Colors.grey[200],
            );
          },
          itemCount: latestTweetList.length + 1),
    );
  }

  Widget _buildHotTweetList() {
    if (hotTweetList == null) {
      getTweetList(isLoadMore: false, isHot: true);
      return Center(
        child: CupertinoActivityIndicator(),
      );
    }

    return ListView.separated(
        itemBuilder: (context, index) {
          if (index == hotTweetList.length) {
            return Container(
              padding: const EdgeInsets.all(10.0),
              color: Color(0xaaaaaaaa),
              child: Center(child: Text('没有更多数据了')),
            );
          }
          return TweetListItem(tweetData: hotTweetList[index]);
        },
        separatorBuilder: (context, index) {
          return Container(
            height: 10.0,
            color: Color(0xaaaaaaaa),
          );
        },
        itemCount: hotTweetList.length + 1);
  }
}
