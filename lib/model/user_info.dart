///
/// author: bobo
/// create time: 2019/4/15 1:49 PM
/// email: jqbo84@163.com
///

// 用户详细信息
class UserInfo {
  int uid;
  String name;
  int gender;
  String province;
  String city;
  List<dynamic> platforms;
  List<dynamic> expertise;
  String joinTime;
  String lastLoginTime;
  String portrait;
  int fansCount;
  int favoriteCount;
  int followersCount;
  Map<String, dynamic> notice;

  UserInfo(
      {this.uid,
        this.name,
        this.gender,
        this.province,
        this.city,
        this.platforms,
        this.expertise,
        this.joinTime,
        this.lastLoginTime,
        this.portrait,
        this.fansCount,
        this.favoriteCount,
        this.followersCount,
        this.notice});
}
