import 'package:flutter/material.dart';
import 'package:qqmusic/pages/BottomPlayBar.dart';
import 'package:qqmusic/pages/DynamicPage.dart';
import 'package:qqmusic/pages/MusichallPage.dart';
import 'package:qqmusic/pages/MyPage.dart';
import 'package:qqmusic/pages/RecommendPage.dart';
import 'package:qqmusic/utils/utils.dart';

class MainPage extends StatefulWidget {
  MainPage({Key key}): super(key: key);

  @override 
  _MainPageState createState() => new _MainPageState();
}

class _MainPageState extends State<MainPage> with SingleTickerProviderStateMixin{
  var _pageController = new PageController(initialPage: 0);
  Color _selectColor = hexToColor('#31c27c');
  Color _unselectColor = Colors.grey;
  String _recommendNum = '0';
  int _selectedIndex =  0;
  List _pageList = [
    new MusichallPage(),
    new RecommendPage(),
    new DynamicPage(),
    new MyPage(),
  ];
  List bottomTitles = ['音乐馆', '推荐', '动态', '我的'];
  List bottomImages = [
    ['assets/images/my_musichall_color_skin_selected.png', 'assets/images/my_musichall_color_skin_normal.png'], 
    ['assets/images/my_recommend_cale_color_skin_selected.png', 'assets/images/my_recommend_cale_color_skin_normal.png'], 
    ['assets/images/my_dynamic_color_skin_selected.png', 'assets/images/my_dynamic_color_skin_normal.png'], 
    ['assets/images/my_music_color_skin_selected.png', 'assets/images/my_music_color_skin_normal.png'], 
  ];

  void _onItemTapped(int index) {
    //bottomNavigationBar 和 PageView 关联
    _pageController.animateToPage(index,duration: const Duration(milliseconds: 300), curve: Curves.ease);
    // setState(() {
    //   _selectedIndex = index;
    // });
  }

  void _pageChange(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  Text getTabTitle(int index) {
    return new Text(bottomTitles[index]);
  }

  getTabIcon(int index) {
    bool isSelected = _selectedIndex == index;
    if (index == 1) {
      return Container(
        width: 28.0,
        height: 28.0,
        child: Stack(
          children: <Widget>[
            Image.asset(
              bottomImages[index][isSelected ? 0 : 1],
              width: 28.0,
              height: 28.0,
              color: isSelected ? _selectColor : _unselectColor
            ),
            Positioned(
              left: 0,
              top: 1,
              child: Container(
                width: 28.0,
                height: 28.0,
                color: Colors.transparent,
                child: Center(
                  child: Text(_recommendNum, style: TextStyle(fontSize: 10, color: isSelected ? _selectColor : _unselectColor),),
                ),
              ),
            ),
          ],
        ),
      );
    } else {
      return Image.asset(
        bottomImages[index][isSelected ? 0 : 1],
        width: 28.0,
        height: 28.0,
        color: isSelected ? _selectColor : _unselectColor
      );
    }
  }

  @override 
  void initState() {
    super.initState();
  }

  @override 
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[200],
      body: Column(
        children: <Widget>[
          Expanded(
            child: new PageView.builder(
              onPageChanged: _pageChange,
              controller: _pageController,
              itemCount: _pageList.length,
              itemBuilder: (BuildContext context, int index) {
                return _pageList.elementAt(_selectedIndex);
              },
            ),
          ),
          Hero(
            tag: "BottomPlayBar", //唯一标记，前后两个路由页Hero的tag必须相同
            child: BottomPlayBar(),
          )
        ],
      ),
      // body: _pageList.elementAt(_selectedIndex),
      bottomNavigationBar: BottomNavigationBar(
        fixedColor: _selectColor,
        backgroundColor: Colors.white,
        type: BottomNavigationBarType.fixed,
        currentIndex: _selectedIndex,
        // selectedItemColor: _selectColor,
        // unselectedItemColor: _unselectColor,
        selectedFontSize: 12.0,
        unselectedFontSize: 12.0,
        showSelectedLabels: true,
        onTap: _onItemTapped,
        items: <BottomNavigationBarItem>[
          new BottomNavigationBarItem(
            icon: getTabIcon(0),
            title: getTabTitle(0),
          ),
          new BottomNavigationBarItem(
            icon: getTabIcon(1),
            title: getTabTitle(1),
          ),
          new BottomNavigationBarItem(
            icon: getTabIcon(2),
            title: getTabTitle(2),
          ),
          new BottomNavigationBarItem(
            icon: getTabIcon(3),
            title: getTabTitle(3),
          ),
        ],
      ),
    );
  }

  @override
  void didUpdateWidget(MainPage oldWidget) {
    super.didUpdateWidget(oldWidget);
    print("didUpdateWidget");
  }

  @override
  void deactivate() {
    super.deactivate();
    print("deactive");
  }

  @override
  void dispose() {
    super.dispose();
    print("dispose");
  }

  @override
  void reassemble() {
    super.reassemble();
    print("reassemble");
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    print("didChangeDependencies");
  }
}