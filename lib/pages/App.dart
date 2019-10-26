import 'dart:async';

import 'package:camera/camera.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:qqmusic/models/al.dart';
import 'package:qqmusic/models/ar.dart';
import 'package:qqmusic/models/trackItem.dart';
import 'package:qqmusic/pages/Database/ArHelper.dart';
import 'package:qqmusic/pages/Database/SongListHelper.dart';
import 'package:qqmusic/pages/DynamicPage.dart';
import 'package:qqmusic/pages/ListenPage.dart';
import 'package:qqmusic/pages/LoginPage.dart';
import 'package:qqmusic/pages/Model/PlayModel.dart';
import 'package:qqmusic/pages/MusichallPage.dart';
import 'package:qqmusic/pages/MvPlayPage.dart';
import 'package:qqmusic/pages/MyPage.dart';
import 'package:qqmusic/pages/PlayListDetailPage.dart';
import 'package:qqmusic/pages/PlayListTapPage.dart';
import 'package:qqmusic/pages/PlayNotification.dart';
import 'package:qqmusic/pages/PlaySongBarPage.dart';
import 'package:qqmusic/pages/RecommendPage.dart';
import 'package:qqmusic/pages/SearchPage.dart';
import 'package:qqmusic/pages/SingerDetailPage.dart';
import 'package:qqmusic/pages/SingersList.dart';
import 'package:qqmusic/pages/TakeVideoPage.dart';
import 'package:qqmusic/pages/TopListPage.dart';
import 'package:flutter_ijkplayer/flutter_ijkplayer.dart';
import 'package:qqmusic/utils/hexToColor.dart';

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

class _AppState extends State<App> with TickerProviderStateMixin {
  IjkMediaController _audioPlayer;
  StreamSubscription _playFinishStream;
  // AnimationController animationController;

  var _pageController = new PageController(initialPage: 0);
  Color _selectColor = hexToColor('#31c27c');
  Color _unselectColor = Colors.grey;
  String _recommendNum = '0';
  int _selectedIndex = 0;
  List _songList;

  final _pageList = [
    MusichallPage(),
    RecommendPage(),
    DynamicPage(),
    MyPage(),
  ];
  List bottomTitles = ['音乐馆', '推荐', '动态', '我的'];
  List bottomImages = [
    [
      'assets/images/my_musichall_color_skin_selected.png',
      'assets/images/my_musichall_color_skin_normal.png'
    ],
    [
      'assets/images/my_recommend_cale_color_skin_selected.png',
      'assets/images/my_recommend_cale_color_skin_normal.png'
    ],
    [
      'assets/images/my_dynamic_color_skin_selected.png',
      'assets/images/my_dynamic_color_skin_normal.png'
    ],
    [
      'assets/images/my_music_color_skin_selected.png',
      'assets/images/my_music_color_skin_normal.png'
    ],
  ];

  @override
  void initState() {
    super.initState();
    _getDataFromDb();
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    final playModel = Provider.of<PlayModel>(context);
    if (playModel.songList != this._songList) {
      _audioPlayer = playModel.audioPlayer;
    }
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
    // db.clear();
    // SharedPreferences prefs = await SharedPreferences.getInstance();
    List<TrackItem> _datas = [];
    List datas = await db.getTotalList();
    if (datas.length > 0) {
      for (int i = 0; i < datas.length; i++) {
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

      WidgetsBinding.instance.addPostFrameCallback((callback) {
        Provider.of<PlayModel>(context).setSongList(_datas);
      });
    }
    setState(() {});
  }

  void _onItemTapped(int index) {
    //bottomNavigationBar 和 PageView 关联
    _pageController.animateToPage(index,
        duration: const Duration(milliseconds: 300), curve: Curves.ease);
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
          Image.asset(bottomImages[index][isSelected ? 0 : 1],
              width: 28.0,
              height: 28.0,
              color: isSelected ? _selectColor : _unselectColor),
          Positioned(
            left: 0,
            top: 1,
            child: Container(
              width: 28.0,
              height: 28.0,
              color: Colors.transparent,
              child: Center(
                child: Text(
                  _recommendNum,
                  style: TextStyle(
                      fontSize: 10,
                      color: isSelected ? _selectColor : _unselectColor),
                ),
              ),
            ),
          ),
        ],
      );
    } else {
      return Image.asset(bottomImages[index][isSelected ? 0 : 1],
          width: 28.0,
          height: 28.0,
          color: isSelected ? _selectColor : _unselectColor);
    }
  }

  @override
  Widget build(BuildContext context) {
    return NotificationListener<PlayNotification>(
      onNotification: (notification) {
        _audioPlayer?.playOrPause();
        return true;
      },
      child: new MaterialApp(
        theme: new ThemeData(
          primarySwatch: Colors.green,
        ),
        routes: {
          'searchPage': (context) => SearchPage(),
          'playListTapPage': (context) => PlayListTapPage(),
          'playListDetailPage': (context) => PlayListDetailPage(
                id: ModalRoute.of(context).settings.arguments,
              ),
          'topListPage': (context) => TopListPage(),
          'singersList': (context) => SingersList(),
          'singerDetailPage': (context) => SingerDetailPage(
                id: ModalRoute.of(context).settings.arguments,
              ),
          'mvPlayPage': (context) => MvPlayPage(
                id: ModalRoute.of(context).settings.arguments,
              ),
          'loginPage': (context) => LoginPage(),
          'listenPage': (context) => ListenPage(),
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
                    child: PlaySongBarPage(),
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
