
import 'package:flutter/material.dart';

class WrapDemoPage extends StatefulWidget {
  @override
  _WrapDemoPageState createState() => _WrapDemoPageState();
}

class _WrapDemoPageState extends State<WrapDemoPage> {

  List _getWrapChilds(){
    List wraps = [];
    for(int i=0;i<20;i++){
      wraps.add(i);
    }
    return wraps;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("Wrap"),),
      body: Container(
        padding: EdgeInsets.all(10),
        child: Wrap(
          spacing: 10,
            runSpacing:10,
          children: _getWrapChilds().map((e){
            return Container(width: 100,height: 100,color: Colors.red,);
          }).toList(),
        ),
      ),
    );
  }
}
