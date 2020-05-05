///
/// author: bobo
/// create time: 2019/4/11 9:38 AM
/// email: jqbo84@163.com
///

abstract class AppColors {
  //应用主题色
  static const APP_THEME = 0xff63ca6c;
  static const APP_BAR = 0xffffffff;
}

abstract class AppInfos {
  //应用id
  static const String CLIENT_ID = 'GZBDubRTluvPuvA4vfce';
  //应用密钥
  static const String CLIENT_SECRET = 'CZRXLpGtBuwlGrr4Q3jkEokDPZ6TjovH';
  //回调地址
  static const String REDIRECT_URI = 'https://github.com/jiangqingbo/';
}

abstract class AppUrls {
  static const String HOST = 'https://www.oschina.net';

  //授权登录 ctrl shift u
  static const String OAUTH2_AUTHORIZE = HOST + '/action/oauth2/authorize';
  //获取token
  static const String OAUTH2_TOKEN = HOST + '/action/openapi/token';

  //获取当前登录用户的账户信息
  static const String GET_USER_INFO = HOST + '/action/openapi/user';

  //个人资料
  static const String MY_INFORMATION = HOST + '/action/openapi/my_information';
  //私信
  static const String MESSAGE_LIST = HOST + '/action/openapi/message_list';
  //评论
  static const String COMMENT_LIST = HOST + '/action/openapi/comment_list';

  //资讯
  static const String NEWS_LIST = HOST + '/action/openapi/news_list';
  static const String NEWS_DETAIL = HOST + '/action/openapi/news_detail';
  //动弹
  static const String TWEET_LIST = HOST + '/action/openapi/tweet_list';
  static const String TWEET_PUB = HOST + '/action/openapi/tweet_pub';

}