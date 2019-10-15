import 'package:flutter/material.dart';

class DataAppPage extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return new _DataAppPageState();
  }
}

class _DataAppPageState extends State<DataAppPage> {
ScrollController _controller;
int _count = 10;
bool _isLoding = false;
bool _isRefreshing = false;
String loadingText = "加载中.....";

@override
void initState() {
super.initState();
_controller = ScrollController();
}

@override
void dispose() {
super.dispose();
_controller.dispose();
}

@override
Widget build(BuildContext context) {
return new MaterialApp(
  home: Scaffold(
    body: new Container(
      child: new NotificationListener(
        onNotification: (notification) {
          if (notification is ScrollUpdateNotification &&
              notification.depth == 0 &&
              !_isLoding &&
              !_isRefreshing) {
            if (notification.metrics.pixels ==
                notification.metrics.maxScrollExtent) {
              setState(() {
                _isLoding = true;
                loadingText = "加载中.....";
                _count += 10;
              });
              _refreshPull().then((value) {
                print('加载成功.............');
                setState(() {
                  _isLoding = false;
                });
              }).catchError((error) {
                print('failed');
                setState(() {
                  _isLoding = true;
                  loadingText = "加载失败.....";
                });
              });
            }
          }
        },
        child: RefreshIndicator(
          child: CustomScrollView(
            controller: _controller,
            physics: ScrollPhysics(),
            slivers: <Widget>[
              const SliverAppBar(
                pinned: true,
                title: const Text('复杂布局'),
                   expandedHeight: 150.0,
                   flexibleSpace: FlexibleSpaceBar(
                     collapseMode: CollapseMode.parallax,
                     title: Text(
                       '复杂布局',
                       style: TextStyle(fontSize: 16),
                     ),
                   ),
                elevation: 10,
                leading: Icon(Icons.arrow_back),
              ),
              // SliverToBoxAdapter(
              //   child: Container(
              //     height: 200,
              //     child: new Swiper(
              //       itemBuilder: (BuildContext context, int index) {
              //         return new Image.network(
              //           "http://pic37.nipic.com/20140113/8800276_184927469000_2.png",
              //           fit: BoxFit.fill,
              //         );
              //       },
              //       itemCount: 3,
              //       pagination: new SwiperPagination(),
              //     ),
              //   ),
              // ),
              new SliverToBoxAdapter(
                child: new Container(
                  padding: EdgeInsets.only(top: 10, bottom: 10),
                  child: new Column(
                    children: <Widget>[
                      new SizedBox(
                          child: new Text(
                        'SliverGrid',
                        style: new TextStyle(fontSize: 16),
                      )),
                      new Divider(
                        color: Colors.grey,
                        height: 20,
                      )
                    ],
                  ),
                ),
              ),
              SliverGrid(
                gridDelegate: SliverGridDelegateWithMaxCrossAxisExtent(
                  maxCrossAxisExtent: 200.0,
                  mainAxisSpacing: 10.0,
                  crossAxisSpacing: 10.0,
                  childAspectRatio: 4.0,
                ),
                delegate: SliverChildBuilderDelegate(
                  (BuildContext context, int index) {
                    return Container(
                      alignment: Alignment.center,
                      color: Colors.teal[100 * (index % 9)],
                      child: Text('SliverGrid item $index'),
                    );
                  },
                  childCount: _count,
                ),
              ),
              new SliverToBoxAdapter(
                  child: new Container(
                padding: EdgeInsets.only(top: 10, bottom: 10),
                color: Colors.green,
                child: new SizedBox(
                    child: new Text(
                  'SliverFixedExtentList',
                  style: new TextStyle(fontSize: 16),
                )),
              )),
              SliverFixedExtentList(
                itemExtent: 50.0,
                delegate: SliverChildBuilderDelegate(
                  (BuildContext context, int index) {
                    return Container(
                      alignment: Alignment.center,
                      color: Colors.lightBlue[100 * (index % 9)],
                      child: Text('SliverFixedExtentList item $index'),
                    );
                  },
                  childCount: _count + 20,
                ),
              ),
              new SliverToBoxAdapter(
                  child: new Container(
                padding: EdgeInsets.only(top: 10, bottom: 10),
                color: Colors.green,
                child: new SizedBox(
                    child: new Text(
                  'SliverGrid',
                  style: new TextStyle(fontSize: 16),
                )),
              )),
              SliverGrid(
                gridDelegate: SliverGridDelegateWithMaxCrossAxisExtent(
                  maxCrossAxisExtent: 200.0,
                  mainAxisSpacing: 10.0,
                  crossAxisSpacing: 10.0,
                  childAspectRatio: 4.0,
                ),
                delegate: SliverChildBuilderDelegate(
                  (BuildContext context, int index) {
                    return Container(
                      alignment: Alignment.center,
                      color: Colors.teal[100 * (index % 9)],
                      child: Text('SliverGrid item2 $index'),
                    );
                  },
                  childCount: _count + 10,
                ),
              ),
              new SliverToBoxAdapter(
                child: new Visibility(
                  child: new Container(
                    padding: EdgeInsets.fromLTRB(0, 10, 0, 10),
                    child: new Center(
                      child: new Text(loadingText),
                    ),
                  ),
                  visible: _isLoding,
                ),
              ),
            ],
          ),
          onRefresh: () {
            if (_isLoding) return null;
            return _refreshPull().then((value) {
              print('success');
              setState(() {
                _count += 10;
              });
            }).catchError((error) {
              print('failed');
            });
          },
        ),
      ),
    ),
  ),
);
}

Future<String> _refreshPull() async {
  await Future.delayed(new Duration(seconds: 3));
    return "_refreshPull";
  }
}

  // var list = [];
  // int page = 0;
  // bool isLoading = false;//是否正在请求新数据
  // bool showMore = false;//是否显示底部加载中提示
  // bool offState = false;//是否显示进入页面时的圆形进度条

  // ScrollController scrollController = ScrollController();

  // @override
  // void initState() {
  //   super.initState();
  //   scrollController.addListener(() {
  //     if (scrollController.position.pixels ==
  //         scrollController.position.maxScrollExtent) {
  //       print('滑动到了最底部${scrollController.position.pixels}');
  //       setState(() {
  //         showMore = true;
  //       });
  //       getMoreData();
  //     }
  //   });
  //   getListData();
  // }

  // @override
  // Widget build(BuildContext context) {
  //   return MaterialApp(
  //     home: Scaffold(
  //         appBar: AppBar(
  //           title: Text("RefreshIndicator"),
  //         ),
  //         body: Stack(
  //           children: <Widget>[
  //             RefreshIndicator(
  //               child: ListView.builder(
  //                 controller: scrollController,
  //                 itemCount: list.length + 1,//列表长度+底部加载中提示
  //                 itemBuilder: choiceItemWidget,
  //               ),
  //               onRefresh: _onRefresh,
  //             ),
  //             Offstage(
  //               offstage: offState,
  //               child: Center(
  //                 child: CircularProgressIndicator(),
  //               ),
  //             ),
  //           ],
  //         )
  //     ),
  //   );
  // }

  // @override
  // void dispose() {
  //   super.dispose();
  //   //手动停止滑动监听
  //   scrollController.dispose();
  // }

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

  // /**
  //  * 加载更多提示组件
  //  */
  // Widget showMoreLoadingWidget() {
  //   return Container(
  //     height: 50.0,
  //     color: Colors.transparent,
  //     child: Row(
  //       mainAxisAlignment: MainAxisAlignment.center,
  //       crossAxisAlignment: CrossAxisAlignment.center,
  //       children: <Widget>[
  //         Text('加载中...', style: TextStyle(fontSize: 16.0),),
  //       ],
  //     ),
  //   );
  // }

  // /**
  //  * 模拟进入页面获取数据
  //  */
  // void getListData() async {
  //   if (isLoading) {
  //     return;
  //   }
  //   setState(() {
  //     isLoading = true;
  //   });
  //   await Future.delayed(Duration(seconds: 3), () {
  //     setState(() {
  //       isLoading = false;
  //       offState = true;
  //       list = List.generate(20, (i) {
  //         return ItemInfo("ListView的一行数据$i");
  //       });
  //     });
  //   });
  // }

  // /**
  //  * 模拟到底部加载更多数据
  //  */
  // void getMoreData() async {
  //   if (isLoading) {
  //     return;
  //   }
  //   setState(() {
  //     isLoading = true;
  //     page++;
  //   });
  //   print('上拉刷新开始,page = $page');
  //   await Future.delayed(Duration(seconds: 3), () {
  //     setState(() {
  //       isLoading = false;
  //       showMore = false;
  //       list.addAll(List.generate(3, (i) {
  //         return ItemInfo("上拉添加ListView的一行数据$i");
  //       }));
  //       print('上拉刷新结束,page = $page');
  //     });
  //   });
  // }

  // /**
  //  * 模拟下拉刷新
  //  */
  // Future < void > _onRefresh() async {
  //   if (isLoading) {
  //     return;
  //   }
  //   setState(() {
  //     isLoading = true;
  //     page = 0;
  //   });

  //   print('下拉刷新开始,page = $page');

  //   await Future.delayed(Duration(seconds: 3), () {
  //     setState(() {
  //       isLoading = false;

  //       List tempList = List.generate(3, (i) {
  //         return ItemInfo("下拉添加ListView的一行数据$i");
  //       });
  //       tempList.addAll(list);
  //       list = tempList;
  //       print('下拉刷新结束,page = $page');
  //     });
  //   });
  // }
