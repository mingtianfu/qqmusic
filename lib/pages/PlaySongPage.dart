import 'package:flutter/material.dart';
import 'package:qqmusic/component/RotateImage.dart';
import 'package:qqmusic/pages/ImageButton.dart';
import 'package:qqmusic/utils/utils.dart';
import 'package:video_player/video_player.dart';
import 'package:qqmusic/pages/InheritedContext.dart';

class PlaySongPage extends StatefulWidget {
  @override 
  _PlaySongPageState createState() => _PlaySongPageState();
}

class _PlaySongPageState extends State<PlaySongPage> with TickerProviderStateMixin {
  Color _backgroundColor = Color.fromRGBO(49, 193, 124, 1);

  AnimationController animationController;
  VideoPlayerController videoPlayController;
  ScrollController scrollController = new ScrollController();

  final Color _color = hexToColor('#31c27c');
  bool _isPlaying = false;
  String durationText = '00:00';
  String positionText = '00:00';
  int duration = 1000;
  int position = 0;
  var pc = 0.0;

  var _pageController = new PageController(initialPage: 0);
  int _selectedIndex =  2;
  
  @override
  void initState() {
    super.initState();
    
    animationController = new AnimationController(vsync: this, duration: Duration(seconds: 5))
    ..addListener(() {
      setState(() {
      });
    });

    videoPlayController = VideoPlayerController.network(
      'https://qiubai-video-web.qiushibaike.com/R7E2UWZRCFRGVNAG_hd.mp4'
    )..initialize().then((_) {
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
        //监听滚动事件，打印滚动位置
    scrollController.addListener(() {
      print(scrollController.offset); //打印滚动位置
      // if (scrollController.offset < 1000 && showToTopBtn) {
      //   setState(() {
      //     showToTopBtn = false;
      //   });
      // } else if (scrollController.offset >= 1000 && showToTopBtn == false) {
      //   setState(() {
      //     showToTopBtn = true;
      //   });
      // }
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

  @override
  void dispose() {
    animationController.dispose();
    videoPlayController.dispose();
    super.dispose();
  }

  void handleBack () {
    Navigator.pop(context);
  }

  @override
  Widget build(BuildContext context) {
    
    // final inheritedContext = InheritedContext.of(context);
    // final inheritedTestModel = inheritedContext.inheritedTestModel;
    // print('TestWidgetA 中count的值:  ${inheritedTestModel.count}');
    return Scaffold(
      backgroundColor: _backgroundColor,
      body: Container(
          padding: EdgeInsets.only(bottom: 10),
          decoration: BoxDecoration(
            image: DecorationImage(
              image: AssetImage('assets/images/player_background_real.png'),
              fit: BoxFit.cover,
            ),
          ),
          child: SafeArea(
            child: Column(
              children: <Widget>[
                appbar(),
                singer(),
                tags(),
                Expanded(
                  flex: 1,
                  child: swiper(),
                ),
                indicator(),
                timeSlider(),
                controllers(),
                bottomButtons(),
              ],
            ),
          ),
        ),
    );
  }

  // 导航
  Widget appbar () {
    return Container(
      height: 46,
      padding: EdgeInsets.only(right: 15.0,),
      child: Row(
        children: <Widget>[
          ImageButton(
            height: 46,
            onTap: handleBack,
            assetImage: AssetImage('assets/images/player_btn_close_normal.png'),
          ),
          Expanded(
            child: Padding(
              padding: EdgeInsets.only(right: 15.0),
              child: Text(
                _selectedIndex.toString(),
                textAlign: TextAlign.center,
                maxLines: 1,
                overflow: TextOverflow.ellipsis,
                style: TextStyle(color: Colors.white, fontSize: 16.0),
              ),
            ),
          ),
          ImageButton(
            width: 20,
            height: 20,
            onTap: handleBack,
            assetImage: AssetImage('assets/images/maintabbar_button_more_normal_white.png'),
          ),
        ],
      ),
    );
  }

  // 作者
  Widget singer () {
    return Container(
      height: 20,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          Container(
            margin: EdgeInsets.only(left: 4.0, right: 4.0),
            child: ImageButton(
              height: 20,
              onTap: handleBack,
              assetImage: AssetImage('assets/images/abc_scrubber_track_mtrl_alpha.9.png'),
            )
          ),
          Container(
            margin: EdgeInsets.only(left: 4.0, right: 4.0),
            child: Text(
              '欧阳娜娜',
              textAlign: TextAlign.center,
              maxLines: 1,
              overflow: TextOverflow.ellipsis,
              style: TextStyle(color: Colors.white, fontSize: 12.0),
            )
          ),
          Container(
            margin: EdgeInsets.only(left: 4.0, right: 4.0),
            child: ImageButton(
              height: 20,
              onTap: handleBack,
              assetImage: AssetImage('assets/images/abc_scrubber_track_mtrl_alpha.9.png'),
            )
          ),
        ],
      ),
    );
  }

  // tags
  Widget tags() {
    return Container(
      height: 60,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          Container(
            margin: EdgeInsets.only(left: 4.0, right: 4.0),
            child: ImageButton(
              height: 20,
              onTap: handleBack,
              assetImage: AssetImage('assets/images/player_btn_bz_hlight.png'),
            )
          ),
          Container(
            margin: EdgeInsets.only(left: 4.0, right: 4.0),
            child: ImageButton(
              height: 20,
              onTap: handleBack,
              assetImage: AssetImage('assets/images/player_btn_dts_off.png'),
            )
          ),
          Container(
            margin: EdgeInsets.only(left: 4.0, right: 4.0),
            child: ImageButton(
              height: 20,
              onTap: handleBack,
              assetImage: AssetImage('assets/images/player_btn_hq_hlight.png'),
            )
          ),
        ],
      ),
    );
  }

  Widget swipers1() {
    return Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            RotaeImage(size: 280.0, controller: animationController,),
            Padding(
              padding: EdgeInsets.only(top: 40.0, right: 40.0, left: 40.0),
              child: Text(
                '欧阳娜娜欧阳娜娜欧阳娜娜欧阳娜娜欧阳娜娜欧阳娜娜欧阳娜娜欧阳娜娜欧阳娜娜欧阳娜娜欧阳娜娜',
                textAlign: TextAlign.center,
                maxLines: 1,
                overflow: TextOverflow.ellipsis,
                style: TextStyle(color: Colors.white, fontSize: 10.0),
              )
            ),
          ],

    );
  }

  Widget swipers2() {
    return Scrollbar(
      child: Row(
        children: <Widget>[
          Text('data'),
          Expanded(
            child: ListView.builder(
              itemCount: 100,
              itemExtent: 24.0, //列表项高度固定时，显式指定高度是一个好习惯(性能消耗小)
              controller: scrollController,
              itemBuilder: (context, index) {
                return ListTile(
                  title: Text('00000$index', textAlign: TextAlign.center,style: TextStyle(color: Colors.white, fontSize: 12.0),),
                );
              }
            ),
          ),
          Text('data')
        ],
      ),
    );
  }

  Widget swipers0() {
    return Text('0');
  }

  // swiper
  Widget swiper() {
    return PageView.builder(
      onPageChanged: (int index) {
        setState(() {
          _selectedIndex = index;
        });
      },
      controller: _pageController,
      itemCount: 3,
      itemBuilder: (BuildContext context, int index) {
        if (_selectedIndex == 0) {
          return swipers0();
        } else if (_selectedIndex == 1) {
          return swipers1();
        } else {
          return swipers2();
        }
      },
    );
  }

  // indicator
  Widget indicator() {
    return Container(
      width: 40,
      height: 40,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: <Widget>[
          ClipOval(child: Container(width: 5, height: 5, color: _selectedIndex == 0 ? Colors.white : Colors.white30,)),
          ClipOval(child: Container(width: 5, height: 5, color: _selectedIndex == 1 ? Colors.white : Colors.white30,)),
          ClipOval(child: Container(width: 5, height: 5, color: _selectedIndex == 2 ? Colors.white : Colors.white30,)),
        ],
      ),
    );
  }

  // timeSlider
  Widget timeSlider() {
    return Container(
      height: 60,
      padding: EdgeInsets.only(left: 15.0, right: 15.0),
      child: Flex(
        direction: Axis.horizontal,
        children: <Widget>[
          Text(positionText, style: TextStyle(color: Colors.white, fontSize: 12)),
          Expanded(
            flex: 1,
            child: Slider(
              value: position.toDouble(),
              min: 0.0,
              activeColor: Colors.white,
              inactiveColor: Colors.white30,
              max: duration.toDouble(),
              onChangeStart: (value) {
                setState(() {
                  // isUserTracking = true;
                  // trackingPosition = value;
                  position = value.toInt();
                });
              },
              onChanged: (value) {
                setState(() {
                  // trackingPosition = value;
                  position = value.toInt();
                  videoPlayController.seekTo(Duration(seconds: (value/1000).round()));
                  // videoPlayController.play();
                });
              },
              onChangeEnd: (value) async {
                // isUserTracking = false;
                // quiet.seekTo(value.round());
                // if (!quiet.value.playWhenReady) {
                //   quiet.play();
                // }
              },
            ),
          ),
          Text(durationText, style: TextStyle(color: Colors.white, fontSize: 12))
        ],
      ),
    );
  }

  // controllers
  Widget controllers() {
    return Container(
      height: 60,
      padding: EdgeInsets.only(left: 15.0, right: 15.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: <Widget>[
          ImageButton(
            width: 50,
            height: 50,
            onTap: handleBack,
            assetImage: AssetImage('assets/images/player_btn_repeat_highlight.png'),
          ),
          Expanded(
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                ImageButton(
                  width: 50,
                  height: 50,
                  onTap: handleBack,
                  assetImage: AssetImage('assets/images/lyric_play_pervious_click.png'),
                ),
                Container(
                  padding: EdgeInsets.only(left: 20.0, right: 20.0),
                  child: ImageButton(
                    width: 60,
                    height: 60,
                    onTap: play,
                    assetImage: AssetImage('assets/images/lyric_play_button_two_press.png'),
                  ),
                ),
                ImageButton(
                  width: 50,
                  height: 50,
                  onTap: handleBack,
                  assetImage: AssetImage('assets/images/lyric_play_next_click.png'),
                ),
              ],
            ),
          ),
          ImageButton(
            width: 50,
            height: 50,
            onTap: handleBack,
            assetImage: AssetImage('assets/images/player_btn_playlist_highlight.png'),
          ),
        ],
      ),
    );
  }
  
  // bottomButtons
  Widget bottomButtons() {
    return Container(
      height: 50,
      padding: EdgeInsets.only(left: 30.0, right: 30.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: <Widget>[
          ImageButton(
            width: 50,
            height: 50,
            onTap: handleBack,
            assetImage: AssetImage('assets/images/player_btn_favorite_highlight.png'),
          ),
          ImageButton(
            width: 50,
            height: 50,
            onTap: handleBack,
            assetImage: AssetImage('assets/images/player_btn_download_highlight.png'),
          ),
          ImageButton(
            width: 50,
            height: 50,
            onTap: handleBack,
            assetImage: AssetImage('assets/images/player_btn_share_normal.png'),
          ),
          Container(
            width: 50,
            height: 50,
            child: Stack(
              children: <Widget>[
                ImageButton(
                  width: 50,
                  height: 50,
                  onTap: handleBack,
                  assetImage: AssetImage('assets/images/player_btn_comment_short.png'),
                ),
                Positioned(
                  width: 28,
                  height: 8,
                  top: 11,
                  left: 18,
                  child: Text(
                    '99',
                    textAlign: TextAlign.center,
                    style: TextStyle(fontSize: 7, color: Colors.white),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}