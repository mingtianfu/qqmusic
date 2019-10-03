import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_ijkplayer/flutter_ijkplayer.dart';
import 'package:qqmusic/component/Toast.dart';
import 'package:qqmusic/models/index.dart';
import 'package:qqmusic/pages/PlaySongBarPage.dart';
import 'package:qqmusic/utils/HttpUtils.dart';
import 'package:qqmusic/utils/hexToColor.dart';
import 'package:cached_network_image/cached_network_image.dart';

class PlayListTapPage extends StatefulWidget {
  PlayListTapPage({Key key, this.audioPlayer, this.handleTap}): super(key: key);
  final IjkMediaController audioPlayer;
  final handleTap;
  @override 
  _PlayListTapPageState createState() => _PlayListTapPageState();
}

class _PlayListTapPageState extends State<PlayListTapPage> with SingleTickerProviderStateMixin, AutomaticKeepAliveClientMixin{
  @override
  bool get wantKeepAlive => true;

  Color _color = hexToColor('#31c27c');
  TabController _tabController; //需要定义一个Controller
  ScrollController _scrollController = ScrollController(); //listview的控制器
  List<String> tabs = ['全部', '流行', '华语', '摇滚', '民谣', '说唱', '电子', '轻音乐'];
  List<int> tabsIndex = [0, 0, 0, 0, 0, 0, 0, 0];
  bool isMore = false;
  Map tabsList = {
    '全部': List<PlaylistItem>(),
    '流行': List<PlaylistItem>(),
    '华语': List<PlaylistItem>(),
    '摇滚': List<PlaylistItem>(),
    '民谣': List<PlaylistItem>(),
    '说唱': List<PlaylistItem>(),
    '电子': List<PlaylistItem>(),
    '轻音乐': List<PlaylistItem>(),
  };
  int activeIndex = 0;
  List<PlaylistItem> list = List<PlaylistItem>();

  @override
  void initState() {
    super.initState();
    // 创建Controller  
    _tabController = TabController(length: tabs.length, vsync: this);
    _tabController.addListener((){  
      setState(() {
        activeIndex = _tabController.index;
      });
      if (tabsList[_tabController.index].length == 0) {
        getPersonalized();
      }
    });
    _scrollController.addListener(() {
      if (_scrollController.position.pixels ==
          _scrollController.position.maxScrollExtent) {
        print('滑动到了最底部');
        getMore();
      }
    });
    getPersonalized();
  }

  getPersonalized([String tag]) async {
    try {
      var result = await HttpUtils.request("/top/playlist?cat=${tabs[activeIndex]}&offset=${tabsIndex[activeIndex]}&limit=30");
      // print(result);
        Playlist playlist = Playlist.fromJson(json.decode(result));
        if (playlist.code == 200 && playlist.playlists.length > 0) {
          setState(() {
            tabsIndex[activeIndex] = 0;
            tabsList[activeIndex] = playlist.playlists;
            list = playlist.playlists;
          });
        } else {
          Toast.toast(context, '没有数据');
        }
    } catch (e) {
      print(e);
    }
  }

  getMore() async {
    try {
      setState(() {
        isMore = true;
      });
      int offset = tabsIndex[activeIndex] + 1;
      var result = await HttpUtils.request("/top/playlist?cat=${tabs[activeIndex]}&offset=$offset&limit=30");
      // print(result);
        Playlist playlist = Playlist.fromJson(json.decode(result));
        if (playlist.code == 200 && playlist.playlists.length > 0) {
          setState(() {
            isMore = false;
            tabsIndex[activeIndex] = offset;
            tabsList[activeIndex].addAll(playlist.playlists);
            list.addAll(playlist.playlists);
          });
        } else {
          Toast.toast(context, '没有数据');
        }
    } catch (e) {
      print(e);
    }
  }

  Future<Null> _onRefresh() async{
    getPersonalized();
  }