// }

// class ItemInfo {
//   String title;
//   ItemInfo(this.title);
// }

// // 定义一个回调接口
// typedef OnItemClickListener = void Function(int position);

// class HomeListItem extends StatelessWidget {
//   int position;
//   ItemInfo iteminfo;
//   OnItemClickListener listener;

//   HomeListItem(this.position, this.iteminfo, this.listener);

//   @override
//   Widget build(BuildContext context) {
//     var widget = Column(
//       children: <Widget>[
//         Container(
//           child: Column(
//             children: <Widget>[
//               Row(
//                 children: <Widget>[
//                   Text(
//                     iteminfo.title,
//                     style: TextStyle(
//                       fontSize: 15.0,
//                       color: Color(0xff999999),
//                     ),
//                   )
//                 ],
//               ),
//             ],
//             mainAxisAlignment: MainAxisAlignment.center,
//           ),
//           height: 50.0,
//           color: Color.fromARGB(255, 241, 241, 241),
//           padding: EdgeInsets.only(left: 20.0),
//         ),
//         //用Container设置分割线
//         Container(
//           height: 1.0,
//           color: Color.fromARGB(255, 230, 230, 230),
//         )
//         //分割线
// //      Divider()
//       ],
//     );
//     //InkWell点击的时候有水波纹效果
//     return InkWell(onTap: () => listener(position), child: widget);
//   }
// }