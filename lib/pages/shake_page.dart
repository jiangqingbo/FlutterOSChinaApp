import 'package:flutter/material.dart';

///
/// author: bobo
/// create time: 2019/4/16 5:46 PM
/// email: jqbo84@163.com
///

class ShakePage extends StatefulWidget {
  @override
  _ShakePageState createState() => _ShakePageState();
}

class _ShakePageState extends State<ShakePage> {
  bool isShaked = false;
  int _curentIndex = 0;

  @override
  void initState() {
    super.initState();

  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('摇一摇'),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Image.asset(
              'assets/images/shake.png',
              width: 120.0,
              height: 120.0,
            ),
            SizedBox(
              height: 10.0,
            ),
            Text('摇一摇获取礼品'),
          ],
        ),
      ),
      bottomNavigationBar: BottomNavigationBar(
        items: [
          BottomNavigationBarItem(icon: Icon(Icons.folder), title: Text('礼品')),
          BottomNavigationBarItem(
              icon: Icon(Icons.assignment), title: Text('资讯'))
        ],
        currentIndex: _curentIndex,
        onTap: (index) {
          if (!mounted) return;
          setState(() {
            _curentIndex = index;
          });
        },
      ),
    );
  }
}
