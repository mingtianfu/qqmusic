import 'package:qqmusic/models/trackItem.dart';
import 'package:qqmusic/pages/LyricPage.dart';

class InheritedTestModel {
  final List<TrackItem> songList;
  final int songListIndex;
  final LyricContent lyric;
  const InheritedTestModel(this.songList, this.songListIndex, this.lyric);
}