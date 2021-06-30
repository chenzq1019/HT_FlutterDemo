import 'package:flutter/material.dart';

class AddressButton extends StatelessWidget {

  final Color buttonColor;
  final String buttonTitle;
  final Object tapEvent;
  final double height;

  AddressButton({Key key,this.buttonColor = Colors.red,this.buttonTitle="按键",this.height=45,this.tapEvent =num}):super(key: key);

  @override
  Widget build(BuildContext context) {
    return InkWell(child: Container(
      margin: EdgeInsets.all(5),
      padding: EdgeInsets.all(5),
      height: this.height,
      width: double.infinity,
      decoration: BoxDecoration(
        color: this.buttonColor,
        borderRadius: BorderRadius.circular(10),
      ),
      child: Center(
        child: Text("${this.buttonTitle}",style: TextStyle(color: Colors.white),),
      ),
    ),onTap: this.tapEvent,);
  }
}
