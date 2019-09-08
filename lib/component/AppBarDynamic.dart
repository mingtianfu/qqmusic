import 'package:flutter/cupertino.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:qqmusic/component/SwitchButton.dart';

class AppBarDynamic extends StatelessWidget {
  AppBarDynamic({
    this.title,
    this.rightImage,
    this.onPressedRight,
    this.onPressedForward,
    this.onPressedReverse,
  });

  final String title;
  final Image rightImage;
  final GestureTapCallback onPressedRight;
  final GestureTapCallback onPressedForward;
  final GestureTapCallback onPressedReverse;

  @override 
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(vertical: 0.0, horizontal: 15),
      child: Column(
        children: <Widget>[
          Container(
            height: 40,
            child: Row(
              children: <Widget>[
                new Text(title, style: TextStyle(color: Colors.black, fontSize: 20, fontWeight: FontWeight.bold),),
                Expanded(
                  child: Container(
                    alignment: Alignment.center,
                    width: 200,
                    height: 30,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(15.0)
                    ),
                    child: SwitchButton(
                      textForward: '精选',
                      textReverse: '关注',
                      onPressedForward: onPressedForward,
                      onPressedReverse: onPressedReverse
                    ),
                  ),
                ),
                GestureDetector(
                  child: rightImage,
                  onTap: onPressedRight,
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}