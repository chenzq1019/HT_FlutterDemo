import 'package:flutter/material.dart';

class HTExpanded extends StatelessWidget {
  HTExpanded(this.title);
  final String title;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(this.title),
      ),
      body: HTExpandedContent(),
    );
  }
}

class HTExpandedContent extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.pink,
      child: Row(
        children: [
          Expanded(
              flex: 1,
              child: Container(
                color: Colors.red,
                height: 100,
                width: 100,)
          ),
          Expanded(
            flex: 2,
            child: Container(
            color: Colors.blue,
            height: 50,
            width: 100,
          ),),
          Container(
            color: Colors.green,
            height: 100,
            width: 100,
            child: Text("Test3"),
          )
        ],
      ),
    );
  }
}
