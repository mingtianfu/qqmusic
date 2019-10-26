import 'package:flutter/material.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';
import 'package:qqmusic/component/SpinWave.dart';
import 'package:qqmusic/component/SpinWaveFill.dart';

class HeaderWave extends StatefulWidget {
  @override 
  HeaderWaveState createState() => HeaderWaveState();
}

class HeaderWaveState extends State<HeaderWave> {
  double percent = 0.0;

  Widget build(BuildContext context) {
    return CustomHeader(
      refreshStyle: RefreshStyle.Behind,
      onOffsetChange: (offset) {
        double os = offset > 120 ? 120 : offset;
        setState(() {
          percent = (os / 120.0) < 0 ? 0 : (os / 120.0);
        });
        // if (_refreshController.headerMode.value == RefreshStatus.idle) {
          // setState(() {
          //   percent = offset / 160.0;
          // });
        // }
      },
      builder: (BuildContext context, RefreshStatus mode){
        return Center(
          child: 
            mode == RefreshStatus.idle
              ? // "下拉刷新" 
                SpinWaveFill(
                  size: 20,
                  color: Colors.black26,
                  percent: percent,
                )
              : mode==RefreshStatus.refreshing 
                ? // "刷新中..."
                SpinWave(
                  size: 20,
                  color: Colors.black87,
                )
                : mode==RefreshStatus.canRefresh
                  ? // "可以松手了!"
                  SpinWaveFill(
                    size: 20,
                    color: Colors.black26,
                    percent: percent,
                  )
                  : mode==RefreshStatus.completed
                    ? Text('刷新成功') : Text('刷新失败')
        );
      }
    );
  }
}