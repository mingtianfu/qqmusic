import 'package:flutter/material.dart';
import 'package:qqmusic/models/trackItem.dart';
import 'package:qqmusic/pages/Database/ArHelper.dart';
import 'package:qqmusic/pages/Database/SongListHelper.dart';
import 'package:qqmusic/pages/LyricPage.dart';
import 'package:shared_preferences/shared_preferences.dart';

class PlayModel with ChangeNotifier {
  var db = SongListHelper();
  var dbAr = ArHelper();

  List<TrackItem> _songList = [];
  int _songListIndex;
  bool _autoPlay = false;
  LyricContent _lyric;

  List<TrackItem> get songList => _songList;
  int get songListIndex => _songListIndex;
  bool get autoPlay => _autoPlay;
  LyricContent get lyric => _lyric;

  void setSongList(List<TrackItem> list) {
    print('setSongList');
    _songList = list;
    _setDatabase(list);
    notifyListeners();
  }

  void reduceSongList() async{
    _songList = [];
    await db.clear();
    notifyListeners();
  }

  setSongListIndex(int index) async{
    _songListIndex = index;
    SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.setInt('songListIndex', index);
    notifyListeners();
  }

  setAutoPlay(bool autoPlay) {
    _autoPlay = autoPlay;
    notifyListeners();
  }

  setLyric(LyricContent lyric) {
    _lyric = lyric;
    notifyListeners();
  }

  _setDatabase(List<TrackItem> list) async{
    await db.clear();
    for(int i = 0; i < list.length; i++) {
      var item = list[i];
      Song song = new Song();
      ArItem ar = new ArItem();
      song.name = item.name;
      song.id = item.id;
      song.arId = item.ar[0].id;
      song.picUrl = item.al.picUrl;
      song.orders = i;
      await db.saveItem(song);

      ar.name = item.ar[0].name;
      ar.id = item.ar[0].id;
      ArItem aa = await dbAr.getItem(item.ar[0].id);
      if (aa == null) {
        await dbAr.saveItem(ar);
      }
    }
  }

}