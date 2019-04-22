import 'package:flutter/material.dart';

///
/// author: bobo
/// create time: 2019/4/18 5:43 PM
/// email: jqbo84@163.com
///

class TweetListItem extends StatelessWidget {
  final Map<String, dynamic> tweetData;
  final RegExp regExp1 = new RegExp("</.*>");
  final RegExp regExp2 = new RegExp("<.*>");

//  "id": 1121274,
//  "pubDate": "2013-08-28 18:40:07.0",
//  "body": "@做最好的三三",
//  "author": "彭博",
//  "authorid": 89964,
//  "commentCount": 0,
//  "portrait":
//  "http://static.oschina.net/uploads/user/44/89964_50.jpg?t=1376365607000"
  TweetListItem({Key key, @required this.tweetData})
      : assert(tweetData != null),
        super(key: key);

  int getRow(int n) {
    int a = n % 3;
    int b = n ~/ 3;
    if (a != 0) {
      return b + 1;
    }
    return b;
  }

  // 去掉文本中的html代码
  String clearHtmlContent(String str) {
    if (str.startsWith("<emoji")) {
      return "[emoji]";
    }
    var s = str.replaceAll(regExp1, "");
    s = s.replaceAll(regExp2, "");
    s = s.replaceAll("\n", "");
    return s;
  }

  @override
  Widget build(BuildContext context) {
    Widget _buildContent() {
      var _columnChildren = <Widget>[
        Row(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: <Widget>[
            Container(
              padding: EdgeInsets.all(5.0),
              child: CircleAvatar(
                backgroundImage:
                    NetworkImage(tweetData['portrait'], scale: 1.5),
              ),
            ),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                Text(
                  '${tweetData['author']}',
                  style: TextStyle(
//                  fontWeight: FontWeight.bold,
                    fontSize: 20.0,
                  ),
                ),
                Text(
                  '${tweetData['pubDate']}',
                  style: TextStyle(
                    color: Color(0xffaaaaaa),
                  ),
                )
              ],
            ),
          ],
        ),
        //动弹主体内容
        Padding(
          padding: const EdgeInsets.symmetric(vertical: 5.0),
          child: Text(
            '${clearHtmlContent(tweetData['body'])}',
            style: TextStyle(fontSize: 18.0),
          ),
        ),
      ];

      String _imgSmall = tweetData['imgSmall'];
      if (_imgSmall != null && _imgSmall.length > 0) {
        List<String> list = _imgSmall.split(",");
        print('list: $list');
        List<String> imgUrlList = new List<String>();
        for (String s in list) {
          //！！
          if (s.startsWith('https://static.oschina.net/uploads/space/https')) {
            s = s.replaceAll('https://static.oschina.net/uploads/space/', '');
          }
          imgUrlList.add(s);
        }
        // print(imgUrlList);
        List<Widget> imgList = [];
        List<List<Widget>> rows = [];
        num len = imgUrlList.length;
        for (var row = 0; row < getRow(len); row++) {
          List<Widget> rowArr = [];
          for (var col = 0; col < 3; col++) {
            num index = row * 3 + col;
            num screenWidth = MediaQuery.of(context).size.width;
            double cellWidth = (screenWidth - 100) / 3;
            if (index < len) {
              rowArr.add(new Padding(
                padding: const EdgeInsets.all(2.0),
                child: new Image.network(imgUrlList[index],
                    width: cellWidth, height: cellWidth),
              ));
            }
          }
          rows.add(rowArr);
        }
        for (var row in rows) {
          imgList.add(new Row(
            children: row,
          ));
        }
        _columnChildren.add(new Padding(
          padding: const EdgeInsets.all(5.0),
          child: new Column(
            children: imgList,
          ),
        ));
      }

      return Padding(
        padding: const EdgeInsets.all(10.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: _columnChildren,
        ),
      );
    }

    return Container(
      margin: const EdgeInsets.only(bottom: 10.0),
      child: Column(
        children: <Widget>[
          _buildContent(),
          Divider(),
          _buildFunctionArea(),
        ],
      ),
    );
  }

  Widget _buildFunctionArea() {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 5.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: <Widget>[
          Row(
            children: <Widget>[
              Icon(
                Icons.arrow_forward,
                color: Color(0xffaaaaaa),
                size: 16.0,
              ),
              SizedBox(
                width: 5.0,
              ),
              Text(
                '转发',
                style: TextStyle(color: Color(0xffaaaaaa), fontSize: 12.0),
              ),
            ],
          ),
          Row(
            children: <Widget>[
              Icon(
                Icons.message,
                color: Color(0xffaaaaaa),
                size: 16.0,
              ),
              SizedBox(
                width: 5.0,
              ),
              Text(
                tweetData['commentCount'] == 0
                    ? '评论'
                    : '${tweetData['commentCount']}',
                style: TextStyle(color: Color(0xffaaaaaa), fontSize: 12.0),
              ),
            ],
          ),
          Row(
            children: <Widget>[
              Icon(
                Icons.thumb_up,
                color: Color(0xffaaaaaa),
                size: 16.0,
              ),
              SizedBox(
                width: 5.0,
              ),
              Text(
                '赞',
                style: TextStyle(color: Color(0xffaaaaaa), fontSize: 12.0),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
