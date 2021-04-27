

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
//import 'page_1.dart';
import 'package:flutterappuiclock/pages/page_1.dart';

class RouterManager{

  static List<Widget> _listPages = [
      Page1()
  ];

  static to(int index,BuildContext context){
    Navigator.push(context, MaterialPageRoute(builder: (context) => _listPages[0]));
  }
}