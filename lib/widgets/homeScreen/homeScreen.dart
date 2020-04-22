import 'package:flutter/material.dart';
import 'package:flutter_eporner/widgets/homeScreen/searchForm.dart'
    as searchForm;
import 'package:flutter_eporner/widgets/homeScreen/videosList.dart' as videosList;

class HomeScreen extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return _HomeScreen();
  }
}

class _HomeScreen extends State<HomeScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.red[400],
        title: Text('Eporner'),
        centerTitle: true,
      ),
      body: Container(
        color: Colors.red[300],
        padding: EdgeInsets.all(8),
        child: Column(
          children: <Widget>[searchForm.SearchForm(), Divider(), videosList.VideosList()],
        ),
      ),
    );
  }
}
