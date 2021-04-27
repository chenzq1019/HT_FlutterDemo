import 'package:flutter/material.dart';

class HTAlignDemo extends StatelessWidget {
  final String title;
  HTAlignDemo(this.title);
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(this.title),
      ),
      body: HTAlignContent(),
    );
  }
}

class HTAlignContent extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.red,
      child: Align(
        alignment: Alignment(0.2,0),
        widthFactor: double.infinity,
        heightFactor: 3.0,
        child: Container(
          color: Colors.amber,
          child: Text("Align",style: TextStyle(fontSize: 20,color: Colors.white),),
        ),
      ),
    );
  }
}

