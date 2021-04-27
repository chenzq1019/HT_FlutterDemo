import 'dart:async';
import 'dart:math';
import 'package:flutter/material.dart';
import 'package:flutterappuiclock/pages/dail_plate.dart';



class Page1 extends StatefulWidget {
  @override
  _Page1State createState() => _Page1State();
}

class _Page1State extends State<Page1> {

  bool _firstSwitch = true;
  bool _secondSwich = false;
  bool _thirdSwich = false;

  Color _colorOn = Colors.yellow;
  Color _colorOff = Colors.yellow.withAlpha(100);

  Color _switchActiveColor = Colors.yellow;
  Color _swotchInActiveColor = Colors.yellow.withAlpha(100);

   Timer _timer;

  void initState(){
    super.initState();
    _timer = Timer.periodic(Duration(seconds: 1), (timer) {
      setState(() {

      });
    });
  }

  @override

  void dispose(){
    _timer.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("Page1"),),
      body: Stack(
        children: [
          CustomPaint(
            painter: DailPlate(context,Color.fromARGB(255, 70, 0, 144),Color.fromARGB(255, 121, 83, 254)),
          )
        ],
      ),
    );
  }
}
