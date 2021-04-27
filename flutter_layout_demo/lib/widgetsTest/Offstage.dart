import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class HTOffstage extends StatelessWidget {
  final String title;
  HTOffstage(this.title);
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(this.title),
      ),
      body: HTOffstgageContent(),
    );
  }
}

class HTOffstgageContent extends StatefulWidget {
  @override
  _HTOffstgageContentState createState() => _HTOffstgageContentState();
}

class _HTOffstgageContentState extends State<HTOffstgageContent> {
  bool offstage;
  @override
  void initState(){
    super.initState();
    offstage = false;
  }
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Offstage(
          offstage: offstage,
          child: Container(
            color: Colors.blue,
            height: 100,
          ),
        ),
        CupertinoButton(
            child: Text("点击切换显示"),
            onPressed: (){
                setState(() {
                  offstage = !offstage;
                });
            }
            ),
      ],
    );
  }
}

