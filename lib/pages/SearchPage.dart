
import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_ijkplayer/flutter_ijkplayer.dart';
import 'package:qqmusic/component/Toast.dart';
import 'package:qqmusic/models/index.dart';
import 'package:qqmusic/utils/HttpUtils.dart';
import 'package:shared_preferences/shared_preferences.dart';


class SearchPage extends StatefulWidget{
  SearchPage({Key key, this.audioPlayer, this.handleTap}): super(key: key);
  final IjkMediaController audioPlayer;
  final handleTap;
  @override 
  _SearchPageState createState() => _SearchPageState();
}

class _SearchPageState extends State<SearchPage> {
  List<String> _searchs = [];
  List<SearchSuggest> _searchSuggest = [];

  @override
  void initState(){
    super.initState();
    _getSearch();
  }

  _getSearch() async{
    SharedPreferences prefs = await SharedPreferences.getInstance();
    setState(() {
      _searchs = prefs.getStringList('searchs')??[];
    });
  }

  _saveKeyword(String keyword) async{
    setState(() {
      _searchs.add(keyword);
    });
    SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.setStringList('searchs', _searchs);
  }

  _clearKeyword() async{
    SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.remove('searchs');
    setState(() {
      _searchs = [];
    });
  }

// 弹出对话框
Future<bool> showDeleteConfirmDialog() {
  return showDialog<bool>(
    context: context,
    builder: (context) {
      return AlertDialog(
        content: Text("是否清空所有搜索历史"),
        actions: <Widget>[
          FlatButton(
            child: Text("取消"),
            onPressed: () => Navigator.of(context).pop(), //关闭对话框
          ),
          FlatButton(
            child: Text("清空"),
            onPressed: () {
              _clearKeyword();
              Navigator.of(context).pop(); //关闭对话框
            },
          ),
        ],
      );
    },
  );
}

  _requestSuggest(String keyword) async{
    if (keyword.trim().length > 0) {
      try {
        var result = await HttpUtils.request("/search/suggest?keywords=$keyword&type=mobile");
        var data = json.decode(result);
        if (data['code'] == 200 && data['result'] != null && data['result']['allMatch'] != null) {
          List responseJson = data['result']['allMatch'];
          List<SearchSuggest> list = responseJson.map((m) => new SearchSuggest.fromJson(m)).toList();
          setState(() {
            _searchSuggest = list;
          });
          _saveKeyword(keyword);
        } else {
          setState(() {
            _searchSuggest = [];
          });
          Toast.toast(context, '没有数据');
        }
      } catch (e) {
        print(e);
      }
    } else {
      setState(() {
        _searchSuggest = [];
      });
    }
  }

  _requestSearch(String keyword) {
    Toast.toast(context, '搜索$keyword');
  }

