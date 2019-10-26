import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_ijkplayer/flutter_ijkplayer.dart';
import 'package:http/http.dart';
import 'package:provider/provider.dart';
import 'package:qqmusic/component/SliverAppBarDelegate.dart';
import 'package:qqmusic/component/Toast.dart';
import 'package:qqmusic/models/index.dart';
import 'package:qqmusic/pages/Model/PlayModel.dart';
import 'package:qqmusic/utils/HttpUtils.dart';
import 'package:qqmusic/utils/hexToColor.dart';
import 'package:shared_preferences/shared_preferences.dart';

class SearchPage extends StatefulWidget {
  SearchPage({Key key, this.audioPlayer, this.handleTap}) : super(key: key);
  final IjkMediaController audioPlayer;
  final handleTap;
  @override
  _SearchPageState createState() => _SearchPageState();
}

class _SearchPageState extends State<SearchPage> {
  FocusNode blankNode = FocusNode();
  List<String> _searchs = [];
  List<SearchSuggest> _searchSuggest = [];
  TextEditingController _textEditingController = TextEditingController();
  List<String> onChangeKeywords = [];
  String lastKeyword;
  // type: 搜索类型；默认为 1 即单曲 , 取值意义 : 1: 单曲, 10: 专辑, 100: 歌手,
  // 1000: 歌单, 1002: 用户, 1004: MV, 1006: 歌词, 1009: 电台, 1014: 视频, 1018:综合
  int type = 1;
  List<TrackItem> songList = [];

  @override
  void initState() {
    super.initState();
    _getSearch();
  }

