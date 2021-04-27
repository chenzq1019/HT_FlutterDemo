import 'package:flutter/material.dart';

///AspectRatio的作用是调整child到设置的宽高比，

class HTAspectRatio extends StatelessWidget {
  final String title;
  HTAspectRatio(this.title);
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text(this.title),),
      body: HTAspectRatioContent(),
    );
  }
}

class  HTAspectRatioContent extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.blue,
      alignment: Alignment.center,
      height: 100.0,
      width: 100.0,
      child: AspectRatio(
        aspectRatio: 2,
        child: Container(
          width: 100,
          height: 50,
          color: Colors.green,
        ),
      ),
    );
  }
}
