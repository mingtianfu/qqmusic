import 'package:flutter/material.dart';
import 'package:qqmusic/pages/BottomPlayBar.dart';

class DragPage extends StatefulWidget {
  @override
  _DragState createState() => new _DragState();
}

class _DragState extends State<DragPage> with SingleTickerProviderStateMixin {
  double _top = 100.0; //距顶部的偏移
  double _left = 0.0;//距左边的偏移

  @override
  Widget build(BuildContext context) {
    return SafeArea( 
      child: Stack(
      children: <Widget>[
                  Hero(
            tag: 'BottomPlayBar',
            child: BottomPlayBar(),
          ),
        Positioned(
          top: _top,
          left: _left,
          child: GestureDetector(
            child: CircleAvatar(child: Text("A")),
            //手指按下时会触发此回调
            // onPanDown: (DragDownDetails e) {
            //   //打印手指按下的位置(相对于屏幕)
            //   print("用户手指按下：${e.globalPosition}");
            // },
            //手指滑动时会触发此回调
            // onPanUpdate: (DragUpdateDetails e) {
            //   //用户手指滑动时，更新偏移，重新构建
            //   setState(() {
            //     _left += e.delta.dx;
            //     _top += e.delta.dy;
            //   });
            // },
            onVerticalDragUpdate: (DragUpdateDetails e) {
              //用户手指滑动时，更新偏移，重新构建
              setState(() {
                _left += e.delta.dx;
                _top += e.delta.dy;
              });
            },
            onHorizontalDragUpdate: (DragUpdateDetails e) {
              setState(() {
                _left += e.delta.dx;
              });
            },
            // onPanEnd: (DragEndDetails e){
            //   //打印滑动结束时在x、y轴上的速度
            //   print(e.velocity);
            // },
          ),
        )
      ],
    ),
    );
  }
}