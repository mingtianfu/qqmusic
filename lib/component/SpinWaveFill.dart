import 'package:flutter/material.dart';

class SpinWaveFill extends StatefulWidget {
  // ignore: prefer_const_constructors_in_immutables
  SpinWaveFill({
    Key key,
    this.color,
    this.size = 50.0,
    this.itemBuilder,
    this.percent = 0.0,
    this.duration = const Duration(milliseconds: 7000),
  })  : assert(
            !(itemBuilder is IndexedWidgetBuilder && color is Color) &&
                !(itemBuilder == null && color == null),
            'You should specify either a itemBuilder or a color'),
        assert(size != null),
        super(key: key);

  final Color color;
  final double size;
  final double percent;
  final IndexedWidgetBuilder itemBuilder;
  final Duration duration;

  @override
  _SpinKitWaveState createState() => _SpinKitWaveState();
}

class _SpinKitWaveState extends State<SpinWaveFill>
    with SingleTickerProviderStateMixin {

  @override
  Widget build(BuildContext context) {
    List<Widget> _bars = [
      _bar(0, 0.5),
      _bar(1, 0.75),
      _bar(2, 1),
      _bar(3, 0.75),
      _bar(4, 0.5),
    ];
    return Center(
      child: SizedBox.fromSize(
        size: Size(widget.size * 1.5, widget.size),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: _bars,
        ),
      ),
    );
  }

  Widget _bar(int index, double delay) {
    final _size = widget.size * 0.15;
    final _height = delay * 20;
    return SizedBox.fromSize(
      size: Size(_size, _height),
      child: DecoratedBox(
            decoration: BoxDecoration(
              borderRadius: BorderRadius.all(Radius.circular(2)),
              color: Colors.black26,
            ),
            child: _itemBuilder(_size, _height * widget.percent),
          ),
    );
  }

  Widget _itemBuilder(_size, _height) {
    return UnconstrainedBox(
      child: SizedBox.fromSize(
              size: Size(_size, _height < 0 ? 0 : _height),
              child: DecoratedBox(
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.all(Radius.circular(2)),
                  color: Colors.black87,
                ),
            ),
          ),
    );
  }

}
