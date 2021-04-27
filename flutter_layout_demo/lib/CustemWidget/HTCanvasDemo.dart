
//import 'dart:html';

import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'dart:math';

class HTCanvasDemo extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;
    double height = MediaQuery.of(context).size.height;
    return Scaffold(
      appBar: AppBar(title: Text("Canvas"),),
      body: Stack(
        children: [
          CustomPaint(
            size: Size(width,width),//指定画布大小
            painter: WuZiQiPlate(),
            foregroundPainter: WuZiQiQizi(),
          ),
        ],
      ),
    );
  }
}

class WuZiQiPlate extends CustomPainter{
  @override
  void paint(Canvas canvas, Size size) {
    // TODO: implement paint


    double eWdith = size.width / 15;
    double eHeight = size.height / 15;
    //画棋盘背景颜色

    Paint painter = Paint()
      ..isAntiAlias = true
      ..style = PaintingStyle.fill
      ..color = Color(0x77cdb175);
    canvas.drawRect(Offset.zero & size, painter);

    //画网格

    painter
      ..style = PaintingStyle.stroke //线
      ..color = Colors.black
      ..strokeWidth = 1.0;

    for (int i = 0; i<=15;i++){
      double dy = eHeight * i;
      canvas.drawLine(Offset(0, dy), Offset(size.width, dy), painter);
      double dx = eWdith * i;
      canvas.drawLine(Offset(dx, 0), Offset(dx, size.height), painter);
    }
    
//    //画一个黑子
//    painter
//      ..style = PaintingStyle.fill
//      ..color = Colors.black;
//    canvas.drawCircle(Offset(size.width / 2 - eWdith / 2, size.height / 2 - eHeight / 2), min(eWdith / 2, eHeight / 2) - 2, painter);
//
//    //画一个白字
//
//    painter
//      ..style = PaintingStyle.fill
//      ..color = Colors.white;
//    canvas.drawCircle(Offset(size.width / 2 + eWdith / 2, size.height / 2 - eHeight / 2),  min(eWdith / 2, eHeight / 2) - 2, painter);

  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) {
    // TODO: implement shouldRepaint
    return false;
  }
}

class WuZiQiQizi extends CustomPainter{
  @override
  void paint(Canvas canvas, Size size) {
    // TODO: implement paint
    double eWdith = size.width / 15;
    double eHeight = size.height / 15;

    Paint painter = Paint();
    //画一个黑子
    painter
      ..style = PaintingStyle.fill
      ..color = Colors.black;
    canvas.drawCircle(Offset(size.width / 2 - eWdith / 2, size.height / 2 - eHeight / 2), min(eWdith / 2, eHeight / 2) - 2, painter);

    //画一个白字

    painter
      ..style = PaintingStyle.fill
      ..color = Colors.white;
    canvas.drawCircle(Offset(size.width / 2 + eWdith / 2, size.height / 2 - eHeight / 2),  min(eWdith / 2, eHeight / 2) - 2, painter);
  }
  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) {
    // TODO: implement shouldRepaint
    return true;
  }
}
