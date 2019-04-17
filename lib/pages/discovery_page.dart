import 'package:flutter/material.dart';
import 'package:barcode_scan/barcode_scan.dart';
import 'package:flutter_oschina_demo/pages/common_web_page.dart';
import 'package:flutter_oschina_demo/pages/shake_page.dart';

///
/// author: bobo
/// create time: 2019/4/11 10:50 AM
/// email: jqbo84@163.com
///

class DiscoveryPage extends StatefulWidget {
  @override
  _DiscoveryPageState createState() => _DiscoveryPageState();
}

class _DiscoveryPageState extends State<DiscoveryPage> {
  List<Map<String, IconData>> blocks = [
    {
      '开源众包': Icons.pageview,
      '开源软件': Icons.speaker_notes_off,
      '码云推荐': Icons.screen_share,
      '代码骗贷': Icons.assignment,
    },
    {
      '扫一扫': Icons.camera_alt,
      '摇一摇': Icons.camera,
    },
    {
      '码云封面人物': Icons.person,
      '线下活动': Icons.android,
    }
  ];

  Future scan() async {
    String barcode = await BarcodeScanner.scan();
    print('扫一扫结果：$barcode');
  }

  void _handleItemClick(String title) {
    switch (title) {
      case '开源众包':
        _navToWebPage(title, 'https://zb.oschina.net/');
        break;
      case '扫一扫':
        scan();
        break;
      case '摇一摇':
        Navigator.of(context)
            .push(MaterialPageRoute(builder: (context) => ShakePage()));
        break;
    }
  }

  void _navToWebPage(String title, String url) {
    if (title != null && url != null) {
      Navigator.of(context).push(MaterialPageRoute(
          builder: (context) => CommonWebPage(
                title: title,
                url: url,
              )));
    }
  }

  @override
  Widget build(BuildContext context) {
    return ListView.separated(
        itemCount: blocks.length + 1,
        separatorBuilder: (context, blockIndex){
          if(blockIndex > 0) {
            return Container(
              color: Color(0xffeeeeee),
              height: 20.0,
            );
          } else {
            return Container(
              height: 0.0,
            );
          }
        },
        itemBuilder: (context, blockIndex) {
          if(blockIndex == 0){
            return Container(
              color: Color(0xffeeeeee),
              height: 20.0,
            );
          }
          blockIndex -= 1;
          return Container(
//            margin: const EdgeInsets.only(top: 20.0),
            decoration: BoxDecoration(
//              color: Color(0xffff0000),
              border: Border(
                top: BorderSide(
                  width: 0.5,
                  color: Color(0xffcccccc),
                ),
                bottom: BorderSide(
                  width: 0.5,
                  color: Color(0xffcccccc),
                ),
              ),
            ),
            child: ListView.separated(
                physics: NeverScrollableScrollPhysics(),
                //滑动冲突
                shrinkWrap: true,
                itemBuilder: (context, mapIndex) {
                  return InkWell(
                    onTap: () {
                      _handleItemClick(
                          blocks[blockIndex].keys.elementAt(mapIndex));
                    },
                    child: Container(
                      height: 60.0,
                      child: ListTile(
                        leading: Icon(
                            blocks[blockIndex].values.elementAt(mapIndex)),
                        title:
                            Text(blocks[blockIndex].keys.elementAt(mapIndex)),
                        trailing: Icon(Icons.arrow_forward_ios),
                      ),
                    ),
                  );
                },
                separatorBuilder: (context, mapIndex) {
                  return Divider(
                    height: 0.5,
                    indent: 20.0,
                    color: Color(0xffcccccc),
                  );
                },
                itemCount: blocks[blockIndex].length),
          );
        });
  }
}
