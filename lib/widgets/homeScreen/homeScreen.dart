import 'package:flutter/material.dart';
import 'package:flutter_eporner/widgets/layout.dart' as layout;
import 'package:flutter_eporner/widgets/homeScreen/searchForm.dart'
    as searchForm;
import 'package:flutter_eporner/widgets/homeScreen/videosList.dart'
    as videosList;

class HomeScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    
    return layout.Layout(
      children: <Widget>[
        searchForm.SearchForm(),
        Divider(),
        videosList.VideosList()
      ],
    );
  }
}
