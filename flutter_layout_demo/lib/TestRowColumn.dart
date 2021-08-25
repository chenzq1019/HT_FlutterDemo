
import 'package:flutter/material.dart';


class TestRowColumnPage extends StatefulWidget {
  @override
  _TestRowColumnPageState createState() => _TestRowColumnPageState();
}

class _TestRowColumnPageState extends State<TestRowColumnPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("RowAndColumn"),),
      body: Container(
        color: Colors.red,
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child:Column(
            children: [
                Expanded(
                  child: Container(
                    color: Colors.blue,
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text("第一个行"),
                        Text("第二行"),
                      ],
                    ),
                  ),
                ),
            ],
          ),
        ),
      ),
    );
  }
}
