import 'package:webview_flutter/webview_flutter.dart';
import 'package:flutter_eporner/videosResponse.dart' as VideosResponse;
import 'package:flutter/material.dart';
import 'package:flutter_eporner/widgets/layout.dart' as layout;

class DetailScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final VideosResponse.Videos video =
        ModalRoute.of(context).settings.arguments;

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
