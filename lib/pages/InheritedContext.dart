import 'package:flutter/material.dart';
import 'package:qqmusic/pages/InheritedTestModel.dart';
import 'package:qqmusic/pages/LyricPage.dart';

class InheritedContext extends InheritedWidget {
  
  // 数据
  final InheritedTestModel inheritedTestModel;

  // 添加到播放列表方法
  final Function(List songList, [int index]) increment;

  // 清除播放列表的方法
  final Function() reduce;

  // 设置播放歌曲的索引
  final Function(int index) setIndex;

  // 设置歌词
  final Function(LyricContent lyric) setLyric;

  InheritedContext({
    Key key,
    @required this.inheritedTestModel,
    @required this.increment,
    @required this.reduce,
    @required this.setIndex,
    this.setLyric,
    @required Widget child,
  }) : super(key: key, child: child);

  static InheritedContext of(BuildContext context) {
    return context.inheritFromWidgetOfExactType(InheritedContext);
  }

  //是否重建widget就取决于数据是否相同
  @override
  bool updateShouldNotify(InheritedContext oldWidget) {
    return inheritedTestModel != oldWidget.inheritedTestModel;
  }
}