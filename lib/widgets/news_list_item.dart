import 'package:flutter/material.dart';

///
/// author: bobo
/// create time: 2019/4/16 4:57 PM
/// email: jqbo84@163.com
///

class NewsListItem extends StatelessWidget {

  final Map<String, dynamic> newsList;

  NewsListItem({this.newsList});

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        //TODO
      },
      child: Container(
        decoration: BoxDecoration(
          border: Border(
            bottom: BorderSide(
              color: Color(0xffcccccc),
              width: 0.5,
            ),
          ),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            SizedBox(height: 10.0,),
            Text('  ${newsList['title']}', style: TextStyle(color: Color(0xff000000), fontSize: 14.0, decoration: TextDecoration.none), textAlign: TextAlign.left,),
            SizedBox(height: 10.0),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: <Widget>[
                Text(
                    '   @${newsList['author']}      ${newsList['pubDate'].toString().split(' ')[0]}',
                style: TextStyle(color: Color(0xff888888), fontSize: 12.0),),
                Row(
                  children: <Widget>[
                    Icon(Icons.message, color: Color(0xff888888),),
                    Text('${newsList['commentCount']}', style: TextStyle(color: Color(0xff888888), fontSize: 12.0),),
                    SizedBox(width: 10.0,),
                  ],
                )
              ],
            ),
            SizedBox(height: 10.0),
          ],
        ),
      ),
    );
  }
}
