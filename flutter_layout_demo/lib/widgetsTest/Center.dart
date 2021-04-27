import 'package:flutter/material.dart';

class HTCenterDemo extends StatelessWidget {
  HTCenterDemo(this.title);
  final String title;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(this.title),
      ),
      body: HTCenterContent(),
    );
  }
}

class HTCenterContent extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
//    return Center(
//      child: Text("Center",style: TextStyle(fontSize: 20,color: Colors.red),),
//    );
      return Container(
        width: double.infinity,
        height: 300,
        color: Colors.green,
        child: Center(
          child: Text("Center",style: TextStyle(fontSize: 20,color: Colors.red),),
        ),
      );
  }
}
