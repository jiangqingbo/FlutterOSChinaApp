import 'package:flutter/material.dart';
import 'package:flutter_oschina_demo/pages/news_detail_page.dart';

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
        Navigator.of(context).push(MaterialPageRoute(builder: (context)=>NewsDetailPage(id: newsList['id'],)));
      },
      child: Container(
        margin: EdgeInsets.only(left: 20.0),
        decoration: BoxDecoration(
          border: Border(
            bottom: BorderSide(
              color: Color(0xffcccccc),
              width: 0.5,
            ),
          ),
        ),
        child: Padding(
          padding: const EdgeInsets.only(top: 10.0, bottom: 10.0, right: 20.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              Text(
                '${newsList['title']}',
                style: TextStyle(
                    color: Color(0xff000000),
                    fontSize: 14.0,
                    fontWeight: FontWeight.bold),
                textAlign: TextAlign.left,
                maxLines: 2,
                overflow: TextOverflow.ellipsis,
              ),
              SizedBox(height: 10.0),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: <Widget>[
                  Text(
                    '@${newsList['author']}      ${newsList['pubDate'].toString().split(' ')[0]}',
                    style: TextStyle(color: Color(0xff888888), fontSize: 12.0),
                  ),
                  Row(
                    children: <Widget>[
                      Icon(
                        Icons.message,
                        color: Color(0xff888888),
                      ),
                      Text(
                        '${newsList['commentCount']}',
                        style:
                            TextStyle(color: Color(0xff888888), fontSize: 12.0),
                      ),
                    ],
                  )
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
