import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:qqmusic/pages/Model/PlayModel.dart';

class RotaeImage extends StatefulWidget {
  RotaeImage({Key key, this.url, this.size, this.turns: .0, this.speed: 500, this.isPlay: false}): super(key: key);
  final double turns;
  final double size;
  final int speed;
  final String url;
  final bool isPlay;

  @override
  _RotaeImageState createState() => _RotaeImageState();
}

class _RotaeImageState extends State<RotaeImage> with SingleTickerProviderStateMixin{

  AnimationController animationController;

  @override
  void initState() {
    super.initState();
    animationController = new AnimationController(vsync: this, duration: Duration(seconds: 10))
    ..addListener(() {
      setState(() {});
    })
    ..addStatusListener((status) {
      if (status == AnimationStatus.completed) {
        //动画从 controller.forward() 正向执行 结束时会回调此方法
        //重置起点
        animationController.reset();
        //开启
        animationController.forward();
      }
    });
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    final playModel = Provider.of<PlayModel>(context);
    if (playModel.autoPlay) {
      animationController.forward();
    } else {
      animationController.stop();
    }
  }

  @override
  void dispose() {
    animationController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return RotationTransition(
      turns: new Tween(begin: 0.0, end: 1.0).animate(animationController),
      child: ClipOval(
        child: widget.url == '' ? Image.asset('assets/images/player_album_cover_default.png', width: widget.size,)
        : CachedNetworkImage(
            placeholder: (context, url) => Image.asset('assets/images/player_album_cover_default.png', width: widget.size,),
            imageUrl: widget.url + '?param=200y200',
//          widget.url,
            width: widget.size,
            height: widget.size,
        ),
      ),
    );
  }
}