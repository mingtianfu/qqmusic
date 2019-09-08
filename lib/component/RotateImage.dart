import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class RotaeImage extends StatelessWidget {
  RotaeImage({Key key, this.size, this.turns: .0, this.speed: 500, this.controller}): super(key: key);

  final AnimationController controller;
  final double turns;
  final double size;
  final int speed;

  Widget build(BuildContext context) {
    return RotationTransition(
      turns: new Tween(begin: 0.0, end: 1.0).animate(controller),
        child: ClipOval(
            child:FadeInImage.assetNetwork(
              placeholder: "assets/images/p.jpg",//预览图
              fit: BoxFit.fitWidth,
              image:"http://p1.music.126.net/7ZKMPIvPcwaK08ffDBTjJw==/109951164124664532.jpg?param=130y130",
              width: size,
              height: size,
            ),
          ),
    );
  }
}