import 'dart:convert';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:qqmusic/component/AppBarSearch.dart';
import 'package:qqmusic/component/Toast.dart';
import 'package:qqmusic/models/index.dart';
import 'package:qqmusic/utils/HttpUtils.dart';
import 'package:flutter_swiper/flutter_swiper.dart';

class MusichallPage extends StatefulWidget {
  // MusichallPage({Key key, this.audioPlayer}): super(key: key);
  // final IjkMediaController audioPlayer;
  @override 
  _MusichallPageState createState() => _MusichallPageState();
}

class _MusichallPageState extends State<MusichallPage> with AutomaticKeepAliveClientMixin{
  
  List<Personalizeditem> personalizedList = [];
  List<BannerItem> bannerList = [];
  List<AlbumItem> albumList = [];


  void handlePresseSearch() {
    print('搜索页面');
  }

  void handleRecognize() {
    Navigator.of(context).pushNamed('listenPage');
  }

  @override
  bool get wantKeepAlive => true;

  @override 
  void initState() {
    super.initState();
    getBanner();
    getPersonalized();
    getTopAlbum();
  }

  getBanner() async {
    try {
      var result = await HttpUtils.request("/banner");
      if (result == 'none') {
        Toast.toast(context, '没有打开网络');
      } else if(result == null) {
        Toast.toast(context, '请求数据失败，请稍后重试');
      } else {
        Banners banners = Banners.fromJson(json.decode(result));
        
        if (banners.code == 200 && banners.banners.length > 0) {
          setState(() {
            bannerList = banners.banners;
          });
        } else {
          Toast.toast(context, '没有数据');
        }
      }
    } catch (e) {
      print('e:$e');
    }
  }

  getPersonalized() async {
    try {
      var result = await HttpUtils.request("/personalized?offset=0&limit=30");
      // print(result);
        Personalized personalized = Personalized.fromJson(json.decode(result));
        if (personalized.code == 200 && personalized.result.length > 0) {
          setState(() {
            personalizedList = personalized.result;
          });
        } else {
          Toast.toast(context, '没有数据');
        }
    } catch (e) {
      print(e);
    }
  }

  getTopAlbum() async {
    try {
      var result = await HttpUtils.request("/top/album?offset=0&limit=30");
      // print(result);
        Albums albums = Albums.fromJson(json.decode(result));
        if (albums.code == 200 && albums.albums.length > 0) {
          setState(() {
            albumList = albums.albums;
          });
        } else {
          Toast.toast(context, '没有数据');
        }
    } catch (e) {
      print(e);
    }
  }

  @override
  Widget build(BuildContext context) {
    super.build(context);
    return SafeArea(
      child: Center(
        child: Padding(
          padding: const EdgeInsets.only(bottom: 30.0),
          child: ListView(
          children: <Widget>[
            Column(
              children: <Widget>[
                AppBarSearch(
                  title: '音乐馆', 
                  rightImage: Image.asset('assets/images/icon_menu_recognize_lyric.png', width: 30,),
                  onPressedRight: handleRecognize,
                  onPressed: handlePresseSearch,
                ),
                bannerList.length == 0 ? Text('') : _swiper(),
                _gridview(),
                _buildPersonalized(),
                _buildTopAlbum(),
                _buildTopAlbum(),
              ],
            )
          ],
      ),
        ),
      )
    );
  }

  Widget _swiper () {
    return Container(
      height: 150.0,
      margin: EdgeInsets.only(left: 15.0, right: 15.0,),
      child: ClipRRect(
        borderRadius: BorderRadius.circular(5.0),
        child: Swiper(
          itemBuilder: _swiperBuilder,
          itemCount: bannerList.length,
          pagination: SwiperPagination(
            builder: DotSwiperPaginationBuilder(
              color: Colors.black45,
              activeColor: Colors.white,
            )
          ),
          scrollDirection: Axis.horizontal,
          autoplay: true,
          onTap: (index) => print('点击了第$index${bannerList[index].imageUrl}个'),
        ),
      )
    );
  }

  Widget _swiperBuilder(BuildContext context, int index) {
    return (Image.network(
      bannerList[index].imageUrl,
      fit: BoxFit.fill,
    ));
  }

