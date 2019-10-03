import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_ijkplayer/flutter_ijkplayer.dart';
import 'package:qqmusic/models/mvDetail.dart';
import 'package:qqmusic/utils/HttpUtils.dart';

class MvPlayPage extends StatefulWidget {
  MvPlayPage({Key key, this.id}):super(key: key);
  final id;

  @override
  _MvPlayPageState createState() => _MvPlayPageState();
}

class _MvPlayPageState extends State<MvPlayPage> {
  IjkMediaController _audioPlayer = IjkMediaController();
  MvDetail mvDetail;

  @override
  void initState() {
    super.initState();
    _initAudioPlayer();
    _getMvDetail();
  }

  @override
  void dispose() {
    _audioPlayer.dispose();
    super.dispose();
  }

  _getMvDetail() async {
      var result = await HttpUtils.request("/mv/detail?mvid=${widget.id}");
      var data = json.decode(result);
      if (data['code'] == 200) {
        setState(() {
          mvDetail = MvDetail.fromJson(data['data']);
        });
      } else {
        // print('当前不能播放，自动下一首');
        // if (_songList.length > 1) {
        //   next(_songListIndex + 1);
        // }
      }
  }

  _initAudioPlayer() async {
    try {
      var result = await HttpUtils.request("/mv/url?id=${widget.id}");
      var data = json.decode(result);
      if (data['code'] == 200 && data['data']['url'] != null) {
        await _audioPlayer.setNetworkDataSource(
          data['data']['url'],
          autoPlay: true
        );
      } else {
        // print('当前不能播放，自动下一首');
        // if (_songList.length > 1) {
        //   next(_songListIndex + 1);
        // }
      }
    } catch (e) {
      print(e);
    }
  }

  @override 
  Widget build(BuildContext context) {
    return Material(
      child: Container(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Container(
              height: 300, // 这里隐藏播放器
              child: IjkPlayer(
                mediaController: _audioPlayer,
              ),
            ),
            SafeArea(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  Container(
                    padding: EdgeInsets.only(left: 15,right: 15),
                    child: Text(
                      mvDetail == null ? '' : mvDetail.name,
                      textAlign: TextAlign.left,
                      style: TextStyle(fontSize: 16,fontWeight: FontWeight.bold),
                    ),
                  ),
                  // Container(
                  //   padding: EdgeInsets.only(left: 15,right: 15),
                  //   child: Text(
                  //     mvDetail == null ? '' : mvDetail.desc,
                  //     textAlign: TextAlign.left,
                  //     style: TextStyle(fontSize: 12,color: Colors.grey),
                  //   ),
                  // ),
                  Row(
                    children: <Widget>[

                    ],
                  ),
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}