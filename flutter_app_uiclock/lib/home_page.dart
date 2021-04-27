import 'package:flutter/material.dart';
import 'home_page.dart';
import 'package:flutterappuiclock/config/router_manager.dart';

class HomePage extends StatelessWidget {

  //设置首页数据
  final List<String> listGif = [
    'assets/screenShot/page1.gif',
    'assets/screenShot/page2.webp',
    'assets/screenShot/page3.gif',
    'assets/screenShot/page4.gif',
    'assets/screenShot/page1.gif',
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("flutter Clocks"),centerTitle: true,),
      body: _getGridView(context),

    );
  }

  _getGridView(BuildContext context){
    return Container(
      color: Colors.white,
      padding: EdgeInsets.only(left:16,top:10,right:16,bottom:10),
      child: GridView.builder(
        itemCount: listGif.length,
        gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
          //横轴元素数量
          crossAxisCount: 2,
          mainAxisSpacing: 10,
          crossAxisSpacing: 10,
          childAspectRatio: 1,
        ),
        itemBuilder: (context,index){
          return _getItem(index,context);
        },
      ),
    );
  }

  _getItem(int index,BuildContext context){
    return InkWell(
      onTap: (){
        print("click");
        RouterManager.to(index, context);
      },
      child: Card(
        child: Image.asset(listGif[index]),
        elevation: 0,
        color: Colors.white,
      ),
    );
  }
}
