import 'package:flutter/material.dart';

class ImageButton extends StatelessWidget {
  ImageButton({
    this.width,
    this.height,
    this.onTap,
    @required this.assetImage,
  });

  // 宽高
  final double width;
  final double height;
  final AssetImage assetImage;
  //点击回调
  final GestureTapCallback onTap;

  @override 
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: new Image(
        height: height,
        width: width,
        image: assetImage,
      ),
    );
  }
}