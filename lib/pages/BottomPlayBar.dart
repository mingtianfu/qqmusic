import 'package:flutter/material.dart';
import 'package:qqmusic/component/GradientCircularProgressIndicator.dart';
import 'package:qqmusic/component/RotateImage.dart';
import 'package:qqmusic/pages/InheritedContext.dart';
import 'package:qqmusic/pages/PlaySongPage.dart';
import 'package:qqmusic/pages/SingersList.dart';
import 'package:qqmusic/utils/utils.dart';
import 'package:video_player/video_player.dart';

class BottomPlayBar extends StatefulWidget {
  @override
  _BottomPlayBarState createState() => _BottomPlayBarState();
}

class _BottomPlayBarState extends State<BottomPlayBar>  with TickerProviderStateMixin {
  AnimationController animationController;
  VideoPlayerController videoPlayController;
  final Color _color = hexToColor('#31c27c');
  bool _isPlaying = false;
  String durationText = '00:00';
  String positionText = '00:00';
  int duration = 1000;
  int position = 0;
  var pc = 0.0;
  
  @override
  void initState() {
    super.initState();

    animationController = new AnimationController(vsync: this, duration: Duration(seconds: 5))
    ..addListener(() {
      setState(() {
        
      });
    });

    videoPlayController = VideoPlayerController.network(
      'https://m10.music.126.net/20190908135811/43f0ed31cd485603d1cce8b6bc8c93a5/yyaac/0453/0253/5408/396c27493559400e89e9cb97ba01d570.m4a')
    ..initialize().then((_) {
      setState(() {
        
      });
    })
    ..addListener(() {
      final bool isPlaying = videoPlayController.value.isPlaying;
      if (videoPlayController.value.isBuffering) {
        setState(() {
          duration = videoPlayController.value.duration.inMilliseconds;
          durationText = getTimeStamp(duration);
        });
      }
      if (isPlaying != _isPlaying) {
          setState(() { 
            _isPlaying = isPlaying;
          });
      }
      if (isPlaying) {

      } else {
        animationController.stop();
      }
      setState(() {
        position = videoPlayController.value.position.inMilliseconds;
        positionText = getTimeStamp(videoPlayController.value.position.inMilliseconds);
        pc = videoPlayController.value.position.inMilliseconds/duration;
      });
    });
  }

  void play() {
    if (_isPlaying) {
      videoPlayController.pause();
      animationController.stop();
    } else {
      if (videoPlayController.value.position == videoPlayController.value.duration) {
        videoPlayController.seekTo(Duration(seconds: 0));
      }
      videoPlayController.play();
      animationController.repeat();
    }
  }

  void handleTap () {
    Navigator.push(
      context,
      new MaterialPageRoute(
        builder: (context) => new PlaySongPage(),
        fullscreenDialog: true,
      ),
    );
  }

  @override
  void dispose() {
    animationController.dispose();
    videoPlayController.dispose();
    super.dispose();
  }

  Widget build(BuildContext context) {
    // final inheritedContext = InheritedContext.of(context);
    // final inheritedTestModel = inheritedContext.inheritedTestModel;
    // print('TestWidgetA 中count的值:  ${inheritedTestModel.count}');

    return Container(
      height: 66,
      color: Colors.transparent,
      child: Stack(
        children: <Widget>[
          Container(
            color: Colors.white,
            margin: EdgeInsets.only(top: 20.0),
            padding: EdgeInsets.only(left: 70.0, right: 15.0),
            height: 46,
            child: Row(
              children: <Widget>[
                Expanded(
                  flex: 1,
                  child: GestureDetector(
                    onTap: handleTap,
                    child: Text(
                      '这个歌很好听这个歌很好听这个歌很好听这个歌很好听这个歌很好听这个歌很好听这个歌很好听这个歌很好听-知道吗',
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                      style: TextStyle(
                        fontSize: 12, color: Colors.black, fontWeight: FontWeight.normal,
                        textBaseline: TextBaseline.alphabetic,
                      ),
                    ),
                  ),
                ),
                GestureDetector(
                  onTap: play,
                  child: Container(
                    width: 46,
                    height: 46,
                    padding: EdgeInsets.only(top: 2, right: 1.0),
                    decoration: BoxDecoration(
                      image: DecorationImage(
                        image: AssetImage('assets/images/landscape_player_btn_play_normal.png'),
                        fit: BoxFit.cover,
                      ),
                    ),
                    child: Center(
                      child: GradientCircularProgressIndicator(
                        colors: [_color, _color],
                        radius: 16.0,
                        strokeWidth: 2.0,
                        backgroundColor: Colors.transparent,
                        value: pc,
                      ),
                    ),
                  ),
                ),
                GestureDetector(
                  onTap: () {
                    // );
                    // Navigator.pushNamed(context, 'singersList');
                    Navigator.push(context, PageRouteBuilder(
                      pageBuilder: (BuildContext context, Animation animation,
                          Animation secondaryAnimation) {
                        return new FadeTransition(
                          opacity: animation,
                          child: Scaffold(
                            appBar: AppBar(
                              title: Text("原图"),
                            ),
                            body: SingersList(),
                          ),
                        );
                      })
                    );
                  },
                  child: new Image(
                    height: 30,
                    width: 30,
                    image: AssetImage('assets/images/minibar_btn_playlist_highlight.png'),
                  ),
                ),
              ],
            ),
          ),
          Positioned(
            left: 15,
            top: 14,
            child: GestureDetector(
              onTap: handleTap,
              child: RotaeImage(size: 45.0, controller: animationController,),
            ),
          ),
        ],
      ),
    );
  }
}