  @override 
  Widget build(BuildContext context){
    return Scaffold(
      body: Container(
        padding: EdgeInsets.symmetric(horizontal: 10),
        child: SafeArea(
          child: Scrollbar(
            child: SingleChildScrollView (
              child: Column(
                children: <Widget>[
                  _buildTextField(),
                  _searchSuggest.length == 0 
                  ? _searchs.length > 0 ? _buildHistory() : Container()
                  : _buildSuggest(),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildTextField() {
    return Row(
      children: <Widget>[
        GestureDetector(
          onTap: () => Navigator.of(context).pop(),
          child: Image.asset('assets/images/back_normal_black.png', width: 30,),
        ),
        Expanded(
          child: Container(
            margin: EdgeInsets.symmetric(vertical: 0.0, horizontal: 15),
            height: 30,
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(15.0)
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: <Widget>[
                Image.asset('assets/images/label_search_icon.png', width: 24,),
                Expanded(
                  child: Container(
                    child: TextField(
                      onChanged: (text) => Future.delayed(Duration(milliseconds: 500), () => _requestSuggest(text)),
                      textAlignVertical: TextAlignVertical.center,
                      maxLines: 1,
                      autofocus: true,
                      decoration: InputDecoration(
                        contentPadding: EdgeInsets.only(top: 0, left: 5),
                        border: InputBorder.none,
                        hintText: "搜索音乐、视频、专辑、歌单、歌手、用户、歌词",
                        hintStyle: TextStyle(
                          fontSize: 14
                        ),
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildHistory() {
    return Column(
      children: <Widget>[
        Container(
          padding: EdgeInsets.only(top: 10),
          child: Column(
            children: <Widget>[
              Container(
                child: Row(
                  children: <Widget>[
                    Expanded(
                      child: Text('搜索历史', style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),),
                    ),
                    GestureDetector(
                      onTap: () => showDeleteConfirmDialog(),
                      child: Image.asset('assets/images/playlist_icon_garbage.png', width: 40,),
                    )
                  ],
                ),
              ),
              Wrap(
                direction: Axis.horizontal,
                // 对齐方式
                alignment: WrapAlignment.start,
                // 主轴空隙间距
                spacing: 5,
                // run的对齐方式
                runAlignment: WrapAlignment.start,
                // run空隙间距
                runSpacing: 10,
                // 交叉轴对齐方式
                crossAxisAlignment: WrapCrossAlignment.center, 
                // 文本对齐方向
                textDirection: TextDirection.ltr,
                // 确定垂直放置子元素的顺序，以及如何在垂直方向上解释开始和结束。 默认down
                verticalDirection: VerticalDirection.down,
                children: _searchs.map((f) => GestureDetector(
                  onTap: () => _requestSearch(f),
                  child: Container(
                    padding: EdgeInsets.symmetric(horizontal: 10, vertical: 5),
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(15.0)
                    ),
                    child: Text(
                      '$f',
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                    ),
                  ),
                )).toList()
                // ..add(
                //   GestureDetector(
                //     // onTap: () => _requestSearch(f),
                //     child: Container(
                //       width: 35,
                //       height: 27,
                //       // padding: EdgeInsets.symmetric(horizontal: 10, vertical: 15),
                //       decoration: BoxDecoration(
                //         color: Colors.white,
                //         borderRadius: BorderRadius.circular(15.0),
                //         image: DecorationImage(
                //           image: AssetImage("assets/images/icon_song_action_sheet_normal.png"),
                //           fit: BoxFit.cover,
                //         )
                //       ),
                //       // child: Image.asset('assets/images/icon_song_action_sheet_normal.png', width: 20,),
                //     ),
                //   )
                // ),
              ),
            ],
          ),
        ),
      ],
    );
  }

  Widget _buildSuggest() {
    return Column( 
      children: _searchSuggest
        .map((f) => Container(
          padding: EdgeInsets.only(top: 10),
          child: GestureDetector(
            onTap: () => _requestSearch(f.keyword),
            child: Row(
              children: <Widget>[
                Image.asset('assets/images/label_search_icon.png', width: 24,),
                Container(width: 10,),
                Text(f.keyword),
              ]
            ),
          ),
        ))
        .toList(),
    );
  }

}
class MyFlowDelegate extends FlowDelegate {
  EdgeInsets margin = EdgeInsets.zero;
  MyFlowDelegate({this.margin});

  @override
  void paintChildren(FlowPaintingContext context) {
    var x = margin.left;
    var y = margin.top;
    //计算每一个子widget的位置  
    for (int i = 0; i < context.childCount; i++) {
      var w = context.getChildSize(i).width + x + margin.right;
      if (w < context.size.width) {
        context.paintChild(i,
            transform: new Matrix4.translationValues(
                x, y, 0.0));
        x = w + margin.left;
      } else {
        x = margin.left;
        y += context.getChildSize(i).height + margin.top + margin.bottom;
        //绘制子widget(有优化)  
        context.paintChild(i,
            transform: new Matrix4.translationValues(
                x, y, 0.0));
         x += context.getChildSize(i).width + margin.left + margin.right;
      }
    }
  }

  @override
  getSize(BoxConstraints constraints){
    print(constraints.maxHeight);
    //指定Flow的大小  
    return Size(double.infinity,200.0);
  }

  @override
  bool shouldRepaint(FlowDelegate oldDelegate) {
    return oldDelegate != this;
  }
}