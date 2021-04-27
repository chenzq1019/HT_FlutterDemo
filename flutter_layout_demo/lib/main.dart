import 'dart:ffi';

import 'package:flutter/material.dart';
import 'widgetsTest/container.dart';
import 'widgetsTest/Padding.dart';
import 'widgetsTest/Align.dart';
import 'widgetsTest/Center.dart';
import 'widgetsTest/ConstrainedBox.dart';
import 'widgetsTest/FittedBox.dart';
import 'widgetsTest/AspectRatio.dart';
import 'widgetsTest/Offstage.dart';
import 'widgetsTest/Expanded.dart';
import 'widgetsTest/AlertAndSheetDemo.dart';
import 'CustemWidget/HTCanvasDemo.dart';
import 'CustemWidget/HTGradientCircul.dart';
void main() => runApp(MyApp());

const List<String> layougWidgets = [
  "Container",
  "Padding",
  "Center",
  "Align",
  "FittedBox",
  "AspectRatio",
  "ConstrainedBox",
  "Expanded",
  "BaseLine",
  "FractionallySizedBox",
  "IntrinsicHeight",
  "IntrinsicWidth",
  "LimitedBox",
  "Offstage",
  "OverflowBox",
  "SizedBox",
  "SizedOverflowBox",
  "Transform",
  "CustomSingleChildLayout",
  "AlertDemo",
  "Canvas",
  "Gradient"
];

const List<String> mutilLayouWidgets = [
  "Row",
  "Column",
  "IndexedStack",
  "GridView",
  "Flow",
  "Table",
  "Wrap",
  "ListBody",
  "ListView",
  "CustomMultiChildLayout",
];

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        // This is the theme of your application.
        //
        // Try running your application with "flutter run". You'll see the
        // application has a blue toolbar. Then, without quitting the app, try
        // changing the primarySwatch below to Colors.green and then invoke
        // "hot reload" (press "r" in the console where you ran "flutter run",
        // or simply save your changes to "hot reload" in a Flutter IDE).
        // Notice that the counter didn't reset back to zero; the application
        // is not restarted.
        primarySwatch: Colors.blue,
      ),
      home: MyHomePage(title: 'Flutter Demo Home Page1'),
      routes: <String, WidgetBuilder>{
        '/Container': (_) => HTContainer("Container"),
        '/Padding':(_) => HTPadding("Padding"),
        '/Align':(_) => HTAlignDemo("Align"),
        '/Center':(_) => HTCenterDemo("Center"),
        '/ConstrainedBox':(_) => HTConstrainedBox("constrainedBox"),
        '/FittedBox':(_) => HTFitedBox("FittedBox"),
        '/AspectRatio':(_) => HTAspectRatio("AspectRatio"),
        '/Offstage': (_) => HTOffstage("Offstage"),
        '/Expanded': (_) => HTExpanded("Expanded"),
        '/AlertDemo': (_) => HTAlertSheetDemo(),
        '/Canvas': (_) => HTCanvasDemo(),
        '/Gradient': (_) =>HTGradienCircular(),
      },
    );
  }
}

class MyHomePage extends StatefulWidget {
  final String title;
  MyHomePage({Key key,this.title}) : super(key: key);
  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text(widget.title),),
      body: ListView.builder(
        itemBuilder: (BuildContext context, int index){
            return ListTile(
                  title: Text(layougWidgets[index]),
                  onTap: (){
                    _navigateToPage(context, layougWidgets[index]);
                   },
           );},
        itemCount: layougWidgets.length,
      ),
    );
  }
}

void _navigateToPage(BuildContext context, String page){
  Navigator.of(context).pushNamed("/$page");
}