  _getSearch() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    setState(() {
      _searchs = prefs.getStringList('searchs') ?? [];
    });
  }

  _saveKeyword(String keyword) async {
    if (_searchs.indexOf(keyword) == -1) {
      setState(() {
        _searchs.add(keyword);
      });
      SharedPreferences prefs = await SharedPreferences.getInstance();
      prefs.setStringList('searchs', _searchs);
    }
  }

  _clearKeyword() async {
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

  _requestSuggest(String keyword) async {
    if (keyword.length > 0) {
      try {
        var result = await HttpUtils.request(
            "/search/suggest?keywords=$keyword&type=mobile");
        var data = json.decode(result);
        if (data['code'] == 200 &&
            data['result'] != null &&
            data['result']['allMatch'] != null) {
          List responseJson = data['result']['allMatch'];
          List<SearchSuggest> list =
              responseJson.map((m) => new SearchSuggest.fromJson(m)).toList();
          setState(() {
            _searchSuggest = list;
          });
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

  _requestSearch(String text) async {
    FocusScope.of(context).requestFocus(blankNode);
    _textEditingController.text = text;
    _saveKeyword(text);
    try {
      var result =
          await HttpUtils.request("/search?keywords=$text&type=$type&limit=30");
      var data = json.decode(result);

      if (data['code'] == 200 &&
          data['result'] != null &&
          data['result']['songs'] != null) {
        List responseJson = data['result']['songs'];
        List<TrackItem> list = responseJson.map((m) {
          m['al'] = m['album'];
          m['ar'] = m['artists'];
          return TrackItem.fromJson(m);
        }).toList();
        setState(() {
          songList = list;
        });
      } else {
        setState(() {
          songList = [];
        });
        Toast.toast(context, '没有数据');
      }
    } catch (e) {
      print(e);
    }
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          flexibleSpace: _buildTextField(),
          leading: Container(
            width: 0,
          ),
          backgroundColor: Colors.transparent,
          elevation: 0,
        ),
        body: Container(
          height: MediaQuery.of(context).size.height,
          padding: EdgeInsets.symmetric(horizontal: 10),
          child: GestureDetector(
            onTap: () {
              FocusScope.of(context).requestFocus(blankNode);
            },
            child: Scrollbar(
              child: songList.length == 0
                  ? SingleChildScrollView(
                      child: Column(
                        children: <Widget>[
                          _searchSuggest.length == 0
                              ? _searchs.length > 0
                                  ? _buildHistory()
                                  : Container()
                              : _buildSuggest(),
                        ],
                      ),
                    )
                  : CustomScrollView(
                      slivers: <Widget>[_fixedBuild(), _listBuild()],
                    ),
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildTextField() {
    return Padding(
      padding: const EdgeInsets.only(top: 15.0, left: 10),
      child: Row(
        children: <Widget>[
          GestureDetector(
            onTap: () => Navigator.of(context).pop(),
            child: Image.asset(
              'assets/images/back_normal_black.png',
              width: 30,
            ),
          ),
          Expanded(
            child: Container(
              margin: EdgeInsets.symmetric(vertical: 0.0, horizontal: 15),
              height: 40,
              decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(20.0)),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: <Widget>[
                  Image.asset(
                    'assets/images/label_search_icon.png',
                    width: 24,
                  ),
                  Expanded(
                    child: Container(
                      child: TextField(
                        controller: _textEditingController,
                        onChanged: (text) async {
                          if (text.trim() == '') {
                            songList = [];
                            _searchSuggest = [];
                          }
                          setState(() {
                            onChangeKeywords.add(text);
                          });
                          await Future.delayed(Duration(milliseconds: 1000));
                          String last =
                              onChangeKeywords[onChangeKeywords.length - 1];

                          if (last != '' && lastKeyword != last) {
                            setState(() {
                              lastKeyword = last;
                            });
                            _requestSuggest(last);
                          }
                        },
                        textAlignVertical: TextAlignVertical.center,
                        maxLines: 1,
                        autofocus: true,
                        decoration: InputDecoration(
                          contentPadding: EdgeInsets.only(top: 0, left: 5),
                          border: InputBorder.none,
                          hintText: "搜索音乐、视频、专辑、歌单、歌手、用户、歌词",
                          hintStyle: TextStyle(fontSize: 14),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
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
                    SizedBox(
                      width: 10,
                    ),
                    Expanded(
                      child: Text(
                        '搜索历史',
                        style: TextStyle(
                            fontSize: 16, fontWeight: FontWeight.bold),
                      ),
                    ),
                    GestureDetector(
                      onTap: () => showDeleteConfirmDialog(),
                      child: Image.asset(
                        'assets/images/playlist_icon_garbage.png',
                        width: 40,
                      ),
                    )
                  ],
                ),
              ),
              Wrap(
                  // direction: Axis.horizontal,
                  // 对齐方式
                  // alignment: WrapAlignment.center,
                  // 主轴空隙间���
                  spacing: 5,
                  // run的对齐方式
                  // runAlignment: WrapAlignment.start,
                  // run空隙间距
                  runSpacing: 10,
                  // 交叉轴��齐方式
                  crossAxisAlignment: WrapCrossAlignment.center,
                  // 文本对齐方向
                  // textDirection: TextDirection.ltr,
                  // 确定垂直放置子元素的顺序，以及如何在垂直方向上解释开始和结束�� 默认down
                  verticalDirection: VerticalDirection.down,
                  children: _searchs
                      .map((f) => GestureDetector(
                            onTap: () => _requestSearch(f),
                            child: Container(
                              padding: EdgeInsets.symmetric(
                                  horizontal: 10, vertical: 5),
                              decoration: BoxDecoration(
                                  color: Colors.white,
                                  borderRadius: BorderRadius.circular(15.0)),
                              child: Text(
                                '$f',
                                maxLines: 1,
                                overflow: TextOverflow.ellipsis,
                              ),
                            ),
                          ))
                      .toList()
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
                  child: Row(children: <Widget>[
                    Image.asset(
                      'assets/images/label_search_icon.png',
                      width: 24,
                    ),
                    Container(
                      width: 10,
                    ),
                    Text(f.keyword),
                  ]),
                ),
              ))
          .toList(),
    );
  }

  // 固定栏
  Widget _fixedBuild() {
    return SliverPersistentHeader(
        pinned: true,
        delegate: SliverAppBarDelegate(
          minHeight: 50.0,
          maxHeight: 50.0,
          child: new Container(
              color: Colors.white10,
              child: Consumer<PlayModel>(
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
              )),
        ));
  }

  Widget _listBuild() {
    return songList.length == 0
        ? SliverPadding(
            padding: const EdgeInsets.all(30.0),
            sliver: SliverToBoxAdapter(
              child: Center(
                child: CircularProgressIndicator(),
              ),
            ),
          )
        : new SliverFixedExtentList(
            itemExtent: 50,
            delegate: new SliverChildBuilderDelegate(
                (BuildContext context, int index) {
              //创建列表项
              return Consumer<PlayModel>(
                builder: (BuildContext context, PlayModel playModel, _) {
                  num id = playModel.songList.length == 0
                      ? -1
                      : playModel.songList[playModel.songListIndex].id;
                  return Center(
                    child: Container(
                      color: Colors.white,
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
                                  ? primaryColor
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
                                            ? primaryColor
                                            : Colors.grey)),
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
                                            ? primaryColor
                                            : Colors.black),
                                  ),
                                  new Text(
                                    '${songList[index].ar[0].name} - ${songList[index].al.name}',
                                    maxLines: 1,
                                    overflow: TextOverflow.ellipsis,
                                    style: TextStyle(
                                        fontSize: 12,
                                        color: id == songList[index].id
                                            ? primaryColor
                                            : Colors.grey),
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
            }, childCount: songList.length),
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
            transform: new Matrix4.translationValues(x, y, 0.0));
        x = w + margin.left;
      } else {
        x = margin.left;
        y += context.getChildSize(i).height + margin.top + margin.bottom;
        //绘制子widget(有优化)
        context.paintChild(i,
            transform: new Matrix4.translationValues(x, y, 0.0));
        x += context.getChildSize(i).width + margin.left + margin.right;
      }
    }
  }

  @override
  getSize(BoxConstraints constraints) {
    print(constraints.maxHeight);
    //指定Flow的大小
    return Size(double.infinity, 200.0);
  }

  @override
  bool shouldRepaint(FlowDelegate oldDelegate) {
    return oldDelegate != this;
  }
}
