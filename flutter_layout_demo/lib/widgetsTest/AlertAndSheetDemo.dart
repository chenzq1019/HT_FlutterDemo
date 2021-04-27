import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';


class HTAlertSheetDemo extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("Alert Demo"),),
      body: HTAlertSheetContent(),
    );
  }
}


class  HTAlertSheetContent extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.fromLTRB(10, 10, 10, 10),
      child: Column(
        children: [CupertinoButton(
          color: Colors.blue,
          child: Text("Show Alert"),
          onPressed: (){
            showCupertinoDialog(context: context, builder: (BuildContext context){
              return CupertinoAlertDialog(
                title: Text("Title"),
                content: Text("Content"),
                actions: [
                  Container(
                    child: TextButton(
                      child: Text("确定"),
                      onPressed: (){
                        Navigator.of(context).pop();
                      },
                    ),
                  ),
                  Container(
                    child: TextButton(
                      child: Text("取消"),
                      onPressed: (){
                        Navigator.of(context).pop();
                      },
                    ),
                  )
                ],
              );
            });
          },
        ),
          Padding(padding: EdgeInsets.all(5)),
          CupertinoButton(
            color: Colors.blue,
              child: Text("Show SheetView "), onPressed: (){
              showBottomSheet(context: context, builder: (BuildContext context){
                return CupertinoActionSheet(
                  title: Text("Sheet Title"),
                  actions: [
                    TextButton(onPressed: (){
                      Navigator.of(context).pop();
                    }, child: Text("确定")),

                    TextButton(onPressed: (){
                      Navigator.of(context).pop();
                    }, child: Text("取消"))
                  ],
                  cancelButton: TextButton(child: Text("Concel"),),
                );
              });

          })
        ]
      ),
    );
  }
}
