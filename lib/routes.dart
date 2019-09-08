import 'package:qqmusic/pages/GradientCircularProgressRoute.dart';
import 'package:qqmusic/pages/PlaySongPage.dart';
import 'package:qqmusic/pages/ScaleAnimation.dart';
import 'package:qqmusic/pages/SingersList.dart';
// import 'package:qqmusic/pages/Stagger.dart';
import 'package:qqmusic/pages/drag.dart';
// import 'package:qqmusic/pages/list.dart';

final routes = {
  'gradientCircularProgressRoute': (context) => GradientCircularProgressRoute(),
  'playSongPage': (context) => PlaySongPage(),
  // 'listPage':(context) => ListPage(),
  'singersList':(context) => SingersList(),
  'dragPage':(context) => DragPage(),
  'scaleAnimation':(context) => ScaleAnimation(),
  // 'staggerPage':(context) => StaggerPage(),
};
