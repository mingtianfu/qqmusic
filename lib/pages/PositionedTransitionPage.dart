import 'package:flutter/material.dart';
import 'package:qqmusic/component/PullToRefreshNotification.dart';

// class PositionedTransitionPage extends StatelessWidget {
//   @override
//   Widget build(BuildContext context) {
//     return MaterialApp(
//       theme: ThemeData(
//         primaryColor: Colors.white,
//       ),
//       home: WeWidget(),
//     );
//   }
// }

class PositionedTransitionPage extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return WeWidgetState();
  }
}

class WeWidgetState extends State<PositionedTransitionPage>
    with SingleTickerProviderStateMixin {

  Future<Null> _onRefresh() async{
    await Future.delayed(Duration(milliseconds: 1000));
  }

  Widget build(BuildContext context) {
    return PullToRefreshNotification(
        onRefresh: _onRefresh,
        appbar: SliverAppBar(
          leading: Container(
            padding: EdgeInsets.only(left: 10),
            alignment: Alignment.center,
            child: Text('推荐', style: TextStyle(color: Colors.black, fontSize: 20, fontWeight: FontWeight.bold),),
          ),
          title: GestureDetector(
            onTap: () => Navigator.of(context).pushNamed('searchPage'),
            child: Container(
              margin: EdgeInsets.symmetric(vertical: 0.0, horizontal: 0),
              height: 30,
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(15.0)
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  Image.asset('assets/images/label_search_icon.png', width: 24,),
                  Text('搜索', style: TextStyle(
                    color: Colors.grey,
                    fontSize: 14,
                  )),
                ],
              ),
            ),
          ),
          actions: <Widget>[
            GestureDetector(
              child: Image.asset('assets/images/icon_menu_recognize_lyric.png', width: 30,),
            ),
            Container(width: 15,)
          ],
          backgroundColor: Colors.transparent,
          pinned: false,
          expandedHeight: 60,
          // flexibleSpace: FlexibleSpaceBar(
          //   title: Text('_top.value'),
          // ),
        ),
        child: new SliverList(
          delegate: new SliverChildBuilderDelegate(
            (BuildContext context, int index) {
              return new Container(
                // color: Colors.grey[50],
                child: Column(
                  children: <Widget>[
                    Text('1'),
                  ],
                )
              );
            },
            childCount: 50 //50个列表项
          ),
        ),
      );
  }
  // Animation<Rect> _animation;
  // AnimationController _controller;
  // Animation _curve;

  // Rect _animationValue;
  // AnimationStatus _state;

  // @override
  // void initState() {
  //   super.initState();

  //   _controller = AnimationController(
  //     duration: const Duration(milliseconds: 3000),
  //     vsync: this,
  //   );
  //   _curve = CurvedAnimation(parent: _controller, curve: Curves.fastOutSlowIn);
  //   _animation = RectTween(
  //     begin: Rect.fromLTWH(0, 0, 400, 100),
  //     end: Rect.fromLTWH(0, 50, 400, 100),
  //     )
  //       .animate(_curve)
  //         ..addListener(() {
  //           setState(() {
  //             _animationValue = _animation.value;
  //           });
  //         })
  //         ..addStatusListener((AnimationStatus state) {
  //           if (state == AnimationStatus.completed) {
  //             _controller.reverse();
  //           } else if (state == AnimationStatus.dismissed) {
  //             _controller.forward();
  //           }

  //           setState(() {
  //             _state = state;
  //           });
  //         });
  //   _controller.forward();
  // }

  // @override
  // Widget build(BuildContext context) {
  //   return Scaffold(
  //     appBar: AppBar(
  //       title: Text("day13"),
  //     ),
  //     body: _buildColumn(),
  //   );
  // }

  // Widget _buildColumn() {
  //   return Stack(
  //     children: <Widget>[
  //       // AnimatorTransition(
  //       //   child: Container(child: Text('data'),),
  //       //   animation: _animation,
  //       // ),
  //       RelativePositionedTransition(
  //         rect: _animation,
  //         size: Size(300, 70),
  //         child:  Text('data')),
  //       // PositionedTransition(
  //       //   rect: _animation,
  //       //   child: Container(child: Text('data'),),
  //       // ),
  //       Center(
  //         // padding: EdgeInsets.fromLTRB(0, 15, 0, 0),
  //         child: Text("动画值：" + _animationValue.toString()),
  //       ),
  //       // Padding(
  //       //   padding: EdgeInsets.fromLTRB(0, 30, 0, 0),
  //       //   child: Text("动画状态：" + _state.toString()),
  //       // ),
  //     ],
  //   );
  // }

  // @override
  // void dispose() {
  //   _controller.dispose();
  //   super.dispose();
  // }
}

// class AnimatorTransition extends StatelessWidget {
//   final Widget child;
//   final Animation<RelativeRect> animation;

//   AnimatorTransition({this.child, this.animation});

//   @override
//   Widget build(BuildContext context) {
//     //绝对定位的动画实现, 需要Stack包裹
//     return Stack(
//       children: <Widget>[
//         PositionedTransition(
//           rect: animation,
//           child: this.child,
//         ),
//       ],
//     );
//   }
// }
// ————————————————
// 版权声明：本文为CSDN博主「Hensen_」的原创文章，遵循 CC 4.0 BY-SA 版权协议，转载请附上原文出处链接及本声明。
// 原文链接：https://blog.csdn.net/qq_30379689/article/details/98099029