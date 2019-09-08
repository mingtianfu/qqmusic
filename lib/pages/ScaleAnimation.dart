import 'package:flutter/material.dart';
import 'package:qqmusic/component/GrowTransition.dart';

class ScaleAnimation extends StatefulWidget {
  @override
  _ScaleAnimationState createState() => new _ScaleAnimationState();
}

class _ScaleAnimationState extends State<ScaleAnimation>   with SingleTickerProviderStateMixin{
  Animation<double> animation;
  AnimationController controller;

  initState() {
    super.initState();
    controller = new AnimationController(
      duration: const Duration(seconds: 3),
      vsync: this
    );

//使用弹性曲线
    animation = CurvedAnimation(
      parent: controller, 
      curve: Curves.bounceInOut
    );

    animation = new Tween(
      begin: 0.0,
      end: 300.0,
    ).animate(controller);

    animation.addStatusListener((status) {
      if (status == AnimationStatus.completed) {
        //动画执行结束时反向执行动画
        controller.reverse();
      } else if (status == AnimationStatus.dismissed) {
        //动画恢复到初始状态时执行动画（正向）
        controller.forward();
      }
    });

    controller.forward();
  }

  @override
  Widget build(BuildContext context) {
    // return new Center(
    //    child: Image.asset("assets/images/p.jpg",
    //       width: animation.value,
    //       height: animation.value
    //   ),
    // );
    return GrowTransition(
      animation: animation,
      child: Hero(tag: 'p', child: Image.asset("assets/images/p.jpg"),)
    );
  }

  dispose() {
    //路由销毁时需要释放动画资源
    controller.dispose();
    super.dispose();
  }

}