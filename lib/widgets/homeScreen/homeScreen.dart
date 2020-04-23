import 'package:flutter/material.dart';
import 'package:flutter_eporner/main.dart';

import 'package:flutter_eporner/widgets/layout.dart' as layout;
import 'package:flutter_eporner/widgets/homeScreen/searchForm.dart'
    as searchForm;
import 'package:flutter_eporner/widgets/homeScreen/videosList.dart'
    as videosList;
import 'package:provider/provider.dart';

class HomeScreen extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return HomeScreenState();
  }
}
class HomeScreenState extends State<HomeScreen> {
  VideosProvider _state;
  @override
  void initState() {

    Future.delayed(Duration.zero, () {
      _state.requestVideos(gayFilter: 0, sorting: 'latest', search: '');
    });
    super.initState();
  }
  @override
  Widget build(BuildContext context) {
    _state = Provider.of<VideosProvider>(context);
    return layout.Layout(
      children: <Widget>[
        searchForm.SearchForm(),
        Divider(),
        videosList.VideosList()
      ],
    );
  }
}
