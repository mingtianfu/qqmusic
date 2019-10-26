import 'dart:async';
import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_ijkplayer/flutter_ijkplayer.dart';
import 'package:qqmusic/models/trackItem.dart';
import 'package:qqmusic/pages/Database/ArHelper.dart';
import 'package:qqmusic/pages/Database/SongListHelper.dart';
import 'package:qqmusic/pages/LyricPage.dart';
import 'package:qqmusic/utils/HttpUtils.dart';
import 'package:shared_preferences/shared_preferences.dart';

class PlayModel with ChangeNotifier {
  var db = SongListHelper();
  var dbAr = ArHelper();

  IjkMediaController _audioPlayer = IjkMediaController();
  List<TrackItem> _songList = [];
  int _songListIndex = 0;
  bool _autoPlay = false;
  LyricContent _lyric;
  StreamSubscription _playFinishStream;
  IjkMediaController get audioPlayer => _audioPlayer;
  List<TrackItem> get songList => _songList;
  int get songListIndex => _songListIndex;
  bool get autoPlay => _autoPlay;
  LyricContent get lyric => _lyric;

  _initAudioPlayer() async {
    try {
      int id = _songList[_songListIndex].id;
      var result = await HttpUtils.request("/song/url?id=$id");
      var data = json.decode(result);
      if (data['code'] == 200 && data['data'][0]['url'] != null) {
        await _audioPlayer.setNetworkDataSource(data['data'][0]['url'],
            autoPlay: true);
        print(_autoPlay);
        if (!_autoPlay) {
          _audioPlayer.stop();
        }
        _getLyric(id);
      } else {
        print('当前不能播放，自动下一首');
        if (_songList.length > 1) {
          next(_songListIndex + 1);
        }
      }
    } catch (e) {
      print(e);
    }
    if (_playFinishStream == null) {
      subscriptPlayFinish();
    }
  }

  // 监听播放完成，自动下一首
  subscriptPlayFinish() {
    _playFinishStream = _audioPlayer.playFinishStream.listen((data) {
      print('监听播放完成，自动下一首');
      next(_songListIndex + 1);
    });
  }

  _getLyric(id) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    try {
      var result = await HttpUtils.request("/lyric?id=$id");

      if (result == null) {
        var lyric = prefs.getString('songLyric');
        if (lyric != null) {
          setLyric(LyricContent.from(lyric));
        }
        return false;
      }
      var data = json.decode(result);
      if (data['code'] == 200) {
        if (data['lrc'] != null) {
          prefs.setString('songLyric', data['lrc']['lyric'].toString());
          setLyric(LyricContent.from(data['lrc']['lyric'].toString()));
        } else {
          setLyric(null);
        }
      } else {
        setLyric(null);
      }
    } catch (e) {
      print(e);
    }
  }

  next(index) {
    print('next');
    if (index == _songList.length) {
      index = 0;
    }
    if (index == -1) {
      index = _songList.length - 1;
    }
    setSongListIndex(_songListIndex + 1);
  }

  void setSongList(List<TrackItem> list) {
    print('setSongList');
    _songList = list;
    _setDatabase(list);
    _initAudioPlayer();
    notifyListeners();
  }

  void reduceSongList() async {
    _songList = [];
    _audioPlayer.stop();
    await db.clear();
    notifyListeners();
  }

  setSongListIndex(int index) async {
    print('setSongListIndex');
    _songListIndex = index;
    SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.setInt('songListIndex', index);
    _initAudioPlayer();
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

  _setDatabase(List<TrackItem> list) async {
    await db.clear();
    for (int i = 0; i < list.length; i++) {
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
