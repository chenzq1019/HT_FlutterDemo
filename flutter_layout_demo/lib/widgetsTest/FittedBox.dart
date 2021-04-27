import 'package:flutter/material.dart';

class HTFitedBox extends StatelessWidget {
  final String title;
  HTFitedBox(this.title);
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(this.title),
      ),
      body: HTFittefBoxContent(),
    );
  }
}

class HTFittefBoxContent extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      height: double.infinity,
      color: Colors.amberAccent,
      child: FittedBox(
        fit: BoxFit.cover,
        alignment: Alignment.center,
        child: Container(
          color: Colors.red,
          child: Text("FitterBOx"),
        ),
      ),
    );
  }
}
