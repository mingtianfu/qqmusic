import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:qqmusic/pages/BottomPlayBar.dart';

class ListPage extends StatelessWidget {
  ScrollController _controller = new ScrollController();
  bool showToTapBtn = false;

  Future<String> mockNetworkData() async {
    return Future.delayed(Duration(seconds: 2), () => "我是从互联网上获取的数据");
  }

  @override
  Widget build(BuildContext context) {
    //因为本路由没有使用Scaffold，为了让子级Widget(如Text)使用
    //Material Design 默认的样式风格,我们使用Material作为本路由的根。
    return Material(
      child: Column(
        children: <Widget>[
          Expanded(
            child: CustomScrollView(
              controller: _controller,
              slivers: <Widget>[
                //AppBar，包含一个导航栏
                SliverAppBar(
                  pinned: true,
                  expandedHeight: 250.0,
                  flexibleSpace: FlexibleSpaceBar(
                    title: const Text('Demo'),
                    background: Image.network(
                      "https://pic5.iqiyipic.com/image/20190823/d3/e9/a_100343233_m_601_m3_220_124.jpg", fit: BoxFit.cover,),
                  ),
                ),
                SliverPadding(
                  padding: const EdgeInsets.all(8.0),
                  sliver: new SliverGrid( //Grid
                    gridDelegate: new SliverGridDelegateWithFixedCrossAxisCount(
                      crossAxisCount: 2, //Grid按两列显示
                      mainAxisSpacing: 10.0,
                      crossAxisSpacing: 10.0,
                      childAspectRatio: 4.0,
                    ),
                    delegate: new SliverChildBuilderDelegate(
                          (BuildContext context, int index) {
                        //创建子widget      
                        return new Container(
                          alignment: Alignment.center,
                          color: Colors.cyan[100 * (index % 9)],
                          child: new Text('grid item $index'),
                        );
                      },
                      childCount: 20,
                    ),
                  ),
                ),
                //List
                new SliverFixedExtentList(
                  itemExtent: 50.0,
                  delegate: new SliverChildBuilderDelegate(
                          (BuildContext context, int index) {
                        //创建列表项      
                        return new Container(
                          alignment: Alignment.center,
                          color: Colors.lightBlue[100 * (index % 9)],
                          child: new Text('list item $index'),
                        );
                      },
                      childCount: 50 //50个列表项
                  ),
                ),
              ],
            ),
          ),
          Hero(
            tag: 'BottomPlayBar',
            child: BottomPlayBar(),
          ),
        ],
      ),
    );
  }
}