  Widget _gridview () {
    return Container(
      padding: EdgeInsets.only(top: 10.0, right: 15.0, bottom: 10.0),
      child: Flex(
        direction: Axis.horizontal,
        children: <Widget>[
          _buildGridviewExpanded('assets/images/my_music_color_skin_selected.png', 30, '歌手', 'singersList'),
          _buildGridviewExpanded('assets/images/my_music_color_skin_selected.png', 30, '排行', 'topListPage'),
          _buildGridviewExpanded('assets/images/my_music_color_skin_selected.png', 30, '分类歌单', 'playListTapPage'),
          _buildGridviewExpanded('assets/images/miniplayer_btn_radiolist_highlight.png', 30, '电台', ''),
          _buildGridviewExpanded('assets/images/radio_live_entry_left_icon.png', 30, '一起听', ''),
        ],
      ),
    );
  }
  
  Expanded _buildGridviewExpanded (String icon, double size, String label, String routeName) {
    return Expanded(
      flex: 1,
      child: GestureDetector(
        onTap: () => Navigator.of(context).pushNamed(routeName),
        // onTap: () {
        //   Navigator.push( context,
        //    MaterialPageRoute(builder: (context) {
        //       return PlayListTapPage();
        //    }));
        // },
        child: Column(
          children: <Widget>[
            Image.asset(icon, width: size,),
            Container(
              padding: EdgeInsets.only(top: 5.0),
              child: Text(label),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildPersonalized () {
    return Container(
      padding: EdgeInsets.only(top: 10, bottom: 10, left: 15.0),
      child: Column(
        children: <Widget>[
          // title
          GestureDetector(
            child: Row(
              children: <Widget>[
                Expanded(
                  child: Text(
                    '推荐歌单',
                    style: TextStyle(fontSize: 16)
                  ),
                ),
                Text(
                  '更多'
                ),
                Icon(
                  Icons.keyboard_arrow_right,
                ),
              ],
            ),
            onTap: () => Navigator.of(context).pushNamed('playListTapPage'),
          ),
          // context
          Scrollbar(
            child: SingleChildScrollView(
              scrollDirection: Axis.horizontal,
              padding: EdgeInsets.only(top: 15.0),
              child: Container(
                height: 160,
                child: Row(
                  mainAxisSize: MainAxisSize.min,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: personalizedList.map((item) => _buildContainer(item.picUrl, item.name, item.id)).toList(),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildTopAlbum() {
    return Container(
      padding: EdgeInsets.only(top: 10, bottom: 10, left: 15.0),
      child: Column(
        children: <Widget>[
          // title
          GestureDetector(
            child: Row(
              children: <Widget>[
                Expanded(
                  child: Text(
                    '新碟上架',
                    style: TextStyle(fontSize: 16)
                  ),
                ),
                Text(
                  '更多'
                ),
                Icon(
                  Icons.keyboard_arrow_right,
                ),
              ],
            ),
            onTap: () => Navigator.of(context).pushNamed('playListTapPage'),
          ),
          // context
          Scrollbar(
            child: SingleChildScrollView(
              scrollDirection: Axis.horizontal,
              padding: EdgeInsets.only(top: 15.0),
              child: Container(
                height: 160,
                child: Row(
                  mainAxisSize: MainAxisSize.min,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: albumList.map((item) => _buildContainer(item.picUrl, item.name, item.id)).toList(),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
  
  Container _buildContainer (String imgUrl, String label, int id, [String counter]) {
    return Container(
      margin: EdgeInsets.only(right: 8),
      width: 100,
      height: 160,
      child: GestureDetector(
        onTap: () {
          Navigator.of(context).pushNamed('playListDetailPage', arguments: id);
        },
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            ClipRRect(
              borderRadius: BorderRadius.circular(5),
              child: Container(
                width: 100,
                height: 100,
                child: new CachedNetworkImage(
                  placeholder: (context, url) => Image.asset('assets/images/player_album_cover_default.png'),
                  imageUrl: imgUrl + '?param=200y200',
                ),
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
      )
    );
  }

}