import 'package:flutter/material.dart';

class SwitchButton extends StatefulWidget {
  SwitchButton({
    Key key,
    this.textForward,
    this.textReverse,
    this.onPressedForward,
    this.onPressedReverse,
  }): super(key: key);

  final String textForward;
  final String textReverse;
  final GestureTapCallback onPressedForward;
  final GestureTapCallback onPressedReverse;
  @override
  State createState() => new _SwitchButtonState();
}

class _SwitchButtonState extends State<SwitchButton>
    with TickerProviderStateMixin {
  AnimationController _controller;
  Animation<double> right;

  @override
  void initState() {
    super.initState();

    _controller = AnimationController(
        duration: const Duration(milliseconds: 300),
        vsync: this
    );
    right = new Tween(
      begin: 0.0,
      end: 60.0,
    ).animate(_controller);
  }

  dispose() {
    //路由销毁时需要释放动画资源
    _controller.dispose();
    super.dispose();
  }

  void handleForward () {
    widget.onPressedForward();
    _controller.forward();
  }

  void handleReverse () {
    widget.onPressedReverse();
    _controller.reverse();
  }

  Widget _buildAnimation(BuildContext context, Widget child) {
    return Positioned(
      right: right.value,
      child: Container(
        width: 60.0,
        height: 30.0,
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(15.0)
        ),
      ),
    );
  }

  Widget build(BuildContext context) {
    return Container(
      width: 120.0,
      height: 30.0,
      decoration: BoxDecoration(
        color: Colors.grey[300],
        borderRadius: BorderRadius.circular(15.0)
      ),
      child: Stack(
        alignment:Alignment.center,
        children: <Widget>[
          AnimatedBuilder(
            builder: _buildAnimation,
            animation: _controller,
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: <Widget>[
              GestureDetector(
                child: Text(widget.textForward),
                onTap: () {
                  handleForward();
                },
              ),
              GestureDetector(
                child: Text(widget.textReverse),
                onTap: () {
                  handleReverse();
                },
              )
            ],
          ),
        ],
      ),
    );
  }
}