import 'package:flutter/material.dart';
import 'package:flutter_eporner/widgets/homeScreen/homeScreen.dart'
    as homeScreen;

import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:flutter_eporner/videosResponse.dart';
import 'package:provider/provider.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: MultiProvider(
        child: homeScreen.HomeScreen(),
        providers: [ChangeNotifierProvider(create: (_) => VideosProvider(),) ],
      ),
      routes: {
        //'/': (ctx) => homeScreen.homeScreen()
      },
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
    final VideosResponse data =
        VideosResponse.fromJson(jsonDecode(response.body));
    videos = data.videos;
    isLoading = false;
    notifyListeners();
  }
}
