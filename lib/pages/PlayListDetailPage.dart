import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_ijkplayer/flutter_ijkplayer.dart';
import 'package:provider/provider.dart';
import 'package:qqmusic/component/SliverAppBarDelegate.dart';
import 'package:qqmusic/component/Toast.dart';
import 'package:qqmusic/models/index.dart';
import 'package:qqmusic/pages/Model/PlayModel.dart';
import 'package:qqmusic/pages/PlaySongBarPage.dart';
import 'package:qqmusic/utils/HttpUtils.dart';
import 'package:qqmusic/utils/hexToColor.dart';

class PlayListDetailPage extends StatefulWidget {
  PlayListDetailPage({Key key, this.id, this.audioPlayer, this.initAudioPlayer, this.handleTap}) : super(key: key);
  final int id;
  final IjkMediaController audioPlayer;
  final initAudioPlayer;
  final handleTap;
  @override
  _PlayListDetailPageState createState() => _PlayListDetailPageState();
}

class _PlayListDetailPageState extends State<PlayListDetailPage>
    with SingleTickerProviderStateMixin {

  final playModel = PlayModel();
  Color _selectColor = hexToColor('#31c27c');
  Playlistdetail playlistdetail;
  ScrollController _controller = new ScrollController();
  bool showToTopBtn = false;
  Animation<Color> color;
  AnimationController controller;
  List<TrackItem> songList = [];

  @override
  void initState() {
    super.initState();
    //监听滚动事件，打印滚动位置
    _controller.addListener(() {
      if (_controller.offset >= 200 && showToTopBtn == false) {
        controller.forward();
      } else {
        controller.reverse();
      }
    });
    controller = new AnimationController(
        duration: const Duration(milliseconds: 500), vsync: this);
    //图片宽高从0变到300
    color = ColorTween(
      begin: Colors.transparent,
      end: Colors.white,
    ).animate(controller)
      ..addListener(() {
        setState(() => {});
      });
    getList();
  }

  @override
  void dispose() {
    //为了避免内存泄露，需要调用_controller.dispose
    _controller.dispose();
    controller.dispose();
    super.dispose();
    print('PlayListDetailPage dispose');
  }

  getList() async {
    try {
      var result = await HttpUtils.request("/playlist/detail?id=${widget.id}");
      Playlistdetail data = Playlistdetail.fromJson(json.decode(result));
      if (data.code == 200) {
        List responseJson = json.decode(result)['playlist']['tracks'];
        List<TrackItem> list = responseJson.map((m) => new TrackItem.fromJson(m)).toList();
        setState(() {
          playlistdetail = data;
          songList = list;
        });
      } else {
        Toast.toast(context, '没有数据');
      }
    } catch (e) {
      print(e);
    }
  }

  Widget build(BuildContext context) {
    // var id = ModalRoute.of(context).settings.arguments;
    //因为本路由没有使用Scaffold，为了让子级Widget(如Text)使用
    //Material Design 默认的样式风格,我们使用Material作为本路由的根。
    return Material(
      child: Container(
        padding: EdgeInsets.only(bottom: MediaQuery.of(context).padding.bottom),
        child: ConstrainedBox(
        constraints: BoxConstraints.expand(),
        // child: SafeArea(
        child: Stack(
          alignment: Alignment.center, //指定未定位或部分定位widget的对齐方式
          fit: StackFit.expand,
          children: <Widget>[
            Positioned(
              top: 0,
              left: 0,
              right: 0,
              height: 300,
              child: Container(
                decoration: BoxDecoration(
                  gradient: LinearGradient(colors:[Colors.teal,Colors.orange[700]]), //背景渐变
                ),
              ),
            ),
            Container(
              child: playlistdetail == null ? Text('') : _bodyBuild(),
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
            )
          ],
        ),
      )),
      // ),
    );
  }

  // 固定栏
  Widget _fixedBuild() {
    return Consumer<PlayModel>(
      builder: (BuildContext context, PlayModel playModel, child) {
        return GestureDetector(
          onTap: () {
            playModel.setSongList(songList);
            playModel.setSongListIndex(0);
          },
          child: child,
        );
      },
      child: Container(
        color: Colors.white,
        padding: EdgeInsets.only(left: 15, right: 15),
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
    ? SliverPadding(
        padding: const EdgeInsets.all(30.0),
        sliver: SliverToBoxAdapter(
          child: Center(child: CircularProgressIndicator(),),
        ),
      )
    : new SliverFixedExtentList(
      itemExtent: 50,
      delegate: new SliverChildBuilderDelegate(
        (BuildContext context, int index) {
        //创建列表项
        return Consumer<PlayModel>(
          builder: (BuildContext context, PlayModel playModel,  _) {
            num id = playModel.songList.length == 0 ? -1 : playModel.songList[playModel.songListIndex].id;
            return Center(
              child: Container(
                color: Colors.white,
                padding: EdgeInsets.only(right: 15, bottom: 10),
                child: GestureDetector(
                  onTap: () {
                    playModel.setSongList(songList);
                    playModel.setSongListIndex(index);
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
      childCount: songList.length
      ),
    );
  }

  Widget _bodyBuild() {
    return Container(
      padding: EdgeInsets.only(bottom: 40),
      child: Column(
        children: <Widget>[
          Expanded(
            child: CustomScrollView(
              controller: _controller,
              slivers: <Widget>[
                SliverAppBar(
                  //导航栏
                  leading: Builder(
                    builder: (BuildContext context) {
                      return IconButton(
                        icon: Image.asset(
                          color.value.computeLuminance() < 0.5
                          ? 'assets/images/back_normal_white.png'
                          : 'assets/images/profile_back_normal.png',
                          width: 20,
                        ),
                        onPressed: () {
                          Navigator.of(context).pop();
                        },
                      );
                    },
                  ),
                  title: Text(
                    "歌单",
                    style: TextStyle(
                        color: color.value.computeLuminance() < 0.5 ? Colors.white : Colors.black, fontWeight: FontWeight.normal),
                  ),
                  backgroundColor: color.value,
                  elevation: .0,
                  centerTitle: false,
                  pinned: true,
                ),
                _buildDetail(),
                SliverPersistentHeader(
                  pinned: true,
                  delegate: SliverAppBarDelegate(
                    minHeight: 50.0,
                    maxHeight: 50.0,
                    child: new Container(color: Colors.white10, child: _fixedBuild()),
                  )
                ),
                _listBuild(),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildDetail() {
    return SliverPadding(
      padding: const EdgeInsets.only(top: 20, right: 20, left: 20),
      sliver: SliverToBoxAdapter(
        child: Container(
          height: 170,
          child: Column(children: <Widget>[
            Row(
              children: <Widget>[
                ClipRRect(
                  borderRadius: BorderRadius.circular(5),
                  child: SizedBox(
                    width: 100,
                    height: 100,
                    child: FadeInImage.assetNetwork(
                      placeholder: "assets/images/player_album_cover_default.png",//预览图
                      fit: BoxFit.fitWidth,
                      image: playlistdetail == null
                      ? ''
                      : playlistdetail.playlist.coverImgUrl + '?param=200y200',
                    ),
                  ),
                ),
                Expanded(
                  child: Container(
                    padding: EdgeInsets.only(left: 20),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: <Widget>[
                        Text(
                          playlistdetail == null ? '' : playlistdetail.playlist.name,
                          maxLines: 2,
                          overflow: TextOverflow.ellipsis,
                          style: TextStyle(color: Colors.white, fontSize: 18, height: 1,),
                        ),
                        Container(
                          height: 40,
                          child: Row(
                            children: <Widget>[
                              ClipOval(
                                child: Image.network(playlistdetail.playlist.creator == null ? '' : playlistdetail.playlist.creator.avatarUrl + '?param=200y200', width: 30,),
                              ),
                              Padding(
                                padding: EdgeInsets.only(left: 10),
                                child: Text(
                                playlistdetail.playlist.creator == null ? '' : playlistdetail.playlist.creator.nickname,
                                maxLines: 1,
                                overflow: TextOverflow.ellipsis,
                                style: TextStyle(color: Colors.white, fontSize: 14,),
                              ),)
                            ],
                          ),
                        ),
                        Row(
                          children: <Widget>[
                            Expanded(child: Text(
                              playlistdetail.playlist.description == null ? '简介:' : '简介：${playlistdetail.playlist.description}',
                              maxLines: 1,
                              overflow: TextOverflow.ellipsis,
                              style: TextStyle(color: Colors.white, fontSize: 12,),
                            ),),
                            Image.asset('assets/images/live_gift_arrow_right.png', width: 12,)
                          ],
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
            Container(
              padding: EdgeInsets.only(top: 20),
              height: 60,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                Container(child: Row(children: <Widget>[
                  Image.asset('assets/images/album_folder_header_like.png', width: 30,),
                  Text('120', style: TextStyle(color: Colors.white),)
                ],),),
                Container(child: Row(children: <Widget>[
                  Image.asset('assets/images/album_folder_header_comment.png', width: 30,),
                  Text('120', style: TextStyle(color: Colors.white),)
                ],),),
                Container(child: Row(children: <Widget>[
                  Image.asset('assets/images/album_folder_header_share.png', width: 30,),
                  Text('分享', style: TextStyle(color: Colors.white),)
                ],),),
              ],),
            )
          ],),
        ),
      ),
    );
  }

}
