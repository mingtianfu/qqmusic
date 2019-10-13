import 'package:flutter/material.dart';
import 'package:flutter_ijkplayer/flutter_ijkplayer.dart';
import 'package:provider/provider.dart';
import 'package:qqmusic/component/RotateImage.dart';
import 'package:qqmusic/pages/ModalBottomSheetListPage.dart';
import 'package:qqmusic/pages/Model/PlayModel.dart';
import 'package:qqmusic/utils/hexToColor.dart';

class PlaySongBarPage extends StatelessWidget{
  PlaySongBarPage({Key key, this.audioPlayer, this.handleTap, this.animationController}): super(key: key);

  final IjkMediaController audioPlayer;
  final handleTap;
  final animationController;
  final Color _color = hexToColor('#31c27c');
  
  @override 
  Widget build(BuildContext context) {

    return Consumer<PlayModel>(
      builder: (BuildContext context, PlayModel playModel,  _) {
        return Container(
          height: 66,
          color: Colors.transparent,
          child: GestureDetector(
            onTap: playModel.songList.length > 0 ? handleTap : null,
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
                        child: Text(
                            playModel.songList.length == 0
                              ? 'QQ音乐 让生活充满音乐'
                              : '${playModel.songList[playModel.songListIndex].name}-${playModel.songList[playModel.songListIndex].ar[0].name}',
                            maxLines: 1,
                            overflow: TextOverflow.ellipsis,
                            style: TextStyle(
                              fontSize: 12,
                              color: playModel.songList.length == 0 ? Colors.grey : Colors.black,
                              fontWeight: FontWeight.normal,
                              textBaseline: TextBaseline.alphabetic,
                            ),
                          ),
                        ),
                      _buildBottomControllStream(playModel),
                      _buildList(context, playModel),
                    ],
                  ),
                ),
                Positioned(
                  left: 15,
                  top: 14,
                  child: _buildRotaeImage(playModel),
                  // ClipOval(
                  //   child: playModel.songList.length == 0 ? Image.asset('assets/images/player_album_cover_default.png', width: 45,)
                  //   : Image.network(
                  //     playModel.songList[playModel.songListIndex].al.picUrl + '?param=200y200',
                  //     width: 45,
                  //     height: 45,
                  //   ),
                  // ),
                ),
              ],
            ),
          )
        );
      }
    );
  }
  
  Widget _buildRotaeImage(playModel) {
    return StreamBuilder<VideoInfo>(
      builder: (BuildContext context, snapshot) {
        if (snapshot.hasData &&  snapshot.data.hasData && snapshot.data.isPlaying) {
          return RotaeImage(
          url: playModel.songList.length == 0 ? '' : playModel.songList[playModel.songListIndex].al.picUrl,
          size: 45.0, animationController: animationController);
        } else {
          return ClipOval(
            child: playModel.songList.length == 0 ? Image.asset('assets/images/player_album_cover_default.png', width: 45,)
            : Image.network(
              playModel.songList[playModel.songListIndex].al.picUrl + '?param=200y200',
              width: 45,
              height: 45,
            ),
          );
        }
      },
      stream: audioPlayer?.videoInfoStream,
      initialData: audioPlayer?.videoInfo,
    );
  }

  Widget _buildBottomControllStream(playModel) {
    return StreamBuilder<VideoInfo>(
      builder: (BuildContext context, snapshot) {
        if (!snapshot.hasData || !snapshot.data.hasData) {
          return Container(
            width: 40,
            height: 40,
            child: Image.asset('assets/images/minibar_btn_default_play.png'),
          );
        }
        return _buildBottomControll(snapshot.data, playModel);
      },
      stream: audioPlayer?.videoInfoStream,
      initialData: audioPlayer?.videoInfo,
    );
  }

  Widget _buildBottomControll(VideoInfo info, playModel) {
    return GestureDetector(
      onTap: () async {
        if (playModel.songList.length > 0) {
          await audioPlayer?.playOrPause();
        //   info.isPlaying
        //       ? animationController?.stop()
        //       : animationController?.forward();
        }
      },
      child: Container(
        width: 46,
        height: 46,
        padding: EdgeInsets.only(top: 2, right: 1.0),
        decoration: BoxDecoration(
          image: DecorationImage(
            image: playModel.songList.length == 0
                ? AssetImage('assets/images/minibar_btn_default_play.png')
                : AssetImage(info.isPlaying
                    ? 'assets/images/landscape_player_btn_pause_normal.png'
                    : 'assets/images/landscape_player_btn_play_normal.png'),
            fit: BoxFit.cover,
          ),
        ),
        child: Center(
          child: SizedBox(
            height: 31,
            width: 31,
            child: CircularProgressIndicator(
              backgroundColor: Colors.transparent,
              valueColor: AlwaysStoppedAnimation(_color),
              value: info.progress.isNaN ? .0 : info.progress,
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildList(context, playModel) {
    return GestureDetector(
      onTap: () async {
        if (playModel.songList.length > 0) {
          int index = await _showModalBottomSheet(context, audioPlayer);
          if (index != null) {
            if (index > -2) {
              playModel.setSongListIndex(index);
              playModel.setAutoPlay(true);
            }
          }
        }
      },
      child: Image.asset(
        playModel.songList.length == 0
            ? 'assets/images/minibar_btn_default_playlist.png'
            : 'assets/images/minibar_btn_playlist_highlight.png',
        width: 30,
        height: 30,
      )
    );
  }

  Future<int> _showModalBottomSheet(context, audioPlayer) {
    return showModalBottomSheet<int>(
      context: context,
      builder: (BuildContext context) {
        return ModalBottomSheetListPage();
      },
    );
  }

}