import 'package:flutter/material.dart';

class ListenPage extends StatefulWidget {
  @override
  _ListPageState createState() => _ListPageState();
}

class _ListPageState extends State<ListenPage> with SingleTickerProviderStateMixin{
  Animation<double> animation;
  Animation<double> animation1;
  AnimationController controller;

  @override
  initState() {
    super.initState();
    controller = new AnimationController(duration: const Duration(seconds: 1), vsync: this)
    ..addListener(() {
      setState(() {});
    })
    ..addStatusListener((status) {
      if (status == AnimationStatus.completed) {
        //动画从 controller.forward() 正向执行 结束时会回调此方法
        //重置起点
        controller.reset();
        //开启
        controller.forward();
      }
    });
    //图片宽高从0变到300
    animation = new Tween(begin: 360.0, end: 400.0).animate(controller)
      ..addListener(() {
        setState(()=>{});
      });
    animation1 = new Tween(begin: 400.0, end: 370.0).animate(controller)
      ..addListener(() {
        setState(()=>{});
      });
    //启动动画(正向执行)
    controller.forward();
  }
  @override
  dispose() {
    //路由销毁时需要释放动画资源
    controller.dispose();
    super.dispose();
  }
  
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('听歌识曲'),
      ),
      body: Center(
        child: Stack(
          children: <Widget>[
            Positioned(
              width: animation.value,
              height: animation.value,
              top: (400 - animation.value) / 2,
              left: (MediaQuery.of(context).size.width - animation.value) / 2,
              child: Image.asset('assets/images/bg_qafp_recording.png', color: Colors.green[50],)
            ),
            Positioned(
              width: animation1.value,
              height: animation1.value,
              top: (400 - animation1.value ) / 2,
              left: (MediaQuery.of(context).size.width - animation1.value) / 2,
              child: Image.asset('assets/images/bg_qafp_recording.png', color: Colors.white10,)
            ),
            Positioned(
              width: 350,
              height: 350,
              top: 50/2,
              left: (MediaQuery.of(context).size.width - 350) / 2,
              child: Image.asset('assets/images/bg_qafp_normal.png'),
            ),
            Container(
              width:  MediaQuery.of(context).size.width,
              height: 400,
              child: Center(
                child: Image.asset('assets/images/ic_qafp_6.png', width: 200,),
              ),
            ),
//            Positioned(
//              child: Image.asset('assets/images/bg_qafp_clicked.png'),
//            ),
          ],
        ),
      ),
    );
  }
}