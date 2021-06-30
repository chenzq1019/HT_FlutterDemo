import 'package:flutter/material.dart';

class AddressInputFiled extends StatelessWidget {
  final String text;
  final String title;
  final Object onChanged;
  final int maxline;
  final double height;
  final bool readOnly;
  final TextEditingController controller;
  AddressInputFiled({Key key,this.text = "输入内容",this.title,this.onChanged,this.readOnly=false,this.maxline = 1,this.height= 60,this.controller=null}):super(key: key);
  @override
  Widget build(BuildContext context) {
    return Container(
//      padding: EdgeInsets.all(8),
      height: this.height,
      decoration: BoxDecoration(
        border: Border(
          bottom: BorderSide(width: 1,color: Colors.black12),
        )
      ),
      child: Row(
        children: [
          Container(padding: EdgeInsets.only(left: 8),width: 70,child: Text("${this.title}",style: TextStyle(fontSize: 15),)),
          Expanded(
            child: TextField(
              readOnly: this.readOnly,
              style: TextStyle(fontSize: 15),
              controller: this.controller,
              maxLines: this.maxline,
              decoration: InputDecoration(
                hintStyle: TextStyle(fontSize: 15),
                hintText: this.text,
                  border: OutlineInputBorder(
//                      borderRadius: BorderRadius.circular(30),
                      borderSide: BorderSide.none)
              ),
              onChanged: this.onChanged,
            ),
          ),
        ],
      ),
    );
  }
}
