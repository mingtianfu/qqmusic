import 'dart:async';
import 'dart:convert';
import 'dart:ui';
import 'dart:ui' as ui;

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:qqmusic/component/ImageButton.dart';
import 'package:qqmusic/component/RotateImage.dart';
import 'package:qqmusic/component/Toast.dart';
import 'package:qqmusic/pages/LyricPage.dart';
import 'package:qqmusic/pages/ModalBottomSheetListPage.dart';
import 'package:qqmusic/pages/Model/PlayModel.dart';
import 'package:qqmusic/utils/utils.dart';
import 'package:flutter_ijkplayer/flutter_ijkplayer.dart';

class PlaySongPage extends StatefulWidget {
  PlaySongPage({Key key, this.audioPlayer}): super(key: key);
  final IjkMediaController audioPlayer;
  @override
  _PlaySongPageState createState() => _PlaySongPageState();
}

class _PlaySongPageState extends State<PlaySongPage>
    with TickerProviderStateMixin, AutomaticKeepAliveClientMixin {
  @override
  bool get wantKeepAlive => true;

  AnimationController animationController;
  ScrollController scrollController = new ScrollController();
  PageController _pageController = new PageController(initialPage: 0);

  // Color _backgroundColor = Color.fromRGBO(49, 193, 124, 1);
  final Color _color = hexToColor('#31c27c');
  int _selectedIndex = 2;


  @override
  void initState() {
    super.initState();

    animationController =
        new AnimationController(vsync: this, duration: Duration(seconds: 10))
          ..addListener(() {
            setState(() {});
          })
          ..addStatusListener((status) {
            if (status == AnimationStatus.completed) {
              //动画从 controller.forward() 正向执行 结束时会回调此方法
              //重置起点
              animationController.reset();
              //开启
              animationController.forward();
            }
          });
    print("PlaySongPage initState");
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
  }

  @override
  void didUpdateWidget(PlaySongPage oldWidget) {
    super.didUpdateWidget(oldWidget);
    print("PlaySongPage didUpdateWidget");
  }

  @override
  void deactivate() {
    print("PlaySongPage deactivate");
    super.deactivate();
  }

  @override
  void dispose() async {
    animationController.dispose();
    super.dispose();
    print('PlaySongPage dispose');
  }

  void handleBack() {
    Navigator.of(context).pop();
  }

  @override
  Widget build(BuildContext context) {
    super.build(context);
    // print('PlaySongPage:-build- ${new DateTime.now()}');
    return Scaffold(
      body: buildPlay(),
    );
  }

  // play页面
  Widget buildPlay() {
    return Container(
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
            // singer(inheritedTestModel),
            // tags(),
            swiper(),
            // indicator(),
            buildVideoInfoControll(),
            bottomButtons(),
          ],
        ),
      ),
    );
  }

  // 导航
  Widget appbar() {
    return Consumer<PlayModel>(
      builder: (BuildContext context, PlayModel playModel, _) {
        return Container(
          height: MediaQuery.of(context).padding.top+40,
          padding: EdgeInsets.only(
            right: 15.0,
          ),
          child: Row(
            children: <Widget>[
              ImageButton(
                height: 40,
                onTap: () {
                  Navigator.of(context).pop();
                },
                assetImage: AssetImage('assets/images/player_btn_close_normal.png'),
              ),
              Expanded(
                child: Padding(
                    padding: EdgeInsets.only(right: 15.0),
                    child: StreamBuilder<VideoInfo>(
                      builder: (BuildContext context, snapshot) {
                        if (!snapshot.hasData || !snapshot.data.hasData) {
                          return Center(
                            child: Text('加载中...',
                                style: TextStyle(color: Colors.white)),
                          );
                        }
                        return Text(
                          playModel.songList.length == 0
                            ? ''
                            : '${playModel.songList[playModel.songListIndex].name}',
                          textAlign: TextAlign.center,
                          maxLines: 1,
                          overflow: TextOverflow.ellipsis,
                          style: TextStyle(color: Colors.white, fontSize: 16.0),
                        );
                      },
                      stream: widget.audioPlayer?.videoInfoStream,
                      initialData: widget.audioPlayer?.videoInfo,
                    )),
              ),
              ImageButton(
                width: 20,
                height: 20,
                onTap: handleBack,
                assetImage: AssetImage(
                    'assets/images/maintabbar_button_more_normal_white.png'),
              ),
            ],
          ),
        );
      }
    );
  }

  // 作者
  Widget singer(inheritedTestModel) {
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
                assetImage: AssetImage(
                    'assets/images/abc_scrubber_track_mtrl_alpha.9.png'),
              )),
          Container(
            margin: EdgeInsets.only(left: 4.0, right: 4.0),
            child: StreamBuilder<VideoInfo>(
              builder: (BuildContext context, snapshot) {
                if (!snapshot.hasData || !snapshot.data.hasData) {
                  return Center(
                    child:
                        Text('加载中...', style: TextStyle(color: Colors.white)),
                  );
                }
                return Text(
                  inheritedTestModel.songList.length == 0
                      ? ''
                      : '${inheritedTestModel.songList[inheritedTestModel.songListIndex].ar[0].name}',
                  textAlign: TextAlign.center,
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                  style: TextStyle(color: Colors.white, fontSize: 12.0),
                );
              },
              stream: widget.audioPlayer?.videoInfoStream,
              initialData: widget.audioPlayer?.videoInfo,
            ),
          ),
          Container(
              margin: EdgeInsets.only(left: 4.0, right: 4.0),
              child: ImageButton(
                height: 20,
                onTap: handleBack,
                assetImage: AssetImage(
                    'assets/images/abc_scrubber_track_mtrl_alpha.9.png'),
              )),
        ],
      ),
    );
  }

  // tags
  Widget tags() {
    return Container(
      height: 40,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          Container(
              margin: EdgeInsets.only(left: 4.0, right: 4.0),
              child: ImageButton(
                height: 15,
                onTap: handleBack,
                assetImage:
                    AssetImage('assets/images/player_btn_bz_hlight.png'),
              )),
          Container(
              margin: EdgeInsets.only(left: 4.0, right: 4.0),
              child: ImageButton(
                height: 15,
                onTap: handleBack,
                assetImage: AssetImage('assets/images/player_btn_dts_off.png'),
              )),
          Container(
              margin: EdgeInsets.only(left: 4.0, right: 4.0),
              child: ImageButton(
                height: 15,
                onTap: handleBack,
                assetImage:
                    AssetImage('assets/images/player_btn_hq_hlight.png'),
              )),
        ],
      ),
    );
  }

  // swiper
  Widget swiper() {
    return Consumer<PlayModel>(
      builder: (BuildContext context, PlayModel playModel, _) {
        return Expanded(
          flex: 1,
          child: playModel.songList.length == 0 
          ? Text('暂无歌词')
          : Center(
            child: swiperLyric(playModel),
          ),
          // child: PageView.builder(
          //   onPageChanged: (int index) {
          //     setState(() {
          //       _selectedIndex = index;
          //     });
          //   },
          //   controller: _pageController,
          //   itemCount: 3,
          //   itemBuilder: (BuildContext context, int index) {
          //     if (_selectedIndex == 0) {
          //       return swipers0();
          //     } else if (_selectedIndex == 1) {
          //       return swipers1();
          //     } else {
          //       return swiperLyric();
          //     }
          //   },
          // ),
        );
    });
  }

  // Widget swipers0() {
  //   return Text('0');
  // }

  // Widget swipers1() {
  //   return Column(
  //     mainAxisAlignment: MainAxisAlignment.center,
  //     children: <Widget>[
  //       RotaeImage(
  //         url: songList.length == 0 ? '' : songList[activeIndex].al.picUrl,
  //         size: 280,
  //         controller: animationController,
  //       ),
  //       Padding(
  //           padding: EdgeInsets.only(top: 40.0, right: 40.0, left: 40.0),
  //           child: Text(
  //             '欧阳',
  //             // '欧阳${ScreenUtil.getInstance().setWidth(ScreenUtil.screenHeight-644)}',
  //             // ScreenUtil.screenWidth.toString(),
  //             textAlign: TextAlign.center,
  //             maxLines: 1,
  //             overflow: TextOverflow.ellipsis,
  //             style: TextStyle(color: Colors.white, fontSize: 12),
  //           )),
  //     ],
  //   );
  // }

  Widget swiperLyric(playModel) {
    return StreamBuilder<VideoInfo>(
      builder: (BuildContext context, snapshot) {
        if (!snapshot.hasData || !snapshot.data.hasData) {
          return Center(
            child: Text('歌词加载中...', style: TextStyle(color: Colors.white)),
          );
        }
        return buildLyric(snapshot.data, playModel);
      },
      stream: widget.audioPlayer?.videoInfoStream,
      initialData: widget.audioPlayer?.videoInfo,
    );
  }

  Widget buildLyric(VideoInfo info, playModel) {
    TextStyle style = Theme.of(context).textTheme.body1.copyWith(height: 2.0, fontSize: 12, color: Colors.white);
    final normalStyle = style.copyWith(color: style.color.withOpacity(0.7));
    return  (playModel.lyric == null || playModel.lyric.size == 0)
      ? Text('无歌词', textAlign: TextAlign.center, style: TextStyle(color: Colors.white))
      : LayoutBuilder(builder: (context, constraints) {
      //歌词顶部与尾部半透明显示
      return ShaderMask(
        shaderCallback: (rect) {
          return ui.Gradient.linear(Offset(rect.width / 2, 0), Offset(rect.width / 2, constraints.maxHeight), [
            const Color(0x00FFFFFF),
            style.color,
            style.color,
            const Color(0x00FFFFFF),
          ], [
            0.0,
            0.15,
            0.85,
            1
          ]);
        },
        child: Container(
          constraints: BoxConstraints(minWidth: 300, minHeight: 120),
          child: LyricPage(
            lyric: playModel.lyric,
            lyricLineStyle: normalStyle,
            highlight: style.color,
            position: Duration(seconds: info.currentPosition.toInt()).inMilliseconds,
            onTap: (position) {
              widget.audioPlayer?.seekTo(double.parse(stamp2int(position).toString()));
            },
            size: Size(constraints.maxWidth-60, constraints.maxHeight == double.infinity ? 0 : constraints.maxHeight),
            playing: info.isPlaying,
          ),
        ),
      );
    });
  }

  // indicator
  Widget indicator() {
    return Container(
      width: 30,
      height: 30,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: <Widget>[
          ClipOval(
              child: Container(
            width: 5,
            height: 5,
            color: _selectedIndex == 0 ? Colors.white : Colors.white30,
          )),
          ClipOval(
              child: Container(
            width: 5,
            height: 5,
            color: _selectedIndex == 1 ? Colors.white : Colors.white30,
          )),
          ClipOval(
              child: Container(
            width: 5,
            height: 5,
            color: _selectedIndex == 2 ? Colors.white : Colors.white30,
          )),
        ],
      ),
    );
  }

  Widget buildVideoInfoControll() {
    return StreamBuilder<VideoInfo>(
      builder: (BuildContext context, snapshot) {
        if (!snapshot.hasData || !snapshot.data.hasData) {
          return Center(
            child: Text('加载中...', style: TextStyle(color: Colors.white)),
          );
        }
        return buildInfo(snapshot.data);
      },
      stream: widget.audioPlayer?.videoInfoStream,
      initialData: widget.audioPlayer?.videoInfo,
    );
  }

  Widget buildInfo(VideoInfo info) {
    return Column(
      children: <Widget>[
        timeSlider(info),
        Consumer<PlayModel>(
          builder: (BuildContext context, PlayModel playModel,  _) {
            return controllers(info, playModel);
          },
        ),
      ],
    );
  }

  // timeSlider
  Widget timeSlider(VideoInfo info) {
    return Container(
      height: 60,
      padding: EdgeInsets.only(left: 15.0, right: 15.0),
      child: Flex(
        direction: Axis.horizontal,
        children: <Widget>[
          Text(getTimeStamps(info.currentPosition),
              style: TextStyle(color: Colors.white, fontSize: 12)),
          Expanded(
            flex: 1,
            child: Slider(
              value: info.progress.isNaN ? .0 : info.progress,
              min: .0,
              max: 1.0,
              activeColor: Colors.white,
              inactiveColor: Colors.white30,
              onChanged: (value) {
                widget.audioPlayer?.seekToProgress(value);
              },
              onChangeEnd: (value) {
                // _audioPlayer.seekToProgress(value);
              },
            ),
          ),
          Text(getTimeStamps(info.duration),
              style: TextStyle(color: Colors.white, fontSize: 12))
        ],
      ),
    );
  }

  // controllers
  Widget controllers(VideoInfo info, playModel) {
    return Container(
      height: 60,
      padding: EdgeInsets.only(left: 15.0, right: 15.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: <Widget>[
          ImageButton(
            width: 50,
            height: 100,
            onTap: handleBack,
            assetImage:
                AssetImage('assets/images/player_btn_repeat_highlight.png'),
          ),
          Expanded(
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                ImageButton(
                  width: 50,
                  height: 50,
                  onTap: () => playModel.setSongListIndex(playModel.songListIndex - 1),
                  assetImage:
                      AssetImage('assets/images/lyric_play_pervious_click.png'),
                ),
                Container(
                  padding: EdgeInsets.only(left: 20.0, right: 20.0),
                  child: ImageButton(
                    width: 60,
                    height: 60,
                    onTap: () async {
                      if (playModel.songList.length > 0) {
                        await widget.audioPlayer?.playOrPause();
                        // info.isPlaying
                        //     ? animationController?.stop()
                        //     : animationController?.forward();
                      }
                    },
                    assetImage: AssetImage(info.isPlaying
                        ? 'assets/images/lyric_pausebutton_hover.png'
                        : 'assets/images/lyric_play_button_two_press.png'),
                  ),
                ),
                ImageButton(
                  width: 50,
                  height: 50,
                  onTap: () => playModel.setSongListIndex(playModel.songListIndex + 1),
                  assetImage:
                      AssetImage('assets/images/lyric_play_next_click.png'),
                ),
              ],
            ),
          ),
          ImageButton(
            width: 50,
            height: 50,
            onTap: () async {
              int index = await _showModalBottomSheet();
              print(index);
              if (index != null) {
                if (index == -2) {
                  Navigator.of(context).pop();
                } else {
                  playModel.setSongListIndex(index);
                }
              }
            },
            assetImage:
                AssetImage('assets/images/player_btn_playlist_highlight.png'),
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
            assetImage:
                AssetImage('assets/images/player_btn_favorite_highlight.png'),
          ),
          ImageButton(
            width: 50,
            height: 50,
            onTap: handleBack,
            assetImage:
                AssetImage('assets/images/player_btn_download_highlight.png'),
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
                  assetImage:
                      AssetImage('assets/images/player_btn_comment_short.png'),
                ),
                Positioned(
                  width: 28,
                  height: 8,
                  top: 11,
                  left: 20,
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

  Future<int> _showModalBottomSheet() {
    return showModalBottomSheet<int>(
      context: context,
      builder: (BuildContext context) {
        return ModalBottomSheetListPage();
      },
    );
  }

}
