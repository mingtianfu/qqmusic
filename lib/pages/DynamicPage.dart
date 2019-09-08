import 'package:flutter/material.dart';
import 'package:qqmusic/component/AppBarDynamic.dart';

class DynamicPage extends StatefulWidget {
  @override 
  _DynamicPageState createState() => _DynamicPageState();
}

class _DynamicPageState extends State<DynamicPage> {
  void handlePresseForward() {
    print('handlePresseForward');
  }

  void handlePresseReverse() {
    print('handlePresseReverse');
  }

  void handleRecognize() {
    print('更多推荐');
  }

  Widget build(BuildContext context) {
    return SafeArea(
      child: Scrollbar(
        child: SingleChildScrollView (
          child: AppBarDynamic(
            title: '动态', 
            rightImage: Image.asset('assets/images/discovery_add_follow_light.png', width: 30,),
            onPressedRight: handleRecognize,
            onPressedForward: handlePresseForward,
            onPressedReverse: handlePresseReverse,
          ),
        ),
      ),
    );
  }
}