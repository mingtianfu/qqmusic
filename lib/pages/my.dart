import 'package:flutter/material.dart';
import 'package:qqmusic/component/box.dart';

Future<String> mockNetworkData() async {
  return Future.delayed(Duration(seconds: 2), () => "我是从互联网上获取的数据");
}

class My extends StatefulWidget {
  My({
    Key key,
    @required this.text,
  }): super(key: key);

  final String text;

  @override 
  _TapState createState() => new _TapState();
}

class _TapState extends State<My> {
  bool _active = false;
  DateTime _lastPressAt;
  Color _themeColor = Colors.teal;

  void _handleTap() {
    setState(() {
      _active = !_active;
    });
  }

  void _handleTabBoxChanged(bool value) {
    setState(() {
      _active = value;
    });
  }

  Widget build(BuildContext context) {
    ThemeData themeData = Theme.of(context);
    return new Theme(
      data: ThemeData(primarySwatch: _themeColor, iconTheme: IconThemeData(color: _themeColor)),
      child: new WillPopScope(
        onWillPop: () async {
          if (_lastPressAt == null ||
            DateTime.now().difference(_lastPressAt) > Duration(seconds: 1)) {
            _lastPressAt = DateTime.now();
            return false;
          } else {
            return true;
          }
        },
        child: new Scaffold(
          appBar: new AppBar(
            title: new Text('My')
          ),
          body: new Center(
            child: new Column(
              children: <Widget>[
                new GestureDetector(
                  onTap: _handleTap,
                  child: new Container(
                    width: 200,
                    height: 200,
                    decoration: new BoxDecoration(
                      color: _active ? Colors.lightGreen[700] : Colors.grey[600],
                    ),
                    child: new Text(
                      widget.text,
                      style: new TextStyle(
                        fontSize: 30,
                        color: Colors.white
                      )
                    ),
                  ),
                ),
                new Box(
                  active: _active,
                  onChanged: _handleTabBoxChanged,
                ),
                //第一行Icon使用主题中的iconTheme
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    Icon(Icons.favorite),
                    Icon(Icons.airport_shuttle),
                    Text("  颜色跟随主题")
                  ]
                ),
                Theme(
                  data: themeData.copyWith(
                    iconTheme: themeData.iconTheme.copyWith(
                        color: Colors.black
                    ),
                  ),
                  child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: <Widget>[
                        Icon(Icons.favorite),
                        Icon(Icons.airport_shuttle),
                        Text("  颜色固定黑色")
                      ]
                  ),
                ),
                Center(
                  child: FutureBuilder<String>(
                    future: mockNetworkData(),
                    builder: (BuildContext context, AsyncSnapshot snapshot) {
                      // 请求已结束
                      if (snapshot.connectionState == ConnectionState.done) {
                        if (snapshot.hasError) {
                          // 请求失败，显示错误
                          return Text("Error: ${snapshot.error}");
                        } else {
                          // 请求成功，显示数据
                          return Text("Contents: ${snapshot.data}");
                        }
                      } else {
                        // 请求未结束，显示loading
                        return CircularProgressIndicator();
                      }
                    },
                  ),
                ),
              ],
            ),
          ),
          floatingActionButton: FloatingActionButton(
            onPressed: () =>  //切换主题
                setState(() =>
                _themeColor =
                _themeColor == Colors.teal ? Colors.blue : Colors.teal
                ),
              child: Icon(Icons.palette)
          ),
        ),
      ),
    );
  }
}