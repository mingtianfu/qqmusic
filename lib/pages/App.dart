import 'dart:async';
import 'dart:convert';

import 'package:camera/camera.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:qqmusic/component/Toast.dart';
import 'package:qqmusic/models/al.dart';
import 'package:qqmusic/models/ar.dart';
import 'package:qqmusic/models/trackItem.dart';
import 'package:qqmusic/pages/Database/ArHelper.dart';
import 'package:qqmusic/pages/Database/SongListHelper.dart';
import 'package:qqmusic/pages/DynamicPage.dart';
import 'package:qqmusic/pages/ListenPage.dart';
import 'package:qqmusic/pages/LyricPage.dart';
import 'package:qqmusic/pages/Model/PlayModel.dart';
import 'package:qqmusic/pages/MusichallPage.dart';
import 'package:qqmusic/pages/MvPlayPage.dart';
import 'package:qqmusic/pages/MyPage.dart';
import 'package:qqmusic/pages/PlayListDetailPage.dart';
import 'package:qqmusic/pages/PlayListTapPage.dart';
import 'package:qqmusic/pages/PlaySongBarPage.dart';
import 'package:qqmusic/pages/PlaySongPage.dart';
import 'package:qqmusic/pages/RecommendPage.dart';
import 'package:qqmusic/pages/SearchPage.dart';
import 'package:qqmusic/pages/SingerDetailPage.dart';
import 'package:qqmusic/pages/SingersList.dart';
import 'package:qqmusic/pages/TakeVideoPage.dart';
import 'package:qqmusic/pages/TopListPage.dart';
import 'package:flutter_ijkplayer/flutter_ijkplayer.dart';
import 'package:qqmusic/utils/HttpUtils.dart';
import 'package:qqmusic/utils/hexToColor.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'CameraPage.dart';

class App extends StatefulWidget {
  final List<CameraDescription> cameras;
 
  const App({
    Key key,
    @required this.cameras,
  }) : super(key: key);

  @override
  State<StatefulWidget> createState() {
    return new _AppState();
  }
}

class _AppState extends State<App> with TickerProviderStateMixin{
  IjkMediaController _audioPlayer = IjkMediaController();
  StreamSubscription _playFinishStream;
  // AnimationController animationController;

  var _pageController = new PageController(initialPage: 0);
  Color _selectColor = hexToColor('#31c27c');
  Color _unselectColor = Colors.grey;
  String _recommendNum = '0';
  int _selectedIndex =  0;
  List _songList;
  int _songListIndex;
  bool _autoPlay = false;

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
    super.initState();
    // if (_playModel.songList != null) {
    //   _initAudioPlayer();
    // }
    // WidgetsBinding.instance.addPostFrameCallback((callback){
    //   Provider.of<CounterModel>(context).increment();
    // });
    _getDataFromDb();
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
  void didChangeDependencies() {
    super.didChangeDependencies();
    final playModel = Provider.of<PlayModel>(context);
     if (playModel.songList.length == 0) {
       setState(() {
          _songList = playModel.songList;
          _songListIndex = playModel.songListIndex;
          _autoPlay = playModel.autoPlay;
        });
       _audioPlayer.stop();
    } else {
      if (playModel.songList != this._songList && playModel.songListIndex != this._songListIndex) {
        setState(() {
          _songList = playModel.songList;
          _songListIndex = playModel.songListIndex;
          _autoPlay = playModel.autoPlay;
        });
        _initAudioPlayer();
      } else if (playModel.songList != this._songList && playModel.songListIndex == this._songListIndex) {
        setState(() {
          _songList = playModel.songList;
          _autoPlay = playModel.autoPlay;
        });
        _initAudioPlayer();
      }else if (playModel.songList == this._songList && playModel.songListIndex != this._songListIndex) {
        setState(() {
          _songListIndex = playModel.songListIndex;
          _autoPlay = playModel.autoPlay;
        });
        _initAudioPlayer();
      }
    }
    print(playModel.songList.length);
  }

  @override
  void dispose() {
    _playFinishStream?.cancel();
    _audioPlayer.dispose();
    super.dispose();
  }

