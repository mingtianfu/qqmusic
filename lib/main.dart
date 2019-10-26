import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:provider/provider.dart';
import 'package:qqmusic/pages/App.dart';
import 'package:qqmusic/pages/Model/PlayModel.dart';
import 'package:camera/camera.dart';

// void main() => runApp(App());

Future<void>  main() async{
  //  build阶段的调试
//  debugProfileBuildsEnabled = true;
//  //  paint阶段的调试
//  debugProfilePaintsEnabled = true;
//  debugPaintLayerBordersEnabled = true;

  List<CameraDescription> cameras;
  try {
    WidgetsFlutterBinding.ensureInitialized();
    cameras = await availableCameras();
  } on CameraException catch (e) {
    print(e);
  }

  runApp(
    Provider.value(
      child: ChangeNotifierProvider.value(
        value: PlayModel(),
        child: App(
          cameras: cameras,
        ),
      ),
    ),
  );
}

// class App extends StatelessWidget {
//   @override
//   Widget build(BuildContext context) {
//     print('app build');
//     return MaterialApp(
//       theme: ThemeData.dark(),
//       home: FirstScreen(),
//     );
//   }
// }

// class FirstScreen extends StatefulWidget {

//   @override 
//   FirstScreenState createState() => FirstScreenState();
// }

// class FirstScreenState extends State<FirstScreen> {

//   final _playModel = PlayModel();

//   @override
//   void initState() {
//     super.initState();
//     // print(_playModel.songListIndex);
//     WidgetsBinding.instance.addPostFrameCallback((callback){
//       Provider.of<PlayModel>(context).setSongListIndex(1);
//     });
//   }

//   add() {
//     WidgetsBinding.instance.addPostFrameCallback((callback){
//       Provider.of<PlayModel>(context).setSongListIndex(12);
//     });
//   }

//   @override 
//   Widget build(BuildContext context) {
//     print('FirstScreen build');
//     final _playModel = Provider.of<PlayModel>(context);

//     return Scaffold(
//       appBar: AppBar(
//         title: Text('FirstScreen'),
//       ),
//       body: Center(
//         child: Text(
//           'Value: ${_playModel.songListIndex}',
//         ),
//       ),
//       floatingActionButton: FloatingActionButton(
//         onPressed: () {
//           add();
//           // Navigator.of(context).push(
//           //   MaterialPageRoute(builder: (context) => SecondPage()),
//           // );
//         },
//         child: Icon(Icons.navigate_next),
//       ),
//     );
//   }
// }

// class SecondPage extends StatelessWidget {
//   @override 
//   Widget build(BuildContext context) {
//     print('SecondPage build');
//     return Scaffold(
//       appBar: AppBar(
//         title: Text('SecondPage'),
//       ),
//       body: Consumer<PlayModel>(
//         builder: (BuildContext context, PlayModel playModel,  _) {
//           print('SecondPage Center build');
//           return Center(
//             child: Text(
//               'Value: ${playModel.songListIndex}',
//             ),
//           );
//         },
//       ),
//       floatingActionButton: Consumer<PlayModel>(
//         builder: (BuildContext context, PlayModel playModel, child) {
//           print('SecondPage floatingActionButton build');
//           return FloatingActionButton(
//             onPressed: () {
//               playModel.setSongListIndex(2);
//             },
//             child: child,
//           );
//         },
//         child: Icon(Icons.add),
//       ),
//     );
//   }
// }