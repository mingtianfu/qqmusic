import 'package:flutter/material.dart';
import 'package:flutter/foundation.dart';

class StaggerAnimation extends StatelessWidget {
  StaggerAnimation({Key key, this.controller }): super(key: key) {
    height = Tween<double>(
      begin: .0,
      end: 300.0,
    ).animate(
      CurvedAnimation(
        parent: controller,
        curve: Interval(
          0.0,
          0.6,
          curve: Curves.ease,
        ),
      ),
    );

    color = ColorTween(
      begin: Colors.green,
      end: Colors.red,
    ).animate(
      CurvedAnimation(
        parent: controller,
        curve: Interval(
          0.0,
          0.6,
          curve: Curves.ease,
        ),
      ),
    );
  }

  final Animation<double> controller;
  Animation<double> height;
  Animation<Color> color;

  Widget _buildAnimation(BuildContext context, Widget child) {
    return Container(
      alignment: Alignment.center,
      child: Container(
        color: color.value,
        width: 50.0,
        height: height.value,
      ),
    );
  }

  @override 
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceAround,
      children: <Widget>[
        Container(
          alignment: Alignment.center,
          child: Container(
            color: Colors.grey,
            width: 20.0,
            height: 50.0,
            child: AnimatedBuilder(
              builder: _buildAnimation,
              animation: controller,
            ),
          ),
        ),
        Container(
          alignment: Alignment.center,
          child: Container(
            color: Colors.grey,
            width: 20.0,
            height: 150.0,
            child: AnimatedBuilder(
              builder: _buildAnimation,
              animation: controller,
            ),
          ),
        ),
        Container(
          alignment: Alignment.center,
          child: Container(
            color: Colors.grey,
            width: 20.0,
            height: 200.0,
            child: AnimatedBuilder(
              builder: _buildAnimation,
              animation: controller,
            ),
          ),
        ),
        Container(
          alignment: Alignment.center,
          child: Container(
            color: Colors.grey,
            width: 20.0,
            height: 150.0,
            child: AnimatedBuilder(
              builder: _buildAnimation,
              animation: controller,
            ),
          ),
        ),
        Container(
          alignment: Alignment.center,
          child: Container(
            color: Colors.grey,
            width: 20.0,
            height: 50.0,
            child: AnimatedBuilder(
              builder: _buildAnimation,
              animation: controller,
            ),
          ),
        )
      ],
    );
  }
}