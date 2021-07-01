
import 'package:flutter/material.dart';
import 'package:dio/dio.dart';
import 'dart:io';
import 'dart:convert';
import 'package:flutter_module/Model/AddressListInfo.dart';
import 'package:flutter_module/services/NetTool.dart';

class AddressListPage extends StatefulWidget {
  @override
  _AddressListPageState createState() => _AddressListPageState();
}

class _AddressListPageState extends State<AddressListPage> {
  List<AddressListModel> addressList = [];
  
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _getAddressList();
  }
  
  _getAddressList() async{
//    Options options = Options(headers: {HttpHeaders.acceptHeader:"appkey: b9563a085baedf51"});
    ///创建 dio
//    Dio dio = new Dio();
//    dio.options.headers["appkey"] = "b9563a085baedf51";
//    dio.options.headers["client_type"] = "ule";
//    dio.options.headers["market_id"] = "015";
//    dio.options.headers["session_id"] = "41836e9330962ab71ba56082f8607f4e2968f366";
//    dio.options.headers["user_token"] = "730bf6bccce3456f93a1e89056bc1c86";
    var str1 = "https://service.ule.com/appuser/address/queryAddressList2Identity.do";
    var data={'userID':"1006562729","queryFlag":"2"};
//    var response = await dio.post(
//          str1,
//          queryParameters:data
//      );
//    print(response.data);
//    final extractData = jsonDecode(response.data) as Map<String, dynamic>;
//    AddressListInfo info = AddressListInfo.fromJson(extractData);
//    print('---');
//    setState(() {
//       this.addressList = info.addressList;
//    });

    Net.instance.post(str1, data,success: (result){
      AddressListInfo info = AddressListInfo.fromJson(result);
      print('result');
      setState(() {
        this.addressList = info.addressList;
      });
    },failure: (){

    });
  }
  
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("地址列表"),actions: [TextButton(onPressed: (){
        print("添加地址");
        Navigator.of(context).pushNamed("/AddressEdit");
      }, child: Text("添加地址",style: TextStyle(color: Colors.white),)),],),
      body: Container(
        color: Colors.black12,
        child: ListView.builder(
          itemCount: this.addressList.length,
           itemBuilder: (context, index){
            final Color color =  this.addressList[index].isMyPrimaryAddress==true?Colors.red:Colors.black;
            return Container(
              color: Colors.white,
              child: Column(
                children: [
                  Padding(
                    padding: const EdgeInsets.all(15.0),
                    child: Row(
                      children: [
                        Icon(this.addressList[index].isMyPrimaryAddress ==true?Icons.check_circle:Icons.check_circle_outline,color: color,size: 20,),
                        Padding(padding: EdgeInsets.only(left: 10)),
                        Text("默认地址",style: TextStyle(fontSize: 15,color: color),)
                      ],
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(15.0),
                    child: Row(children: [
                        Expanded(flex:1,child: Text("${this.addressList[index].name}",style: TextStyle(fontSize: 15,color: color))),
                        Expanded(flex:2,child: Text("${this.addressList[index].phoneNum}",style: TextStyle(fontSize: 15,color: color)))
                      ],),
                  ),
                  ListTile(title: Text("${this.addressList[index].address}",style: TextStyle(fontSize: 15,color: color)),trailing: IconButton(icon: Icon(Icons.edit,size: 20,), onPressed: (){
                    print(this.addressList[index]);
                    Navigator.pushNamed(context,"/AddressEdit",arguments: {"address":this.addressList[index]});
                  })),
                  Divider(height: 1, color: Colors.grey,),
                  ListTile(title: Text("清关信息：请先填写清关信息",style: TextStyle(fontSize: 15),),trailing: InkWell(child: Text("编辑"),onTap: (){
                    Navigator.of(context).pushNamed("/RealName",arguments: this.addressList[index].identityInfo);
                  },),),
                  Container(height: 10,color: Colors.black12,),
                ],
              ),
            );
           },
        ),
      ),
    );
  }
}
