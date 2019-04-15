import 'package:flutter/material.dart';
import 'package:flutter_oschina_demo/my_drawer.dart';
import 'package:flutter_oschina_demo/pages/profile_page.dart';
import 'package:flutter_oschina_demo/pages/discovery_page.dart';
import 'package:flutter_oschina_demo/pages/news_list_page.dart';
import 'package:flutter_oschina_demo/pages/tweet_page.dart';
import 'package:flutter_oschina_demo/utils/constants.dart' show AppColors;
import 'package:flutter_oschina_demo/widgets/NavigationIconView.dart';

///
/// author: bobo
/// create time: 2019/4/11 9:54 AM
/// email: jqbo84@163.com
///

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final _appBarTitle = ['资讯', '动弹', '发现', '我的'];
  List<NavigationIconView> _navigationIconViews;
  var _currentIndex = 0;
  List<Widget> _pages;
  PageController _pageController;

  @override
  void initState() {
    super.initState();
    _navigationIconViews = [
      NavigationIconView(
          title: '资讯',
          iconPath: 'assets/images/ic_nav_news_normal.png',
          activeIconPath: 'assets/images/ic_nav_news_actived.png'),
      NavigationIconView(
          title: '动弹',
          iconPath: 'assets/images/ic_nav_tweet_normal.png',
          activeIconPath: 'assets/images/ic_nav_tweet_actived.png'),
      NavigationIconView(
          title: '发现',
          iconPath: 'assets/images/ic_nav_discover_normal.png',
          activeIconPath: 'assets/images/ic_nav_discover_actived.png'),
      NavigationIconView(
          title: '我的',
          iconPath: 'assets/images/ic_nav_my_normal.png',
          activeIconPath: 'assets/images/ic_nav_my_pressed.png'),
    ];

    _pages = [
      NewsListPage(),
      TweetPage(),
      DiscoveryPage(),
      ProfilePage(),
    ];

    _pageController = PageController(initialPage: _currentIndex);
  }

  @override
  Widget build(BuildContext context) {
    //SafeArea 可以适配刘海屏等异形屏
    return Scaffold(
      appBar: AppBar(
        elevation: 0.0, //appbar 阴影
        title: Text(
          _appBarTitle[_currentIndex],
          style: TextStyle(
            color: Color(AppColors.APP_BAR),
          ),
        ),
        iconTheme: IconThemeData(color: Color(AppColors.APP_BAR)),
      ),
      body: PageView.builder(
//        physics: NeverScrollableScrollPhysics(),//禁止滑动
        itemBuilder: (BuildContext context, int index) {
          return _pages[index];
        },
        controller: _pageController,
        itemCount: _pages.length,
        onPageChanged: (index) {
          setState(() {
            _currentIndex = index;
          });
        },
      ),
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: _currentIndex,
        items: _navigationIconViews.map((view) => view.item).toList(),
        type: BottomNavigationBarType.fixed,
        onTap: (index) {
          setState(() {
            _currentIndex = index;
          });
          _pageController.animateToPage(index,
              duration: Duration(microseconds: 1), curve: Curves.ease);
        },
      ),
      drawer: MyDrawer(
        headImgPath: 'assets/images/cover_img.jpg',
        menuIcons: [Icons.send, Icons.home, Icons.error, Icons.settings],
        menuTitles: ['发布动弹', '动弹小黑屋', '关于', '设置'],
      ),
    );
  }
}
