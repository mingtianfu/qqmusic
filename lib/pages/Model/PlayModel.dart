import 'package:flutter/material.dart';
import 'package:qqmusic/models/trackItem.dart';
import 'package:qqmusic/pages/LyricPage.dart';

class PlayModel with ChangeNotifier {
  List<TrackItem> _songList = [];
  int _songListIndex;
  LyricContent _lyric;

  List<TrackItem> get songList => _songList;
  int get songListIndex => _songListIndex;
  LyricContent get lyric => _lyric;

  void setSongList(List<TrackItem> list) {
    _songList = list;
    notifyListeners();
  }

  void reduceSongList() {
    _songList = [];
    notifyListeners();
  }

  setSongListIndex(int index) {
    print(index);
    _songListIndex = index;
    notifyListeners();
  }

  setLyric(LyricContent lyric) {
    _lyric = lyric;
    notifyListeners();
  }

}