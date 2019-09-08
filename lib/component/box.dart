import 'package:flutter/material.dart';

class Box extends StatefulWidget {
  Box({
    Key key,
    this.active: false,
    @required this.onChanged
  }): super(key: key);

  final bool active;
  final ValueChanged<bool> onChanged;

  @override
  _BoxState createState() => new _BoxState();
}

class _BoxState extends State<Box> {
  bool _highlight = false;

  void _handleTapDown(TapDownDetails details) {
    setState(() {
      _highlight = true;
    });
  }

  void _handleTapUp(TapUpDetails details) {
    setState(() {
      _highlight = false;
    });
  }

  void _handleTapCancel() {
    setState(() {
      _highlight = false;
    });
  }

  void _handleTap() {
    widget.onChanged(!widget.active);
  }

  @override
  Widget build(BuildContext context) {
    return new GestureDetector(
      onTapDown: _handleTapDown,
      onTapUp: _handleTapUp,
      onTap: _handleTap,
      onTapCancel: _handleTapCancel,
      child: new Container(
        width: 200,
        height: 200,
        decoration: new BoxDecoration(
          color: widget.active ? Colors.lightGreen[700] : Colors.grey[600],
          border: _highlight
            ? new Border.all(
              color: Colors.teal[700],
              width: 10.0
            )
            : null,
        ),
        child: new Text(
          'box',
          style: new TextStyle(
            fontSize: 30,
            color: Colors.white
          )
        ),
      ),
    );
  }
}