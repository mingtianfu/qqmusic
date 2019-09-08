// import 'dart:async';

import 'package:flutter/material.dart';
import 'package:qqmusic/pages/MainPage.dart';
import 'package:qqmusic/routes.dart';
import 'package:qqmusic/pages/InheritedContext.dart';
import 'package:qqmusic/pages/InheritedTestModel.dart';

// void collectLog(String line){
//   //收集日志
//     print('收集日志:$line');
// }
// void reportErrorAndLog(FlutterErrorDetails details){
//     //上报错误和日志逻辑
//     print('上报错误和日志逻辑:$details');
// }

// FlutterErrorDetails makeDetails(Object obj, StackTrace stack){
//     // 构建错误信息
//     print('构建错误信息obj:$obj');
//     print('构建错误信息stack:$stack');
// }

// void main() {
//   FlutterError.onError = (FlutterErrorDetails details) {
//     reportErrorAndLog(details);
//   };
//   runZoned(
//     () => runApp(App()),
//     zoneSpecification: ZoneSpecification(
//       print: (Zone self, ZoneDelegate parent, Zone zone, String line) {
//         collectLog(line); // 收集日志
//       },
//     ),
//     onError: (Object obj, StackTrace stack) {
//       var details = makeDetails(obj, stack);
//       reportErrorAndLog(details);
//     },
//   );
// }

void main() => runApp(App());

class App extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return new _AppState();
  }
}

class _AppState extends State<App> {
  InheritedTestModel inheritedTestModel;

  _initData() {
    inheritedTestModel = new InheritedTestModel(0);
  }

  @override
  void initState() {
    _initData();
    super.initState();
  }

  _incrementCount() {
    setState(() {
      inheritedTestModel = new InheritedTestModel(inheritedTestModel.count + 1);
    });
  }

  _reduceCount() {
    setState(() {
      inheritedTestModel = new InheritedTestModel(inheritedTestModel.count - 1);
    });
  }
  
  @override 
  Widget build(BuildContext context) {
    return new InheritedContext(
      inheritedTestModel: inheritedTestModel,
      increment: _incrementCount,
      reduce: _reduceCount,
      child: new MaterialApp(
        theme: new ThemeData(
          primarySwatch: Colors.green,
        ),
        routes: routes,
        home: new MainPage()
      )
    );
  }
}