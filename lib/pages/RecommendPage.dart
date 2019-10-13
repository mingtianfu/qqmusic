import 'dart:async';

import 'package:flutter/material.dart';
import 'package:qqmusic/component/AppBarSearch.dart';
import 'package:qqmusic/pages/DataAppPage.dart';

class RecommendPage extends StatefulWidget {
  @override 
  _RecommendPageState createState() => _RecommendPageState();
}

class _RecommendPageState extends State<RecommendPage> with AutomaticKeepAliveClientMixin{
  @override
  bool get wantKeepAlive => true;

  ScrollController _controller = new ScrollController();
  Timer _countdownTimer;
  int _countdownNum = 59;
  int index = 1;

  @override
  void initState() {
    super.initState();
    // reGetCountdown();
  }

  void reGetCountdown() {
    setState(() {
      if (_countdownTimer != null) {
          return;
      }
      _countdownTimer = new Timer.periodic(new Duration(seconds: 1), (timer) {
        print(_countdownNum);
        setState(() {
          if (_countdownNum > 0) {
            _countdownNum = _countdownNum - 1;
            index = index + 1;
          } else {
            _countdownNum = 59;
            _countdownTimer.cancel();
            _countdownTimer = null;
          }
        });
        _controller.animateTo(
          double.parse((24*index).toString()), 
          duration: Duration(milliseconds: 200), 
          curve: Curves.ease
        );
      });
    });
  }

  // 不要忘记在这里释放掉Timer
  @override
  void dispose() {
    _countdownTimer?.cancel();
    _countdownTimer = null;
    super.dispose();
  }

  void handlePresseSearch() {
    print('搜索页面');
  }

  void handleRecognize() {
    print('听歌识曲');
  }

  @override
  Widget build(BuildContext context) {
    super.build(context);
    return SafeArea(
      child: Scrollbar( // 显示进度条
        child: SingleChildScrollView (
          child: Column(
            children: <Widget>[
              AppBarSearch(
                title: '推荐', 
                rightImage: Image.asset('assets/images/icon_menu_recognize_lyric.png', width: 30,),
                onPressedRight: handleRecognize,
                onPressed: handlePresseSearch,
              ),
              Text('data'),
              FlatButton(
                child: Text("sqflite"),
                onPressed: () {
                  Navigator.push( context,
                    MaterialPageRoute(builder: (context) {
                        return DataAppPage();
                    }));
                },
              ),
              FlatButton(
                child: Text("拍照"),
                onPressed: () {
                  Navigator.of(context).pushNamed('cameraPage');
                },
              ),
              FlatButton(
                child: Text("拍视频"),
                onPressed: () {
                  Navigator.of(context).pushNamed('takeVideoPage');
                },
              )
            ],
          ),
        ),
      ),
    );
  }
}