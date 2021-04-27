import 'package:flutter/material.dart';

class HTContainer extends StatelessWidget {
  HTContainer(this.title);
  final String title;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text(this.title),),
      body: HTContainerContent(),
    );
  }
}

class HTContainerContent extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
        margin: EdgeInsets.all(10.0),
        child: Wrap(
          children: [
            Container(
              constraints: BoxConstraints.expand(height: Theme.of(context).textTheme.bodyText1.fontSize * 1.1 +200),
              decoration: BoxDecoration(
                border: Border.all(width: 2.0,color: Colors.red),
                color: Colors.grey,
                borderRadius: BorderRadius.all(Radius.circular(20)),
                image: DecorationImage(
                  image: NetworkImage("http://h.hiphotos.baidu.com/zhidao/wh%3D450%2C600/sign=0d023672312ac65c67506e77cec29e27/9f2f070828381f30dea167bbad014c086e06f06c.jpg"),
                  centerSlice: new Rect.fromLTRB(270.0, 180.0, 1360.0, 730.0),
                ),
              ),
              padding: EdgeInsets.all(8),
              alignment: Alignment.center,
              child: Text("Hello World",style: TextStyle(fontSize: 20,color: Colors.red),),
              transform: Matrix4.rotationZ(0.3),
            ),
            Container(
              margin: EdgeInsets.fromLTRB(0, 115, 0.0, 10),
              child: HTRoundButton(
                title: Text("I am a default button",style: TextStyle(fontSize: 18,color: Colors.white),),
                disable: false,
                onPress: (){
                  final snackBar = SnackBar(content: Text("Click One!"));
                  ScaffoldMessenger.of(context).showSnackBar(snackBar);
                },
              ),
            ),
            Container(
              margin: EdgeInsets.fromLTRB(0, 10, 0, 10),
              child: HTRoundButton(
                width: 250,
                height: 40,
                backgourdColor: Color(0xFF41CB39),
                activeBackgroundColor: Color(0xB341CB39),
                disableBackgroundColor: Color(0x3341CB39),
                title: Text("I am custom Button",style: TextStyle(fontSize: 18,color: Colors.white),),
                disable: false,
                onPress: (){
                  final snackBar = SnackBar(content: Text("Click Two!"));
                  ScaffoldMessenger.of(context).showSnackBar(snackBar);
                },
              ),
            ),
            HTRoundButton(
              title: Text("I am a disable Button", style: TextStyle(fontSize: 18,color: Colors.white),),
              disable: true,
              onPress: (){
                final snackBar = SnackBar(content: Text("Click Three!"));
                ScaffoldMessenger.of(context).showSnackBar(snackBar);
              },
            ),
          ],
        ),
    );
  }
}

class HTRoundButton extends StatefulWidget {

  static const defaultBackgroundColor = const Color(0xFF8B5FFE);
  static const defaultActiveBackgroundColor = const Color(0xB38B5FFE);
  static const defaultDisabledBackgroundColor = const Color(0x338B5FFE);

  final Widget title;
  final Color backgourdColor, activeBackgroundColor,disableBackgroundColor;
  final VoidCallback onPress;
  final double height, width;
  final bool disable;

  HTRoundButton({
      this.title,
      this.onPress,
      this.height = 52,
      this.width = double.infinity,
      this.disable = false,
      this.backgourdColor = defaultBackgroundColor,
      this.activeBackgroundColor = defaultActiveBackgroundColor,
      this.disableBackgroundColor = defaultDisabledBackgroundColor,
});
  @override
  _HTRoundButtonState createState() => _HTRoundButtonState();
}

class _HTRoundButtonState extends State<HTRoundButton> {
  Color currentColor;
  @override
  void initState(){
    super.initState();
    if(widget.disable){
        currentColor = widget.disableBackgroundColor;
    }else{
        currentColor = widget.backgourdColor;
    }

  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: (){
          if(widget.onPress != null && !widget.disable){
            widget.onPress();
          }
      },
      onTapDown: (TapDownDetails details){
          if(!widget.disable){
            setState(() {
              currentColor = widget.activeBackgroundColor;
            });
          }
      },
      onTapUp: (TapUpDetails details){
        if(!widget.disable){
          setState(() {
            currentColor = widget.backgourdColor;
          });
        }
      },
      onTapCancel: (){
        if(!widget.disable){
          setState(() {
            currentColor = widget.backgourdColor;
          });
        }
      },
      child: Container(
        decoration:  BoxDecoration(
          color: currentColor,
          borderRadius: BorderRadius.all(Radius.circular(widget.height/2.0)),
        ),
        height: widget.height,
        width: widget.width,
        alignment: Alignment.center,
        child: widget.title,
      ),
    );
  }
}


