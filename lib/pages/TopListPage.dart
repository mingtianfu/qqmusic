import 'dart:convert';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:qqmusic/component/Toast.dart';
import 'package:qqmusic/models/toplistdetail.dart';
import 'package:qqmusic/utils/HttpUtils.dart';

class TopListPage extends StatefulWidget {
  @override
  _TopListPageState createState() => new _TopListPageState();
}

class _TopListPageState extends State<TopListPage> {
  List<Toplistdetail> _list = [];

  @override
  void initState() {
    super.initState();
    getdata();
  }

  getdata([String tag]) async {
    try {
      var result = await HttpUtils.request("/toplist/detail");
      var data = json.decode(result);
        if (data['code'] == 200 && data['list'].length > 0) {
          List responseJson = data['list'];
          List<Toplistdetail> list = responseJson.map((m) => new Toplistdetail.fromJson(m)).toList();
          setState(() {
            _list = list;
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
    //因为本路由没有使用Scaffold，为了让子级Widget(如Text)使用
    //Material Design 默认的样式风格,我们使用Material作为本路由的根。
    return Material(
      child: SafeArea(
        child: CustomScrollView(
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
            title: Text("排行榜", style: TextStyle(color: Colors.black, fontWeight: FontWeight.normal),), 
            backgroundColor: Colors.white,
            elevation: .0,
            centerTitle: false,
            pinned: true,
          ),
          //List
          new SliverFixedExtentList(
            itemExtent: 120.0,
            delegate: new SliverChildBuilderDelegate(
              (BuildContext context, int index) {
                //创建列表项      
                return ListTile(
                  onTap: () {
                    Navigator.of(context).pushNamed('playListDetailPage', arguments: _list[index].id);
                  },
                  title: _buildItem(index)
                );
              },
              childCount:  _list.length > 0 ? 4 : 0,
            ),
          ),

          SliverPadding(
            padding: const EdgeInsets.symmetric(vertical: 30, horizontal: 15),
            sliver: new SliverGrid( //Grid
              gridDelegate: new SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 3,
                mainAxisSpacing: 10.0,
                crossAxisSpacing: 10.0,
                childAspectRatio: 1.0,
              ),
              delegate: new SliverChildBuilderDelegate(
                (BuildContext context, int index) {
                  //创建子widget      
                  return _buildGridItme(index+4);
                },
                childCount: _list.length > 0 ? _list.length - 4 : 0,
              ),
            ),
          ),
          
        ],
      ),
      ),
    );
  }

  Widget _buildItem(index) {
    return Container(
      decoration: BoxDecoration(
        color: Colors.grey[200],
        borderRadius: BorderRadius.circular(10.0),
      ),
      margin: EdgeInsets.only(top: 20),
      child: Row(
        children: <Widget>[
          Expanded(
            child: Container(
              padding: EdgeInsets.only(left: 10, top: 5, bottom: 5),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  Text('${_list[index].name}',
                    style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                  ),
                  Expanded(
                    child: _list[index].tracks.length == 0 ? Text('') 
                    : Row(
                      children: <Widget>[
                        Text(
                          "1. ${_list[index].tracks[0].first}",
                          style: TextStyle(
                            color: Colors.black87,
                            fontSize: 14,
                          ),
                        ),
                        Expanded(
                          child: Text(
                            " - ${_list[index].tracks[0].second}",
                            maxLines: 1,
                            overflow: TextOverflow.ellipsis,
                            style: TextStyle(
                              color: Colors.black54,
                              fontSize: 14,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                  _list[index].tracks.length == 0 ? Text('') 
                  :Expanded(
                    child: Row(
                      children: <Widget>[
                        Text(
                          "2. ${_list[index].tracks[1].first}",
                          style: TextStyle(
                            color: Colors.black87,
                            fontSize: 14,
                          ),
                        ),
                        Expanded(
                          child: Text(
                            " - ${_list[index].tracks[1].second}",
                            maxLines: 1,
                            overflow: TextOverflow.ellipsis,
                            style: TextStyle(
                              color: Colors.black54,
                              fontSize: 14,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                  _list[index].tracks.length == 0 ? Text('') 
                  :Expanded(
                    child: Row(
                      children: <Widget>[
                        Text(
                          "3. ${_list[index].tracks[2].first}",
                          style: TextStyle(
                            color: Colors.black87,
                            fontSize: 14,
                          ),
                        ),
                        Expanded(
                          child: Text(
                            " - ${_list[index].tracks[2].second}",
                            maxLines: 1,
                            overflow: TextOverflow.ellipsis,
                            style: TextStyle(
                              color: Colors.black54,
                              fontSize: 14,
                            ),
                          ),
                        ),
                      ],
                    ),
                  )
                ],
              ),
            ),
          ),
          SizedBox(
            width: 100,
            child: ClipRRect(
              borderRadius: BorderRadius.only(topRight: Radius.circular(10), bottomRight: Radius.circular(10)),
              child: new CachedNetworkImage(
                placeholder: (context, url) => Image.asset('assets/images/player_album_cover_default.png'),
                imageUrl: _list[index].coverImgUrl + '?param=200y200',
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildGridItme(index) {
    return GestureDetector(
      onTap: () {
        Navigator.of(context).pushNamed('playListDetailPage', arguments: _list[index].id);
      },
      child: Container(
        decoration: BoxDecoration(
          color: Colors.grey[200],
          borderRadius: BorderRadius.circular(10.0),
          image: DecorationImage(
            image: NetworkImage(_list[index].coverImgUrl + '?param=200y200')
          ),
        ),
        child: Container(
          padding: EdgeInsets.only(left: 10,right: 10),
          decoration: BoxDecoration(
            color: Colors.black87,
            borderRadius: BorderRadius.circular(10.0),
          ),
          child: Center(
            child: Text(
              '${_list[index].name}', 
              textAlign: TextAlign.center,
              style: TextStyle(fontSize: 14, color: Colors.white,),),
          ),
        ),
      ),
    );
  }

}