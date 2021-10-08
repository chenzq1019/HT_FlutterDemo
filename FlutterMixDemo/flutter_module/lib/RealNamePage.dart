import 'dart:ui';
import 'package:image_picker/image_picker.dart';
import 'package:flutter/material.dart';
import 'package:flutter_module/services/ScreenAdaper.dart';
import 'package:flutter_module/Model/AddressListInfo.dart';
import 'dart:io';
class RealNamePage extends StatefulWidget {
  AddressIdentity arguments;
  RealNamePage({Key key,this.arguments}):super(key: key);
  @override
  _RealNamePageState createState() => _RealNamePageState();
}

class _RealNamePageState extends State<RealNamePage> {
  File forwardPicPath;
  File backwordPicPath;
  Future getImage(String type) async{
    final _picker = ImagePicker();
    final pickedFile = await _picker.getImage(source: ImageSource.gallery);
    final File file = File(pickedFile.path);
    print(File(pickedFile.path));
    setState(() {
      if(type =="0"){
        this.forwardPicPath = File(pickedFile.path);
      }else{
        this.backwordPicPath = File(pickedFile.path);
      }
    });
  }
  
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    this.backwordPicPath= null;
    this.forwardPicPath = null;
  }

  @override
  Widget build(BuildContext context) {
    final width = MediaQuery.of(context).size.width;
    final double bottomPadding = MediaQuery.of(context).padding.bottom;
    return Scaffold(
      appBar: AppBar(title: Text("收货人清关信息"),),
      body: SafeArea(
        child: Stack(
          children: [
            ListView(children: [
              Container(margin: EdgeInsets.only(bottom: 10),alignment: Alignment.center,color: Color(0xfff4e2e2),height: 40,
                  child: Text("请确保上传的证件照片姓名与收货人姓名一致",style: TextStyle(color: Colors.red),)),
              Row(
                mainAxisAlignment:MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Container(padding: EdgeInsets.only(left: 10),width: 100,child: Text("证件照片")),
                  Expanded(child: InkWell(
                    onTap: (){
                      print("上传正面照片");
                      getImage("0");
                    },
                    child: Container(
                        height: 120,
                        color: Colors.grey,
                        child: Stack(
                            alignment: Alignment.bottomCenter,
                            children:[
                              Container(alignment: Alignment.center,child:this.forwardPicPath!=null?Image.file(this.forwardPicPath):Image.asset("images/addIDPic@2x.png",fit: BoxFit.fill,)),
                              Text("上传身份证正面照片",style: TextStyle(color:Colors.white),
                    )])),
                  )),
                  Padding(padding: EdgeInsets.only(left: 10)),
                  Expanded(child: InkWell(
                    onTap: (){
                      print("上传背面照片");
                      getImage("1");
                    },
                    child: Container(
                        height: 120,
                        color: Colors.grey,
                        child: Stack(
                            alignment: Alignment.bottomCenter,
                            children:[
                              Container(alignment: Alignment.center,child:this.backwordPicPath!=null?Image.file(this.backwordPicPath):Image.asset("images/addIDPic@2x.png",fit: BoxFit.fill,)),
                              Text("上传身份证反面照片",style: TextStyle(color:Colors.white),
                              )])),
                  )),
                  Padding(padding: EdgeInsets.only(right: 10))
              ],),
              Padding(padding: EdgeInsets.only(bottom: 10)),
              Row(
                children: [
                  Container(padding: EdgeInsets.only(left: 10),width:100,child: Text("姓名")),
                  Expanded(child: Container(padding: EdgeInsets.all(10),decoration: BoxDecoration(border: Border.all(width: 0.6,color: Colors.black54)), child: Text("陈竹青"))),
                  Padding(padding: EdgeInsets.only(right: 10)),
                ],
              ),
              Padding(padding: EdgeInsets.only(bottom: 10)),
              Row(
                children: [
                  Container(padding: EdgeInsets.only(left: 10),width:100,child: Text("证件号")),
                  Expanded(child: Container(padding: EdgeInsets.all(10),decoration: BoxDecoration(border: Border.all(width: 0.6,color: Colors.black54)), child: Text(""))),
                  Padding(padding: EdgeInsets.only(right: 10)),
                ],
              ),
              Padding(padding: EdgeInsets.only(bottom: 10)),
              Row(
                mainAxisAlignment:MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Container(padding: EdgeInsets.only(left: 10),width:100,child: Text("温馨提示")),
                  Expanded(child: Text( "上传文件格式为png 、jpg，大小在2M以内；图片清晰，文字可辨别，所有身份证或临时身份证必须在有效期内；\n可以添加水印”此文件只用于包裹清关使用“的字样，添加的文字不可遮挡住身份证图片上的任何可读信息，如文字、数字、照片；",softWrap: true,)),
                  Padding(padding: EdgeInsets.only(right: 10)),
                ],
              ),
              Padding(padding: EdgeInsets.only(bottom: 70)),
            ],),
            Positioned(
              width: width,
              height: 45,
              bottom: 0,
              child: Row(
                children: [
                  Expanded(child: Container(alignment: Alignment.center,color: Colors.white,child: Text("取消",style: TextStyle(fontSize: 16),))),
                  Expanded(child: Container(alignment: Alignment.center,color: Colors.red,child: Text("确定",style: TextStyle(fontSize: 16,color: Colors.white)))),
                ],
              ),
            ),
          ],

        ),
      )
    );
  }
}