  @override 
  Widget build(BuildContext context) {
    super.build(context);
    return Scaffold(
      appBar: AppBar( //导航栏
        leading: Builder(
          builder: (BuildContext context) {
            return IconButton(
              icon: Image.asset('assets/images/back_normal_black.png', width: 30,),
              onPressed: () { Navigator.of(context).pop(); },
            );
          },
        ),
        title: Text("歌单广场", style: TextStyle(color: Colors.black, fontWeight: FontWeight.normal),), 
        backgroundColor: Colors.white,
        elevation: .0,
        centerTitle: false,
        bottom: _bottomTab(),
      ),
      body: SafeArea(
        child: Column(
          children: <Widget>[
            Expanded(
              child: TabBarView(
                controller: _tabController,
                children: tabs.map((e) { //创建3个Tab页
                  return RefreshIndicator(
                    onRefresh: _onRefresh,
                    child: Container(
                      alignment: Alignment.topLeft,
                      padding: EdgeInsets.all(15.0),
                      child: _tabBarViewContext(),
                    ),
                  );
                }).toList(),
              ),
            ),
            Hero(
              tag: "PlaySongBarPage", //唯一标记，前后两个路由页Hero的tag必须相同
              child: PlaySongBarPage(
                audioPlayer: widget.audioPlayer,
                handleTap: widget.handleTap,
              ),
            )
          ],
        ),
        
      ),
    );
  }

  Widget _bottomTab() {
    return PreferredSize(
      preferredSize: Size.fromHeight(40.0),
      child: Stack(
        children: <Widget>[
          Container(
            padding: EdgeInsets.only(right: 20.0),
            child: TabBar(   //生成Tab菜单
              isScrollable: true,
              indicatorSize: TabBarIndicatorSize.label,
              indicatorColor: _color,
              labelColor: _color,
              labelStyle: TextStyle(
                fontSize: 14.0,
                fontWeight: FontWeight.bold,
              ),
              unselectedLabelColor: Colors.black,
              unselectedLabelStyle: TextStyle(
                fontSize: 14.0,
                fontWeight: FontWeight.normal,
              ),
              controller: _tabController,
              tabs: tabs.map((item) => Tab(
                child: Text(item),
              )).toList(),
            ),
          ),
          Positioned(
            right: 0,
            bottom: 0,
            child: Container(
              width: 50,
              height: 50,
              decoration: new BoxDecoration(
                gradient: const LinearGradient(
                  colors: [Colors.white24, Colors.white, Colors.white, Colors.white, Colors.white],
                ),
              ),
              child: Container(
                padding: EdgeInsets.only(left: 10, right: 10),
                child: GestureDetector(
                  child: Image.asset(
                    'assets/images/common_list_header_sort.png', 
                    width: 20,
                    color: Colors.black,
                  ),
                  onTap: () => Navigator.of(context).pop(),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _tabBarViewContext() {
    return Column(
      children: <Widget>[
        Expanded(
          child: GridView(
            controller: _scrollController,
            gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 3, //横轴三个子widget
              childAspectRatio: .7, //宽高比为1时，子widget
              crossAxisSpacing: 10,
              mainAxisSpacing: 10,
            ),
            // children: tabsList[activeIndex].map((item) => _item(item.coverImgUrl, item.name)).toList(),
            children: list.map((item) => _item(item.coverImgUrl, item.name, item.id)).toList(),
          ),
        ),
        isMore ? Container(
          padding: const EdgeInsets.all(16.0),
          alignment: Alignment.center,
          child: SizedBox(
              width: 24.0,
              height: 24.0,
              child: CircularProgressIndicator(strokeWidth: 2.0)
          ),
        ) : Container(height: 0,),
      ],
    );
  }

  Widget _item(String imgUrl, String label, int id) {
    return Container(
      child: GestureDetector(
        onTap: () {
          Navigator.of(context).pushNamed('playListDetailPage', arguments: id);
        },
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            ClipRRect(
              borderRadius: BorderRadius.circular(5),
              // child: Image.asset('assets/images/player_album_cover_default.png'),
              child: new CachedNetworkImage(
                placeholder: (context, url) => Image.asset('assets/images/player_album_cover_default.png'),
                imageUrl: imgUrl + '?param=200y200',
              ),
            ),
            Text(
              label,
              maxLines: 2,
              overflow: TextOverflow.ellipsis,
              textAlign: TextAlign.start,
              style: TextStyle(),
            ),
          ],
        ),
      ),
    );
  }

}