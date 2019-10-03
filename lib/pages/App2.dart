import 'dart:async';
import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:qqmusic/component/Toast.dart';
import 'package:qqmusic/pages/DynamicPage.dart';
import 'package:qqmusic/pages/ListenPage.dart';
import 'package:qqmusic/pages/LyricPage.dart';
import 'package:qqmusic/pages/MusichallPage.dart';
import 'package:qqmusic/pages/MyPage.dart';
import 'package:qqmusic/pages/PlayListDetailPage.dart';
import 'package:qqmusic/pages/PlayListTapPage.dart';
import 'package:qqmusic/pages/PlaySongBarPage.dart';
import 'package:qqmusic/pages/PlaySongPage.dart';
import 'package:qqmusic/pages/RecommendPage.dart';
import 'package:qqmusic/pages/SingersList.dart';
import 'package:qqmusic/pages/TopListPage.dart';
import 'package:qqmusic/pages/InheritedContext.dart';
import 'package:qqmusic/pages/InheritedTestModel.dart';
import 'package:flutter_ijkplayer/flutter_ijkplayer.dart';
import 'package:qqmusic/utils/HttpUtils.dart';
import 'package:qqmusic/utils/hexToColor.dart';

class App extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return new _AppState();
  }
}

class _AppState extends State<App> with TickerProviderStateMixin{
  IjkMediaController _audioPlayer = IjkMediaController();
  StreamSubscription _playFinishStream;
  InheritedTestModel inheritedTestModel;
  // AnimationController animationController;

  var _pageController = new PageController(initialPage: 0);
  Color _selectColor = hexToColor('#31c27c');
  Color _unselectColor = Colors.grey;
  String _recommendNum = '0';
  int _selectedIndex =  0;
  final _pageList = [
    MusichallPage(),
    RecommendPage(),
    DynamicPage(),
    MyPage(),
  ];
  List bottomTitles = ['音乐馆', '推荐', '动态', '我的'];
  List bottomImages = [
    ['assets/images/my_musichall_color_skin_selected.png', 'assets/images/my_musichall_color_skin_normal.png'], 
    ['assets/images/my_recommend_cale_color_skin_selected.png', 'assets/images/my_recommend_cale_color_skin_normal.png'], 
    ['assets/images/my_dynamic_color_skin_selected.png', 'assets/images/my_dynamic_color_skin_normal.png'], 
    ['assets/images/my_music_color_skin_selected.png', 'assets/images/my_music_color_skin_normal.png'], 
  ];

  @override
  void initState() {
    _initData();
    super.initState();
    if (inheritedTestModel.songList.length > 0) _initAudioPlayer();
    subscriptPlayFinish();
    // animationController = new AnimationController(vsync: this, duration: Duration(seconds: 10))
    // ..addListener(() {
    //   setState(() {});
    // })
    // ..addStatusListener((status) {
    //   if (status == AnimationStatus.completed) {
    //     //动画从 controller.forward() 正向执行 结束时会回调此方法
    //     //重置起点
    //     animationController.reset();
    //     //开启
    //     animationController.forward();
    //   }
    // });
  }

  @override
  void dispose() {
    _playFinishStream?.cancel();
    _audioPlayer.dispose();
    // animationController.dispose();
    super.dispose();
  }

  _initData() {
    inheritedTestModel = new InheritedTestModel([], 0, null);
  }
  
  _initAudioPlayer() async {
    try {
      int id = inheritedTestModel.songList[inheritedTestModel.songListIndex].id;
      var result = await HttpUtils.request("/song/url?id=$id");
      var data = json.decode(result);
      if (data['code'] == 200 && data['data'][0]['url'] != null) {
        await _audioPlayer.setNetworkDataSource(
          data['data'][0]['url'],
          autoPlay: true
        );
        _getLyric();
      } else {
        print('当前不能播放，自动下一首');
        if (inheritedTestModel.songList.length > 1) {
          _setIndex(inheritedTestModel.songListIndex + 1);
        }
      }
    } catch (e) {
      print(e);
    }
  }

  _getLyric() async {
    try {
      int id = inheritedTestModel.songList[inheritedTestModel.songListIndex].id;
      var result = await HttpUtils.request("/lyric?id=$id");
      var data = json.decode(result);
      if (data['code'] == 200) {
        if (data['lrc'] != null) {
          setState(() {
            _setLyric(LyricContent.from(data['lrc']['lyric'].toString()));
          });
        } else {
          setState(() {
            _setLyric(null);
          });
        }
      } else {
        setState(() {
            _setLyric(null);
          });
        Toast.toast(context, '没有数据');
      }
    } catch (e) {
      print(e);
    }
  }

  // 监听播放完自动下一首
  subscriptPlayFinish() {
    _playFinishStream = _audioPlayer.playFinishStream.listen((data) {
      print('监听播放完自动下一首');
      _setIndex(inheritedTestModel.songListIndex + 1);
    });
  }

  _incrementCount(songList, index) {
    setState(() {
      inheritedTestModel = new InheritedTestModel(
        songList, 
        index??inheritedTestModel.songListIndex, 
        inheritedTestModel.lyric, 
      );
    });
    _initAudioPlayer();
  }

  _reduceCount() async{
    await _audioPlayer.stop();
    setState(() {
      inheritedTestModel = new InheritedTestModel(
        [], 
        0, 
        inheritedTestModel.lyric, 
      );
    });
  }

