import 'package:flutter/material.dart';
import 'package:qqmusic/component/RefreshCustomScrollView/pull_to_refresh.dart';
// import 'package:pull_to_refresh/pull_to_refresh.dart';
import 'package:qqmusic/component/SpinWave.dart';
import 'package:qqmusic/component/SpinWaveFill.dart';
import 'package:qqmusic/component/AppBarDynamic.dart';

class DynamicPage extends StatefulWidget {
  @override 
  _DynamicPageState createState() => _DynamicPageState();
}

class _DynamicPageState extends State<DynamicPage>  with TickerProviderStateMixin{

  List<String> items = ["1", "2", "3", "4", "5"];
  double percent = 0;
  bool enablePullDown = true;
  bool enablePullUp = true;

  RefreshController _refreshController = RefreshController(initialRefresh: true);

  @override
  void initState() {
    super.initState();
  }

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


  void handlePresseForward() {
    print('handlePresseForward');
  }

  void handlePresseReverse() {
    print('handlePresseReverse');
  }

  void handleRecognize() {
    print('更多推荐');
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Center(
        child: RefreshCustomScrollView(
        enablePullDown: true,
        enablePullUp: true,
        // // ClassicFooter、CustomFooter、LinkFooter、LoadIndicator
        // footer: CustomFooter(
        //   builder: (BuildContext context, LoadStatus mode) {
        //     Widget body;
        //     if (mode == LoadStatus.idle) {
        //       body = Text("pull up load");
        //     }
        //     else if (mode == LoadStatus.loading) {
        //       body = SpinWave(
        //               size: 20,
        //               color: Colors.black87,
        //             );
        //     }
        //     else if (mode == LoadStatus.failed) {
        //       body = Text("Load Failed!Click retry!");
        //     }
        //     else {
        //       body = Text("No more Data");
        //     }
        //     return Container(
        //       height: 55.0,
        //       child: Center(child: body),
        //     );
        //   },
        // ),
        controller: _refreshController,
        onRefresh: _onRefresh,
        onLoading: _onLoading,
        // top: AppBarDynamic(
        //   title: '动态', 
        //   rightImage: Image.asset('assets/images/discovery_add_follow_light.png', width: 30,),
        //   onPressedRight: handleRecognize,
        //   onPressedForward: handlePresseForward,
        //   onPressedReverse: handlePresseReverse,
        // ),
        child: ListView.builder(
          itemBuilder: (c, i) => Card(child: Center(child: Text(items[i]))),
          itemExtent: 100.0,
          itemCount: items.length,
        ),
    ),
      ),
    );
  }

  // Widget build(BuildContext context) {
  //   return SafeArea(
  //     child: Scrollbar(
  //       child: SingleChildScrollView (
  //         child: Container(
  //           child: Column(
  //             children: <Widget>[
  //               AppBarDynamic(
  //                 title: '动态', 
  //                 rightImage: Image.asset('assets/images/discovery_add_follow_light.png', width: 30,),
  //                 onPressedRight: handleRecognize,
  //                 onPressedForward: handlePresseForward,
  //                 onPressedReverse: handlePresseReverse,
  //               ),
  //             ],
  //           ),
  //         ),
  //       ),
  //     ),
  //   );
  // }

}