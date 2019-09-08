import 'package:flutter/material.dart';
import 'package:qqmusic/component/AppBarSearch.dart';
import 'package:qqmusic/pages/SingersList.dart';

class MusichallPage extends StatefulWidget {
  @override 
  _MusichallPageState createState() => _MusichallPageState();
}

class _MusichallPageState extends State<MusichallPage> {

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
          child: Column(
            children: <Widget>[
              AppBarSearch(
                title: '音乐馆', 
                rightImage: Image.asset('assets/images/icon_menu_recognize_lyric.png', width: 30,),
                onPressedRight: handleRecognize,
                onPressed: handlePresseSearch,
              ),
              Container(
                alignment: Alignment.topCenter,
                child: InkWell(
                  child: Text('Hero'),
                  onTap: () {
                    //打开B路由  
                    Navigator.push(context, PageRouteBuilder(
                        pageBuilder: (BuildContext context, Animation animation,
                            Animation secondaryAnimation) {
                          return new FadeTransition(
                            opacity: animation,
                            child: Scaffold(
                              appBar: AppBar(
                                title: Text("原图"),
                              ),
                              body: SingersList(),
                            ),
                          );
                        })
                    );
                  },
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}