import 'dart:io';

import 'dart:async';
import 'package:flutter/material.dart';
import 'package:camera/camera.dart';
import 'package:path/path.dart' show join;
import 'package:path_provider/path_provider.dart';

const IMAGE_SRC =
    'http://imglf3.nosdn.127.net/img/Mm9KQTVTN2NLSmxOdXp0Q3pRMTYycm1IakVPcERLOTNPVjRTcEJrZ2M5ZUpuMk1WMXJGNEhBPT0.jpg';


class CameraPage extends StatefulWidget {
  final List<CameraDescription> cameras;
 
  const CameraPage({
    Key key,
    @required this.cameras,
  }) : super(key: key);
  @override
  _CameraAppState createState() => _CameraAppState();
}

class _CameraAppState extends State<CameraPage> {
  CameraController _cameraController;
  Future<void> _initializeControllerFuture;

  @override
  void initState() {
    super.initState();
    _cameraController =
        CameraController(widget.cameras[0], ResolutionPreset.medium);
    _initializeControllerFuture = _cameraController.initialize();
  }

  @override
  void dispose() {
    _cameraController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: <Widget>[
        FutureBuilder<void>(
          future: _initializeControllerFuture,
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.done) {
              // If the Future is complete, display the preview.
              return Container(
                child: CameraPreview(_cameraController),
                width: 400,
                height: 300,
              );
            } else {
              // Otherwise, display a loading indicator.
              return Center(child: CircularProgressIndicator());
            }
          },
        ),
        SizedBox(height: 30),
        RaisedButton(
          child: Icon(Icons.camera),
          onPressed: () async {
            try {
              await _initializeControllerFuture;
              final dateTime = DateTime.now();
              final path = join((await getApplicationDocumentsDirectory()).path,
                  '${dateTime.millisecondsSinceEpoch}.png');
              await _cameraController.takePicture(path);

              Navigator.of(context).push(MaterialPageRoute(
                builder: (context) => DisplayPictureScreen(imagePath: path),
              ));
              Scaffold.of(context).showSnackBar(SnackBar(content: Text(path)));
            } catch (err, stack) {
              print(err);
            }
          },
        ),
      ],
    );
  }
}

class DisplayPictureScreen extends StatelessWidget {
  final String imagePath;
  const DisplayPictureScreen({Key key, this.imagePath}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Image Picture'),
      ),
      body: Center(
        child: Image.file(File(imagePath)),
      ),
    );
  }
}