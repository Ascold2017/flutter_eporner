import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_eporner/main.dart';
import 'package:flutter_eporner/videosResponse.dart' as VideosResponse;
import 'package:provider/provider.dart';

class VideosList extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return _VideosList();
  }
}

class _VideosList extends State<VideosList> {
  @override
  Widget build(BuildContext context) {
    VideosProvider _state = Provider.of<VideosProvider>(context);
    return Expanded(
      child: _state.isLoading
          ? Center(child: CircularProgressIndicator())
          : ListView.builder(
              itemCount: _state.videos.length,
              itemExtent: 250,
              itemBuilder: (ctx, index) {
                VideosResponse.Videos video = _state.videos[index];

                return _videoItem(video);
              }),
    );
  }
}

Widget _videoItem(VideosResponse.Videos video) {
  return SizedBox(
    height: 250,
    child: GestureDetector(
      onTap: () {
        print('tap');
      },
      child: Stack(
        fit: StackFit.passthrough,
        children: <Widget>[
          
          Image.network(
            video.defaultThumb.src,
            fit: BoxFit.fitHeight,
          ),

          Positioned(
              bottom: 0,
              child: Container(
                padding: EdgeInsets.all(5),
                color: Colors.black45,
                child: Text(
                  video.title,
                  style: TextStyle(color: Colors.white),
                ),
              )),
        ],
      ),
    ),
  );
}

class VideosListState extends ChangeNotifier {
  String currentTappedItemId;
  void setTappedItemId(String id) {
    currentTappedItemId = id;
    notifyListeners();
  }
}
