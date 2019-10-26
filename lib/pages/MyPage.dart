import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';
import 'package:qqmusic/component/AppBarSearch.dart';
import 'package:qqmusic/component/SpinWave.dart';
import 'package:qqmusic/component/SpinWaveFill.dart';
import 'package:qqmusic/utils/hexToColor.dart';

class MyPage extends StatefulWidget {
  @override 
  _MyPageState createState() => _MyPageState();
}

class _MyPageState extends State<MyPage> with SingleTickerProviderStateMixin{

  // AnimationController controller;
  List<String> items = ["1", "2", "3", "4", "5"];
  double percent = 0;
  bool enablePullDown = true;
  bool enablePullUp = true;

  RefreshController _refreshController = RefreshController(initialRefresh: true);

  @override
  void initState() {
    super.initState();
  }

  @override
  void dispose() {
    super.dispose();
  }

  void _onRefresh() async {
    // monitor network fetch
    await Future.delayed(Duration(milliseconds: 1000));
    // if failed,use refreshFailed()
    _refreshController.refreshCompleted();
  }

  void _onLoading() async {
    // monitor network fetch
    await Future.delayed(Duration(milliseconds: 1000));
    // if failed,use loadFailed(),if no data return,use LoadNodata()
    items.add((items.length + 1).toString());
    if (mounted)
      setState(() {
        
      });
    _refreshController.loadComplete();
  }

  void handlePresseSearch() {
    print('搜索页面');
  }

  void handleRecognize() {
    print('更多页面');
  }
  
  Widget build(BuildContext context) {
    return SafeArea(
      child: Container(
        child: Scrollbar(
          child: SingleChildScrollView (
            child: Center(
              child: Column(
                children: <Widget>[
                  AppBarSearch(
                    title: '我的', 
                    rightImage: Image.asset('assets/images/fragment_my_music_more.png', width: 30,),
                    onPressedRight: handleRecognize,
                    onPressed: handlePresseSearch,
                  ),
                  _buildLogin(),
                ],
              ),
            )
          ),
        ),
      ),
    );
  }
  
  Widget _buildLogin() {
    return Container(
      margin: EdgeInsets.only(right: 15, bottom: 10, left: 15),
      padding: EdgeInsets.only(top: 15, bottom: 10,),
      width: double.infinity,
      color: Colors.white,
      child: Column(
        children: <Widget>[
          GestureDetector(
            onTap: (){
              Navigator.of(context).pushNamed('loginPage');
            },
            child: ClipRRect( 
              borderRadius: BorderRadius.circular(50),
              child: Container(
                width: 170,
                height: 40,
                color: primaryColor,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: <Widget>[
                    Image.asset('assets/images/not_login_default_image.png', width: 18,),
                    Container(width: 10,),
                    Text('立即登录', style: TextStyle(color: Colors.white, fontSize: 16),)
                  ],
                ),
              ),
            ),
          ),
          Container(height: 10,),
          Divider(height: 20,),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: <Widget>[
              Expanded(
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    Text('活动中心')
                  ],
                ),
              ),
              Expanded(
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    Text('会员中心')
                  ],
                ),
              )
            ],
          ),
        ],
      ),
    );
  }

}