  _getDataFromDb() async {
    var db = SongListHelper();
    var dbAr = ArHelper();
    SharedPreferences prefs = await SharedPreferences.getInstance();
    List<TrackItem> _datas = [];
    List datas = await db.getTotalList();
    if (datas.length > 0) {
      for(int i = 0; i < datas.length; i++){
        Song item = Song.fromMap(datas[i]);
        TrackItem trackItem = TrackItem();
        Ar ar = Ar();
        Al al = Al();
        trackItem.name = item.name;
        trackItem.id = item.id;
        trackItem.ar = [];
        al.picUrl = item.picUrl;
        trackItem.al = al;
        ArItem aa = await dbAr.getItem(item.arId);
        if (aa != null) {
          ar.name = aa.name;
          ar.id = aa.id;
          trackItem.ar.add(ar);
        }
        _datas.add(trackItem);
      }
      
      WidgetsBinding.instance.addPostFrameCallback((callback){
        Provider.of<PlayModel>(context).setSongList(_datas);
        Provider.of<PlayModel>(context).setSongListIndex(prefs.getInt('songListIndex')??0);
        Provider.of<PlayModel>(context).setAutoPlay(false);
      });
    }
    setState(() {
    });
  }

  _initAudioPlayer() async {
    try {
      int id = _songList[_songListIndex].id;
      var result = await HttpUtils.request("/song/url?id=$id");
      var data = json.decode(result);
      if (data['code'] == 200 && data['data'][0]['url'] != null) {
        await _audioPlayer.setNetworkDataSource(
          data['data'][0]['url'],
          autoPlay: true
        );
        if (_autoPlay) {
          print(_autoPlay);
          _audioPlayer.play();
        }
        _getLyric(id);
      } else {
        print('当前不能播放，自动下一首');
        if (_songList.length > 1) {
          next(_songListIndex + 1);
        }
      }
    } catch (e) {
      print(e);
    }
  }

  _getLyric(id) async {
    try {
      var result = await HttpUtils.request("/lyric?id=$id");
      var data = json.decode(result);
      if (data['code'] == 200) {
        if (data['lrc'] != null) {
          WidgetsBinding.instance.addPostFrameCallback((callback){
            Provider.of<PlayModel>(context).setLyric(LyricContent.from(data['lrc']['lyric'].toString()));
          });
        } else {
          WidgetsBinding.instance.addPostFrameCallback((callback){
            Provider.of<PlayModel>(context).setLyric(null);
          });
        }
      } else {
        WidgetsBinding.instance.addPostFrameCallback((callback){
          Provider.of<PlayModel>(context).setLyric(null);
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
      next(_songListIndex + 1);
    });
  }

  next(index) {
    if (index == _songList.length) {
      index = 0;
    }
    if (index == -1) {
      index = _songList.length - 1;
    }
    WidgetsBinding.instance.addPostFrameCallback((callback){
      Provider.of<PlayModel>(context).setSongListIndex(_songListIndex + 1);
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
    return new MaterialApp(
      theme: new ThemeData(
        primarySwatch: Colors.green,
      ),
      // onGenerateRoute:(RouteSettings settings){
      //   print(settings.name);
      //   return MaterialPageRoute(
      //     builder: (context){
      //     String routeName = settings.name;
      //     // 如果访问的路由页需要登录，但当前未登录，则直接返回登录页路由，
      //     // 引导用户登录；其它情况则正常打开路由。
      //   }
      //   );
      // },
      routes: {
        'searchPage': (context) => SearchPage(
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
          // initAudioPlayer: _initAudioPlayer,
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
        'singersList': (context) => SingersList(
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
        'singerDetailPage': (context) => SingerDetailPage(
          id: ModalRoute.of(context).settings.arguments,
          audioPlayer: _audioPlayer,
          // initAudioPlayer: _initAudioPlayer,
          handleTap: () => Navigator.push(context,
            MaterialPageRoute(
              builder: (context) {
                return PlaySongPage(audioPlayer: _audioPlayer);
              },
              fullscreenDialog: true
            )
          ),
        ),
        'mvPlayPage': (context) => MvPlayPage(
          id: ModalRoute.of(context).settings.arguments,
        ),
        'listenPage':(context) => ListenPage(),
        'cameraPage': (context) => CameraPage(
          cameras: widget.cameras,
        ),
        'takeVideoPage': (context) => TakeVideoPage(
          cameras: widget.cameras,
        ),
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
    );
  }
}