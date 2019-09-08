import 'package:flutter/material.dart';
import 'package:qqmusic/component/AppBarSearch.dart';

class RecommendPage extends StatefulWidget {
  @override 
  _RecommendPageState createState() => _RecommendPageState();
}

class _RecommendPageState extends State<RecommendPage> {

  void handlePresseSearch() {
    print('搜索页面');
  }

  void handleRecognize() {
    print('听歌识曲');
  }

  Widget build(BuildContext context) {
    return SafeArea(
      child: Scrollbar(
        child: SingleChildScrollView (
          child: AppBarSearch(
            title: '推荐', 
            rightImage: Image.asset('assets/images/icon_menu_recognize_lyric.png', width: 30,),
            onPressedRight: handleRecognize,
            onPressed: handlePresseSearch,
          ),
        ),
      ),
    );
  }
}