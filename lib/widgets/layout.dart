import 'package:flutter/material.dart';

class Layout extends StatelessWidget {

  final List<Widget> children;

  Layout({this.children});
 
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
          children: children,
        ),
      ),
    );
  }
}