  _setIndex(index) {
    if (index == inheritedTestModel.songList.length) {
      index = 0;
    }
    if (index == -1) {
      index = inheritedTestModel.songList.length - 1;
    }
    setState(() {
      inheritedTestModel = new InheritedTestModel(
        inheritedTestModel.songList, 
        index, 
        inheritedTestModel.lyric, 
      );
    });
    _initAudioPlayer();
  }

  _setLyric(lyric) {
    setState(() {
      inheritedTestModel = new InheritedTestModel(
        inheritedTestModel.songList,
        inheritedTestModel.songListIndex,
        lyric, 
      );
    });
  }

  void _onItemTapped(int index) {
    //bottomNavigationBar 和 PageView 关联
    _pageController.animateToPage(index,duration: const Duration(milliseconds: 300), curve: Curves.ease);
    // setState(() {
    //   _selectedIndex = index;
    // });
  }

  void _pageChange(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  Text getTabTitle(int index) {
    return new Text(bottomTitles[index]);
  }

  getTabIcon(int index) {
    bool isSelected = _selectedIndex == index;
    if (index == 1) {
      return Stack(
        children: <Widget>[
          Image.asset(
            bottomImages[index][isSelected ? 0 : 1],
            width: 28.0,
            height: 28.0,
            color: isSelected ? _selectColor : _unselectColor
          ),
          Positioned(
            left: 0,
            top: 1,
            child: Container(
              width: 28.0,
              height: 28.0,
              color: Colors.transparent,
              child: Center(
                child: Text(_recommendNum, style: TextStyle(fontSize: 10, color: isSelected ? _selectColor : _unselectColor),),
              ),
            ),
          ),
        ],
      );
    } else {
      return Image.asset(
        bottomImages[index][isSelected ? 0 : 1],
        width: 28.0,
        height: 28.0,
        color: isSelected ? _selectColor : _unselectColor
      );
    }
  }

  @override 
  Widget build(BuildContext context) {
    return new InheritedContext(
      inheritedTestModel: inheritedTestModel,
      increment: (songList, [index]) {
        _incrementCount(songList, index);
      },
      reduce: _reduceCount,
      setIndex: (index) {
        _setIndex(index);
      },
      child: new MaterialApp(
        theme: new ThemeData(
          primarySwatch: Colors.green,
        ),
        routes: { 
          'playListTapPage': (context) => PlayListTapPage(
            audioPlayer: _audioPlayer,
            handleTap: () => Navigator.push(context,
              MaterialPageRoute(
                builder: (context) {
                  return PlaySongPage(audioPlayer: _audioPlayer);
                },
                fullscreenDialog: true
              )
            ),
          ),
          'playListDetailPage': (context) => PlayListDetailPage(
            id: ModalRoute.of(context).settings.arguments,
            audioPlayer: _audioPlayer,
            handleTap: () => Navigator.push(context,
              MaterialPageRoute(
                builder: (context) {
                  return PlaySongPage(audioPlayer: _audioPlayer);
                },
                fullscreenDialog: true
              )
            ),
          ),
          // 'playSongPage': (context) => PlaySongPage(audioPlayer: _audioPlayer),
          'topListPage': (context) => TopListPage(),
          'singersList':(context) => SingersList(),
          'listenPage':(context) => ListenPage(),
        },
        home: Builder(
          builder: (context) => Scaffold(
            backgroundColor: Colors.grey[200],
            body: Stack(
              children: <Widget>[
                PageView(
                  controller: _pageController,
                  onPageChanged: _pageChange,
                  children: _pageList,
                ),
                Positioned(
                  left: 0,
                  bottom: 0,
                  width: 0,
                  child: Container(
                    height: 0, // 这里隐藏播放器
                    child: IjkPlayer(
                      mediaController: _audioPlayer,
                    ),
                  ),
                ),
                Positioned(
                  bottom: 0,
                  left: 0,
                  right: 0,
                  child: Hero(
                    tag: "PlaySongBarPage", //唯一标记，前后两个路由页Hero的tag必须相同
                    child: PlaySongBarPage(
                      audioPlayer: _audioPlayer,
                      handleTap: () => Navigator.push(context,
                        MaterialPageRoute(
                          builder: (context) {
                            return PlaySongPage(audioPlayer: _audioPlayer);
                          },
                          fullscreenDialog: true
                        )
                      ),
                      // animationController: animationController
                    ),
                  ),
                )
              ],
            ),
            bottomNavigationBar: BottomNavigationBar(
              fixedColor: _selectColor,
              backgroundColor: Colors.white,
              type: BottomNavigationBarType.fixed,
              currentIndex: _selectedIndex,
              selectedFontSize: 12.0,
              unselectedFontSize: 12.0,
              showSelectedLabels: true,
              onTap: _onItemTapped,
              items: <BottomNavigationBarItem>[
                new BottomNavigationBarItem(
                  icon: getTabIcon(0),
                  title: getTabTitle(0),
                ),
                new BottomNavigationBarItem(
                  icon: getTabIcon(1),
                  title: getTabTitle(1),
                ),
                new BottomNavigationBarItem(
                  icon: getTabIcon(2),
                  title: getTabTitle(2),
                ),
                new BottomNavigationBarItem(
                  icon: getTabIcon(3),
                  title: getTabTitle(3),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}