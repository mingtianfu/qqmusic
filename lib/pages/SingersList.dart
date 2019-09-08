import 'package:flutter/material.dart';
import 'package:qqmusic/pages/BottomPlayBar.dart';

class SingersList extends StatelessWidget {
  @override 
  Widget build(BuildContext context) {
    return Column(
      children: <Widget>[
        Expanded(
          child: Center(
            child: Hero(
              tag: "avat1111ar", //唯一标记，前后两个路由页Hero的tag必须相同
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  Image.asset("assets/images/p.jpg",width: 100.0,),
                ],
              ),
            ),
          ),
        ),
        Hero(
          tag: 'BottomPlayBar',
          child: BottomPlayBar(),
        )
      ],
    );
  }
}