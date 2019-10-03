import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:qqmusic/pages/Model/PlayModel.dart';
import 'package:qqmusic/utils/hexToColor.dart';

class ModalBottomSheetListPage extends StatelessWidget {
  final Color _color = hexToColor('#31c27c');
  
  @override 
  Widget build(BuildContext context) {
    return Consumer<PlayModel>(
      builder: (BuildContext context, PlayModel playModel, _) {
        return Container(
          padding: EdgeInsets.only(bottom: MediaQuery.of(context).padding.bottom),
          child: Column(
            children: <Widget>[
              _fixedBuild(context, playModel),
              Expanded(
                child: _listBuild(playModel),
              ),
              GestureDetector(
                onTap: () => Navigator.of(context).pop(),
                child: Container(
                  width: double.infinity,
                  alignment: Alignment.center,
                  height: 45,
                  color: Colors.white,
                  child: Text(
                    '关闭',
                    textAlign: TextAlign.center,
                  ),
                ),
              ),
            ],
          ),
        );
      },
    );
  }


  // 固定栏
  Widget _fixedBuild(context, playModel) {
    return Container(
      padding: EdgeInsets.only(left: 10, right: 15),
      height: 50,
      child: GestureDetector(
        onTap: () {
          // Navigator.of(context).pop();
        },
        child: Row(
          children: <Widget>[
            Container(
              // padding: EdgeInsets.only(right: 10),
              width: 40,
              // color: Colors.black12,
              child: Image.asset(
                'assets/images/play_mode_normal.png',
              ),
            ),
            Expanded(
              child: Text(
                '随机播放(${playModel.songList.length})',
              ),
            ),
            GestureDetector(
              onTap: () {
                print('ddd');
              },
              child: Container(
                child: Image.asset(
                  'assets/images/playlist_icon_download.png',
                  width: 40,
                ),
              ),
            ),
            GestureDetector(
              onTap: () {
                print('ddd');
              },
              child: Container(
                child: Image.asset(
                  'assets/images/playlist_icon_add_to.png',
                  width: 40,
                ),
              ),
            ),
            GestureDetector(
              onTap: () async {
                //弹出对话框并等待其关闭
                bool delete = await showAlertDialog(context);
                if (delete != null) {
                  // ... 执行删除操作
                  playModel.reduceSongList();
                  playModel.setSongListIndex(-1);
                  Navigator.of(context).pop(-2);
                }
              },
              child: Container(
                child: Image.asset(
                  'assets/images/playlist_icon_garbage.png',
                  width: 40,
                ),
              ),
            )
          ],
        ),
      ),
    );
  }

  Widget _listBuild(playModel) {
    return ListView.separated(
      itemCount: playModel.songList.length,
      separatorBuilder: (context, index) => Divider(height: .0),
      itemBuilder: (BuildContext context, int index) {
        return Container(
          height: 40,
          color: Colors.white,
          padding: EdgeInsets.only(
            left: 15,
            right: 15,
          ),
          child: GestureDetector(
            onTap: () {
              Navigator.of(context).pop(index);
            },
            child: Row(
              children: <Widget>[
                Expanded(
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: <Widget>[
                      ConstrainedBox(
                        constraints: BoxConstraints(
                          maxWidth: MediaQuery.of(context).size.width / 2,
                        ),
                        child: new Text(
                          playModel.songList[index].name,
                          maxLines: 1,
                          overflow: TextOverflow.ellipsis,
                          style: TextStyle(
                              color:
                                  playModel.songListIndex == index ? _color : Colors.black),
                        ),
                      ),
                      Expanded(
                        child: new Text(
                          ' - ${playModel.songList[index].ar[0].name}',
                          maxLines: 1,
                          overflow: TextOverflow.ellipsis,
                          style: TextStyle(
                              fontSize: 12,
                              color:
                                  playModel.songListIndex == index ? _color : Colors.grey),
                        ),
                      ),
                    ],
                  ),
                ),
                GestureDetector(
                  onTap: () {
                    print('ddd');
                  },
                  child: Container(
                    child: Image.asset(
                      'assets/images/playlist_icon_paper_clip.png',
                      width: 40,
                    ),
                  ),
                ),
                GestureDetector(
                  onTap: () {
                    print('ddd');
                  },
                  child: Container(
                    child: Image.asset(
                      'assets/images/playlist_icon_delete.png',
                      width: 40,
                    ),
                  ),
                )
              ],
            ),
          ),
        );
      },
    );
  }

  Future<bool> showAlertDialog(context) {
    return showDialog<bool>(
        context: context,
        builder: (context) {
          return AlertDialog(
            title: Text("提示"),
            content: Text("确定清空所有歌曲?"),
            actions: <Widget>[
              FlatButton(
                child: Text("取消"),
                onPressed: () => Navigator.of(context).pop(), //关闭对话框
              ),
              FlatButton(
                child: Text("确定"),
                onPressed: () {
                  Navigator.of(context).pop(true); //关闭对话框
                },
              ),
            ],
          );
        });
  }
}