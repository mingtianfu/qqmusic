import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';
import 'package:qqmusic/component/AppBarSearch.dart';

class MyPage extends StatefulWidget {
  @override 
  _MyPageState createState() => _MyPageState();
}

class _MyPageState extends State<MyPage> with SingleTickerProviderStateMixin{

List<String> items = ["1", "2", "3", "4", "5"];
//  List<String> items = ["1", "2", "3", "4", "5", "6", "7", "8"];
  RefreshController _refreshController =
  RefreshController(initialRefresh: true);

  void _onRefresh() async {
    // monitor network fetch
    await Future.delayed(Duration(milliseconds: 1000));
    // if failed,use refreshFailed()
    _refreshController.refreshCompleted();
  }

  void _onLoading() async {
    // monitor network fetch
    await Future.delayed(Duration(milliseconds: 1000));
    // if failed,use loadFailed(),if no data return,use LoadNodata()
    items.add((items.length + 1).toString());
    if (mounted)
      setState(() {
        
      });
    _refreshController.loadComplete();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SmartRefresher(
        enablePullDown: true,
        enablePullUp: true,
        // WaterDropHeader、ClassicHeader、CustomHeader、LinkHeader、MaterialClassicHeader、WaterDropMaterialHeader
        header: CustomHeader(
          builder: (BuildContext context,RefreshStatus mode){
            return SpinKitWave(
              size: 20,
              color: Colors.green, 
              type: SpinKitWaveType.start
            );
            // return Center(
            //   child: Text(
            //     mode == RefreshStatus.idle
            //       ? "下拉刷新"
            //       : mode==RefreshStatus.refreshing 
            //         ? "刷新中..."
            //         : mode==RefreshStatus.canRefresh
            //           ? "可以松手了!"
            //           : mode==RefreshStatus.completed
            //             ? "刷新成功!" : "刷新失败"
            //   )
            // );
          }
        //  height: 45.0,
        //  releaseText: '松开手刷新',
        //  refreshingText: '刷新中',
        //  completeText: '刷新完成',
        //  failedText: '刷新失败',
        //  idleText: '下拉刷新',
        ),

        // ClassicFooter、CustomFooter、LinkFooter、LoadIndicator
        footer: CustomFooter(
          builder: (BuildContext context, LoadStatus mode) {
            Widget body;
            if (mode == LoadStatus.idle) {
              body = Text("pull up load");
            }
            else if (mode == LoadStatus.loading) {
              body = CupertinoActivityIndicator();
            }
            else if (mode == LoadStatus.failed) {
              body = Text("Load Failed!Click retry!");
            }
            else {
              body = Text("No more Data");
            }
            return Container(
              height: 55.0,
              child: Center(child: body),
            );
          },
        ),
        controller: _refreshController,
        onRefresh: _onRefresh,
        onLoading: _onLoading,
        child: ListView.builder(
          itemBuilder: (c, i) => Card(child: Center(child: Text(items[i]))),
          itemExtent: 100.0,
          itemCount: items.length,
        ),
      ),
    );
  }
  // void handlePresseSearch() {
  //   print('搜索页面');
  // }

  // void handleRecognize() {
  //   print('更多页面');
  // }

  // child: Scrollbar(
  //   child: SingleChildScrollView (
  //     child: Center(
  //       child: Column(
  //         children: <Widget>[
            
  //           AppBarSearch(
  //             title: '我的', 
  //             rightImage: Image.asset('assets/images/fragment_my_music_more.png', width: 30,),
  //             onPressedRight: handleRecognize,
  //             onPressed: handlePresseSearch,
  //           ),
  //         ],
  //       ),
  //     )
  //   ),
  // )
  
}
