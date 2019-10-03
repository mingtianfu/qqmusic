import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

// class RotaeImage extends StatefulWidget {

//   @override
//   _RotaeImageState createState() => _RotaeImageState();
// }

class RotaeImage extends StatelessWidget{
  RotaeImage({Key key, this.url, this.size, this.turns: .0, this.speed: 500, this.animationController}): super(key: key);

  final double turns;
  final double size;
  final int speed;
  final String url;
  final AnimationController animationController;

  @override
  Widget build(BuildContext context) {
    return ClipOval(
        child: url == '' ? Image.asset('assets/images/player_album_cover_default.png', width: size,)
        : Image.network(
          url,
          width: size,
          height: size,
        ),
      );
    // RotationTransition(
    //   turns: new Tween(begin: 0.0, end: 1.0).animate(animationController),
    //   child: ClipOval(
    //     child: url == '' ? Image.asset('assets/images/player_album_cover_default.png', width: size,)
    //     : Image.network(
    //       url,
    //       width: size,
    //       height: size,
    //     ),
    //   ),
    // );
  }
}