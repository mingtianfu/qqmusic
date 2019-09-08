import 'package:flutter/material.dart';
import 'package:qqmusic/component/AppBarSearch.dart';

class MyPage extends StatefulWidget {
  @override 
  _MyPageState createState() => _MyPageState();
}

class _MyPageState extends State<MyPage> {

  void handlePresseSearch() {
    print('搜索页面');
  }

  void handleRecognize() {
    print('更多页面');
  }

  Widget build(BuildContext context) {
    return SafeArea(
      child: Scrollbar(
        child: SingleChildScrollView (
          child: AppBarSearch(
            title: '我的', 
            rightImage: Image.asset('assets/images/fragment_my_music_more.png', width: 30,),
            onPressedRight: handleRecognize,
            onPressed: handlePresseSearch,
          ),
        ),
      ),
    );
  }
}