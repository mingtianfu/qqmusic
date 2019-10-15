import 'dart:convert';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_ijkplayer/flutter_ijkplayer.dart';
import 'package:qqmusic/component/Toast.dart';
import 'package:qqmusic/models/artist.dart';
import 'package:qqmusic/pages/PlaySongBarPage.dart';
import 'package:qqmusic/utils/HttpUtils.dart';

class SingersList extends StatefulWidget {
  SingersList({Key key, this.audioPlayer, this.handleTap}): super(key: key);
  final IjkMediaController audioPlayer;
  final handleTap;
  @override 
  _SingersListState createState() => _SingersListState();
}

class _SingersListState extends State<SingersList> {

  List<Artist> _list = [];
  int offset = 0;
  bool isMore = false;
  bool isLoading = false;//是否正在请求新数据
  bool showMore = false;//是否显示底部加载中提示
  bool offState = false;//是否显示进入页面时的圆形进度条
  ScrollController _scrollController = ScrollController(); //listview的控制器

  @override
  void initState() {
    super.initState();
    getdata();
    _scrollController.addListener(() {
      print(_scrollController.position);
      if (_scrollController.position.pixels ==
          _scrollController.position.maxScrollExtent) {
        print('滑动到了最底部');
        getMore();
      }
    });
  }

  @override
  void dispose() {
    //为了避免内存泄露，需要调用_controller.dispose
    _scrollController.dispose();
    super.dispose();
  }

  getdata([String tag]) async {
    try {
      var result = await HttpUtils.request("/top/artists?offset=$offset&limit=30");
      var data = json.decode(result);
        if (data['code'] == 200 && data['artists'].length > 0) {
          List responseJson = data['artists'];
          List<Artist> list = responseJson.map((m) => new Artist.fromJson(m)).toList();
          setState(() {
            _list = list;
            offset = 0;
            offState = true;
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
      int _offset = offset + 1;
      var result = await HttpUtils.request("/top/artists?offset=$_offset&limit=30");
      var data = json.decode(result);
        if (data['code'] == 200 && data['artists'].length > 0) {
          List responseJson = data['artists'];
          List<Artist> list = responseJson.map((m) => new Artist.fromJson(m)).toList();
          setState(() {
            _list.addAll(list);
            offset = _offset;
          });
        } else {
          Toast.toast(context, '没有数据');
        }
    } catch (e) {
      print(e);
    }
  }

  Future<Null> _onRefresh() async{
    getdata();
  }

  @override
  Widget build(BuildContext context) {
    //因为本路由没有使用Scaffold，为了让子级Widget(如Text)使用
    //Material Design 默认的样式风格,我们使用Material作为本路由的根。
    return Material(
      child: SafeArea(
        child: Stack(
          children: <Widget>[
            Container(
              child: _buildContext()
            ),
            Offstage(
              offstage: offState,
              child: Center(
                child: CircularProgressIndicator(),
              ),
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
    return RefreshIndicator(
      onRefresh: _onRefresh,
      child: CustomScrollView(
        controller: _scrollController,
        slivers: <Widget>[
          //AppBar，包含一个导航栏
          SliverAppBar(
            leading: Builder(
              builder: (BuildContext context) {
                return IconButton(
                  icon: Image.asset('assets/images/back_normal_black.png', width: 30,),
                  onPressed: () { Navigator.of(context).pop(); },
                );
              },
            ),
            title: Text("歌手", style: TextStyle(color: Colors.black, fontWeight: FontWeight.normal),), 
            backgroundColor: Colors.white,
            elevation: .0,
            centerTitle: false,
            pinned: true,
          ),
          //List
          new SliverFixedExtentList(
            itemExtent: 80.0,
            delegate: new SliverChildBuilderDelegate(
              (BuildContext context, int index) {
                //创建列表项      
                return ListTile(
                  onTap: () {
                    Navigator.of(context).pushNamed('singerDetailPage', arguments: _list[index].id);
                  },
                  title: _buildItem(index)
                );
              },
              childCount:  _list.length,
            ),
          ),
        ],
      ),
    );
  }


  // /**
  //  * 加载哪个子组件
  //  */
  // Widget choiceItemWidget(BuildContext context, int position) {
  //   if (position < list.length) {
  //     return HomeListItem(position, list[position], (position) {
  //       debugPrint("点击了第$position条");
  //     });
  //   } else if (showMore) {
  //     return showMoreLoadingWidget();
  //   }else{
  //     return null;
  //   }
  // }

  /**
   * 加载更多提示组件
   */
  Widget showMoreLoadingWidget() {
    return Container(
      height: 50.0,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: <Widget>[
          Text('加载中...', style: TextStyle(fontSize: 16.0),),
        ],
      ),
    );
  }

  Widget _buildItem(index) {
    return Container(
      margin: EdgeInsets.only(top: 20),
      child: Row(
        children: <Widget>[
          ClipOval(
            child: new CachedNetworkImage(
              placeholder: (context, url) => Image.asset('assets/images/player_album_cover_default.png'),
              imageUrl: _list[index].picUrl + '?param=200y200',
              width: 60,
              height: 60,
              fit: BoxFit.cover,
            )
          ),
          Expanded(
            child: Container(
              padding: EdgeInsets.only(left: 10),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  Text('${_list[index].name}', style: TextStyle(fontSize: 16),),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

}