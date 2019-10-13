import 'dart:convert';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_ijkplayer/flutter_ijkplayer.dart';
import 'package:provider/provider.dart';
import 'package:qqmusic/component/Toast.dart';
import 'package:qqmusic/models/index.dart';
import 'package:qqmusic/pages/Model/PlayModel.dart';
import 'package:qqmusic/pages/PlaySongBarPage.dart';
import 'package:qqmusic/utils/HttpUtils.dart';
import 'package:qqmusic/utils/hexToColor.dart';

class SingerDetailPage extends StatefulWidget {
    SingerDetailPage({Key key, this.id, this.audioPlayer, this.initAudioPlayer, this.handleTap}) : super(key: key);
  final int id;
  final IjkMediaController audioPlayer;
  final initAudioPlayer;
  final handleTap;
  @override
  _TestPageState createState() => _TestPageState();
}

class _TestPageState extends State<SingerDetailPage> with SingleTickerProviderStateMixin{
  TabController _tabController; //需要定义一个Controller
  ScrollController _scrollController = ScrollController();
  List tabs = ["歌曲", "专辑", "视频", "详情"];
  ArtistItem artist;
  List<TrackItem> songList = [];
  List<Introduction> introduction = [];
  List<AlbumItem> albums = [];
  List<MvItem> mvs = [];
  String briefDesc;
  Color _selectColor = hexToColor('#31c27c');
  int mvOffset = 0;

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: tabs.length, vsync: this)
    ..addListener((){
      print(_tabController.index);
      if (_tabController.index == 1 && albums.length == 0) {
        getArtistAlbum();
      }
      if (_tabController.index == 2 && mvs.length == 0) {
        getArtistMv();
      }
      if (_tabController.index == 3 && briefDesc == null) {
        getArtistDesc();
      }
    });
    _scrollController.addListener(() {
      if (_scrollController.position.pixels ==
          _scrollController.position.maxScrollExtent) {
        print('滑动到了最底部: ${_tabController.index}');
        if (_tabController.index == 2 && mvs.length >= 30) {
          getMoreArtistMv();
        }
      }
    });
    getArtist();
  }

  @override
  void dispose() {
    _tabController.dispose();
    super.dispose();
  }

  // 获取歌手单曲
  getArtist() async {
    try {
      var result = await HttpUtils.request("/artists?id=${widget.id}");
      if (json.decode(result)['code'] == 200) {
        List responseJson = json.decode(result)['hotSongs'];
        List<TrackItem> list = responseJson.map((m) => new TrackItem.fromJson(m)).toList();
        setState(() {
          artist = ArtistItem.fromJson(json.decode(result)['artist']);
          songList = list;
        });
      } else {
        Toast.toast(context, '没有数据');
      }
    } catch (e) {
      print(e);
    }
  }

  // 获取歌手专辑
  getArtistAlbum() async {
    try {
      var result = await HttpUtils.request("/artist/album?offset=0&limit=30&id=${widget.id}");
      if (json.decode(result)['code'] == 200) {
        List responseJson = json.decode(result)['hotAlbums'];
        List<AlbumItem> list = responseJson.map((m) => new AlbumItem.fromJson(m)).toList();
        setState(() {
          albums = list;
        });
      } else {
        Toast.toast(context, '没有数据');
      }
    } catch (e) {
      print(e);
    }
  }

  // 获取歌手mv
  getArtistMv() async {
    try {
      var result = await HttpUtils.request("/artist/mv?offset=0&limit=30&id=${widget.id}");
      if (json.decode(result)['code'] == 200) {
        List responseJson = json.decode(result)['mvs'];
        List<MvItem> list = responseJson.map((m) => new MvItem.fromJson(m)).toList();
        setState(() {
          mvs = list;
        });
      } else {
        Toast.toast(context, '没有数据');
      }
    } catch (e) {
      print(e);
    }
  }

  // 获取歌手mv
  getMoreArtistMv() async {
    try {
      int offset = mvOffset + 1;
      var result = await HttpUtils.request("/artist/mv?offset=$offset&limit=30&id=${widget.id}");
      if (json.decode(result)['code'] == 200) {
        List responseJson = json.decode(result)['mvs'];
        List<MvItem> list = responseJson.map((m) => new MvItem.fromJson(m)).toList();
        setState(() {
          mvs.addAll(list);
          mvOffset = offset;
        });
      } else {
        Toast.toast(context, '没有数据');
      }
    } catch (e) {
      print(e);
    }
  }

  // 获取歌手描述
  getArtistDesc() async {
    try {
      var result = await HttpUtils.request("/artist/desc?id=${widget.id}");
      if (json.decode(result)['code'] == 200) {
        List responseJson = json.decode(result)['introduction'];
        List<Introduction> list = responseJson.map((m) => new Introduction.fromJson(m)).toList();
        setState(() {
          briefDesc = json.decode(result)['briefDesc'];
          introduction = list;
        });
      } else {
        Toast.toast(context, '没有数据');
      }
    } catch (e) {
      print(e);
    }
  }

  Future<Null> _onRefresh() async{
    getArtistAlbum();
  }

  @override
  Widget build(BuildContext context) {
    return new DefaultTabController(
      length: tabs.length,
      child: Scaffold(
        body:  Stack(
          children: <Widget>[
            Container(
              padding: EdgeInsets.only(bottom: 40),
              child: _buildContext()
            ),
            Positioned(
              bottom: 0,
              left: 0,
              right: 0,
              child: Hero(
                tag: "PlaySongBarPage", //唯一标记，前后两个路由页Hero的tag必须相同
                child: PlaySongBarPage(
                  audioPlayer: widget.audioPlayer,
                  handleTap: widget.handleTap,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildContext() {
    return new NestedScrollView(
      headerSliverBuilder: (context, bool) {
        return [
          SliverAppBar(
            backgroundColor: _selectColor,
            elevation: 0,
            pinned: true,
            expandedHeight: 250.0,
            flexibleSpace: FlexibleSpaceBar(
              title: Text(
                artist == null ? '' : artist.name
              ),
              centerTitle: true,
              background: artist == null 
                ? Image.asset("assets/images/p.jpg", fit: BoxFit.cover,)
                : CachedNetworkImage(
                  placeholder: (context, url) => Image.asset('assets/images/p.jpg', fit: BoxFit.cover,),
                  imageUrl: artist.picUrl,
                  fit: BoxFit.cover,
                ),
            ),
          ),
          new SliverPersistentHeader(
            delegate: new SliverTabBarDelegate(
              new TabBar(
                tabs: tabs.map((f) => Tab(text: f)).toList(),
                indicatorSize: TabBarIndicatorSize.label,
                indicatorColor: _selectColor,
                labelColor: _selectColor,
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
              ),
              color: Colors.white,
            ),
            pinned: true,
          ),
        ];
      },
      body: TabBarView(
        controller: _tabController,
        children: <Widget>[
          _listBuild(),
          _albumBuild(),
          _mvBuild(),
          _descBuild()
        ]
      ),
    );
  }

  Widget _fixedBuild() {
    return Consumer<PlayModel>(
      builder: (BuildContext context, PlayModel playModel, child) {
        return GestureDetector(
          onTap: () {
            playModel.setSongList(songList);
            playModel.setSongListIndex(0);
            playModel.setAutoPlay(true);
          },
          child: child,
        );
      },
      child: Container(
        padding: EdgeInsets.only(top: 10, left: 15, right: 15),
        height: 50,
        child: Row(
          children: <Widget>[
            Container(
              padding: EdgeInsets.only(right: 10),
              width: 40,
              child: Image.asset(
                'assets/images/ringtone_play.png',
                width: 26,
              ),
            ),
            Expanded(
              child: Text(
                '全部播放(${songList.length})',
              ),
            ),
            GestureDetector(
              onTap: () {
                print('ddd');
              },
              child: Container(
                child: Image.asset(
                  'assets/images/ic_download_list_download.png',
                  width: 30,
                ),
              ),
            ),
            GestureDetector(
              onTap: () {
                print('ddd');
              },
              child: Container(
                child: Image.asset(
                  'assets/images/common_list_header_mutilchoose_not_follow_skin_highnight.png',
                  width: 30,
                ),
              ),
            )
          ],
        ),
      ),
    );
  }

  Widget _listBuild() {
    return songList.length == 0
    ? Padding(
        padding: const EdgeInsets.all(30.0),
        child: Center(child: CircularProgressIndicator(),),
      )
    : new Column(
      children: <Widget>[
        _fixedBuild(),
        Expanded(
          child: ListView.builder(
            // controller: _scrollController,
            itemExtent: 50,
            itemCount: songList.length,
            itemBuilder: (BuildContext context, int index) {
              //创建列表项
              return Consumer<PlayModel>(
                builder: (BuildContext context, PlayModel playModel,  _) {
                  num id = playModel.songList.length == 0 ? -1 : playModel.songList[playModel.songListIndex].id;
                  return Center(
                    child: Container(
                      // color: Colors.white,
                      padding: EdgeInsets.only(right: 15, bottom: 10),
                      child: GestureDetector(
                        onTap: () {
                          playModel.setSongList(songList);
                          playModel.setSongListIndex(index);
                          playModel.setAutoPlay(true);
                        },
                        child: Row(
                          children: <Widget>[
                            Container(
                              width: 3,
                              height: 40,
                              color: id == songList[index].id 
                              ? _selectColor 
                              : Colors.white,
                            ),
                            SizedBox(
                              width: 56,
                              height: 40,
                              child: Center(
                                child: new Text((index + 1).toString(),
                                    style: TextStyle(
                                        fontSize: 16,
                                        color: id == songList[index].id
                                            ? _selectColor
                                            : Colors.grey
                                    )),
                              ),
                            ),
                            Expanded(
                              child: Column(
                                mainAxisAlignment: MainAxisAlignment.start,
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: <Widget>[
                                  new Text(
                                    songList[index].name,
                                    maxLines: 1,
                                    overflow: TextOverflow.ellipsis,
                                    style: TextStyle(
                                        color: id == songList[index].id
                                            ? _selectColor
                                            : Colors.black
                                            ),
                                  ),
                                  new Text(
                                    '${songList[index].ar[0].name} - ${songList[index].al.name}',
                                    maxLines: 1,
                                    overflow: TextOverflow.ellipsis,
                                    style: TextStyle(
                                        fontSize: 12,
                                        color: id == songList[index].id
                                            ? _selectColor
                                            : Colors.grey
                                            ),
                                  ),
                                ],
                              ),
                            ),
                            GestureDetector(
                              onTap: () {
                                print('ddd');
                              },
                              child: Container(
                                child: Image.asset(
                                  'assets/images/item_mv_icon.png',
                                  width: 30,
                                ),
                              ),
                            ),
                            GestureDetector(
                              onTap: () {
                                print('ddd');
                              },
                              child: Container(
                                child: Image.asset(
                                  'assets/images/item_more_icon.png',
                                  width: 30,
                                ),
                              ),
                            )
                          ],
                        ),
                      ),
                    ),
                  );
                },
              );
            },
          ),
        ),
      ],
    );
  }

  Widget _albumBuild() {
    return RefreshIndicator(
      onRefresh: _onRefresh,
      child: Container(
        padding: EdgeInsets.all(15.0),
        child: Column(
          children: <Widget>[
            Row(children: <Widget>[
              Text('${albums.length}张专辑'),
              Expanded(child: Container(),)
            ],),
            Expanded(
              child: ListView.builder(
                // controller: _scrollController,
                itemExtent: 80,
                itemCount: albums.length,
                itemBuilder: (BuildContext context, int index) {
                  return Row(
                    children: <Widget>[
                      Container(
                        padding: EdgeInsets.only(right: 10),
                        width: 70,
                        height: 60,
                        child: ClipRRect(
                          borderRadius: BorderRadius.circular(5.0),
                          child: CachedNetworkImage(
                            placeholder: (context, url) => Image.asset('assets/images/p.jpg', fit: BoxFit.cover,),
                            imageUrl: albums[index].picUrl + '?param=50y50',
                            fit: BoxFit.cover,
                          ),
                        ),
                      ),
                      Expanded(
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: <Widget>[
                            Text(albums[index].name, style: TextStyle(fontSize: 18),),
                            Row(
                              children: <Widget>[
                              Text(DateTime.fromMicrosecondsSinceEpoch(albums[index].publishTime).toString().substring(0, 10), style: TextStyle(fontSize: 12, color: Colors.grey),),
                              Container(width: 10,),
                              Text('${albums[index].size}首', style: TextStyle(fontSize: 12, color: Colors.grey),),
                            ],)
                          ],
                        ),
                      ),
                    ],
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _mvBuild() {
    return RefreshIndicator(
      onRefresh: _onRefresh,
      child: Container(
        padding: EdgeInsets.all(15.0),
        child: Column(
          children: <Widget>[
            Row(children: <Widget>[
              Text('${mvs.length}个视频'),
            ],),
            Expanded(
              child: GridView.builder(
                controller: _scrollController,
                gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 2, //每行三列
                  childAspectRatio: .78, //显示区域宽高相等
                  crossAxisSpacing: 10,
                  mainAxisSpacing: 10,
                ),
                itemCount: mvs.length,
                itemBuilder: (BuildContext context, int index) {
                  return GestureDetector(
                    onTap: () {
                      Navigator.of(context).pushNamed('mvPlayPage', arguments: mvs[index].id);
                    },
                    child: Column(
                      children: <Widget>[
                        Container(
                          padding: EdgeInsets.only(bottom: 10),
                          child: Stack(
                            children: <Widget>[
                              ClipRRect(
                                borderRadius: BorderRadius.circular(5.0),
                                child: CachedNetworkImage(
                                  placeholder: (context, url) => Image.asset('assets/images/p.jpg', fit: BoxFit.cover,),
                                  imageUrl: mvs[index].imgurl + '?param=200y200',
                                  fit: BoxFit.cover,
                                ),
                              ),
                              Positioned(
                                right: 0,
                                bottom: 0,
                                left: 0,
                                height: 100,
                                child: Container(
                                  padding: EdgeInsets.only(left: 10, right: 10, bottom: 5),
                                  alignment: Alignment.bottomLeft,
                                  decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(5.0),
                                    gradient: LinearGradient(
                                      begin: Alignment.topCenter,
                                      end: Alignment.bottomCenter,
                                      colors:[Colors.transparent, Colors.black87]
                                    ), //背景渐变
                                  ),
                                  child: Row(
                                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                    children: <Widget>[
                                      Text(mvs[index].publishTime.toString(), style: TextStyle(color: Colors.white),),
                                      Text('${(mvs[index].playCount/10000).toStringAsFixed(1)}万', style: TextStyle(color: Colors.white),),
                                    ],
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                        Expanded(
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.start,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: <Widget>[
                              Text(mvs[index].name, style: TextStyle(fontSize: 12),),
                            ],
                          ),
                        ),
                      ],
                    )
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _descBuild() {
    return  briefDesc == null
    ? Padding(
        padding: const EdgeInsets.all(30.0),
        child: Center(child: CircularProgressIndicator(),),
      )
    : CustomScrollView(
      controller: _scrollController,
      slivers: <Widget>[
        SliverPadding(
          padding: const EdgeInsets.all(15.0),
          sliver: SliverToBoxAdapter(
            child: Text(briefDesc == null ? '' : briefDesc),
          ),
        ),
        new SliverList(
          delegate: new SliverChildBuilderDelegate(
            (BuildContext context, int index) {
              return new Container(
                padding: const EdgeInsets.all(15.0),
                child: Column(
                  children: <Widget>[
                    Padding(
                      padding: EdgeInsets.only(bottom: 10),
                      child: Text(introduction[index].ti,
                        textAlign: TextAlign.right,
                        style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold,),
                      ),
                    ),
                    Text(introduction[index].txt)
                  ],
                ),
              );
            },
            childCount: introduction.length
          ),
        ),
      ],
    );
  }
}

class SliverTabBarDelegate extends SliverPersistentHeaderDelegate {
  final TabBar widget;
  final Color color;

  const SliverTabBarDelegate(this.widget, {this.color})
      : assert(widget != null);

  @override
  Widget build(
      BuildContext context, double shrinkOffset, bool overlapsContent) {
    return new Container(
      child: widget,
      color: color,
    );
  }

  @override
  bool shouldRebuild(SliverTabBarDelegate oldDelegate) {
    return false;
  }

  @override
  double get maxExtent => widget.preferredSize.height;

  @override
  double get minExtent => widget.preferredSize.height;
}