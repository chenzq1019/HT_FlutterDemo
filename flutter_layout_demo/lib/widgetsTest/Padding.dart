import 'package:flutter/material.dart';

class HTPadding extends StatelessWidget {
  HTPadding(this.title);
  final String title;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text(this.title),),
      body: HTPaddingContent(),
    );
  }
}

class HTPaddingContent extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Padding(
        padding: EdgeInsets.fromLTRB(20, 10, 40, 40),
        child: Text("This is a Padding", style: TextStyle(fontSize: 20,color: Colors.red),),
    );
  }
}



