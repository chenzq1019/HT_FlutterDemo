import 'package:flutter/material.dart';

class HTConstrainedBox extends StatelessWidget {
  HTConstrainedBox(this.title);
  final String title;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(this.title),
      ),
      body: HTConstrainedBoxContent(),
    );
  }
}

class HTConstrainedBoxContent extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return ConstrainedBox(
        constraints: BoxConstraints(
          minHeight: 100,
          minWidth: 100,
          maxWidth: 150,
          maxHeight: 250,
        ),
      child: Container(
        width: 200,
        height: 200,
        color: Colors.red,
      ),
    );
  }
}
