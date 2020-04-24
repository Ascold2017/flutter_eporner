import 'package:flutter/material.dart';
import 'package:flutter_eporner/widgets/homeScreen/homeScreen.dart'
    as homeScreen;
import 'package:flutter_eporner/widgets/detailsScreen/detailScreen.dart'
    as detailScreen;

import 'dart:convert';
import 'dart:async';
import 'package:http/http.dart' as http;
import 'package:flutter_eporner/videosResponse.dart';
import 'package:provider/provider.dart';

import 'package:camera/camera.dart';

List<CameraDescription> cameras;

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  cameras = await availableCameras();
  runApp(MyApp());
}

class MyApp extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return MyAppState();
  }
}

class MyAppState extends State<MyApp> {
  CameraController controller;
  @override
  void initState() {
    super.initState();
    controller = CameraController(cameras[0], ResolutionPreset.low);
    controller.initialize().then((_) {
      if (!mounted) {
        return;
      }
      setState(() {});
    });
  }

  @override
  void dispose() {
    controller?.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    if (!controller.value.isInitialized) {
      return Container();
    }
    return MaterialApp(
      title: 'Flutter Eporner',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: MultiProvider(
        child: homeScreen.HomeScreen(),
        providers: [
          ChangeNotifierProvider(
            create: (_) => VideosProvider(),
          )
        ],
      ),
      routes: {'/detail': (ctx) => detailScreen.DetailScreen(controller)},
    );
  }
}

class VideosProvider extends ChangeNotifier {
  bool isLoading = false;
  List<Videos> videos = [];

  void requestVideos({int gayFilter, String sorting, String search}) async {
    isLoading = true;
    notifyListeners();
    http.Response response = await http.get(
        'https://www.eporner.com/api/v2/video/search/?query=$search&per_page=10&page=2&thumbsize=big&order=$sorting&gay=$gayFilter&lq=1&format=json');
    if (response.statusCode == 200) {
      final VideosResponse data =
          VideosResponse.fromJson(jsonDecode(response.body));
      videos = data.videos;
    }

    isLoading = false;
    notifyListeners();
  }
}
