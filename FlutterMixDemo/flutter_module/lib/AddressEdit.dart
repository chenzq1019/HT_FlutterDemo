import 'package:flutter/material.dart';
import 'package:flutter_module/View/AddressInput.dart';
import 'package:flutter_module/View/AddressButton.dart';
import 'package:flutter_module/Model/AddressListInfo.dart';
import 'package:flutter_module/AddressSelect.dart';


class AddressEditPage extends StatefulWidget {
  Map arguments;
  AddressEditPage({Key key,this.arguments}):super(key: key);
  @override
  _AddressEditPageState createState() => _AddressEditPageState();
}

class _AddressEditPageState extends State<AddressEditPage> with EvnetAreaDialogCallBack {
  AddressListModel addressInfo;
  String areaAddress ='';
  Map<int,AddressCityItem> areaMap = new Map();
  String name;
  String phoneNUm;
  String postCode;
  String userAddress;


  _showAddressSheetView(){
    showModalBottomSheet(clipBehavior: Clip.antiAlias, shape: RoundedRectangleBorder(
    borderRadius: BorderRadius.only(
    topLeft: Radius.circular(20),
    topRight: Radius.circular(20),
    ),),context: context, builder: (BuildContext context){
      return AddressSelectPage(eventCallBack: this,defaultAreaMap: this.areaMap,);
    });
  }

  void onEventAreaDialogCallBack(Map<int, AddressCityItem> selectMap){
      String areaStr="";
      for(int i=0;i<selectMap.length;i++){
          AddressCityItem item = selectMap[i];
          areaStr += item.name;
      }
      this.areaMap = selectMap;
      setState(() {
        this.areaAddress= areaStr;
      });
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    this.name = "收货人";
    this.phoneNUm = "手机号码";
    this.areaAddress = "省/市/区/镇";
    this.postCode = "邮政编码";
    this.userAddress = "请填写详细地址";
    print(widget.arguments);
    if(widget.arguments!=null&&widget.arguments['address']!=null){
      this.addressInfo = widget.arguments["address"];
      this.areaAddress= this.addressInfo.provinceName+this.addressInfo.cityName+this.addressInfo.areaName+this.addressInfo.townName;
      this.name =this.addressInfo.name;
      this.phoneNUm = this.addressInfo.phoneNum;
      this.userAddress = this.userAddress;
      if(this.addressInfo.provinceCode.length>0){
        AddressCityItem province =AddressCityItem(rank: "1",code: this.addressInfo.provinceCode,name: this.addressInfo.provinceName);
        this.areaMap[0]=province;
      }
      if(this.addressInfo.cityCode.length>0){
        AddressCityItem city =AddressCityItem(rank: "2",code: this.addressInfo.cityCode,name: this.addressInfo.cityName);
        this.areaMap[1]=city;
      }
      if(this.addressInfo.areaCode.length>0){
        AddressCityItem area =AddressCityItem(rank: "3",code: this.addressInfo.areaCode,name: this.addressInfo.areaName);
        this.areaMap[2]=area;
      }
      if(this.addressInfo.townCode.length>0){
        AddressCityItem town =AddressCityItem(rank: "4",code: this.addressInfo.townCode,name: this.addressInfo.townName);
        this.areaMap[3]=town;
      }
    }

  }


  @override
  Widget AddressSelectCell(String title,String text){
    return InkWell(
      onTap: (){
        _showAddressSheetView();
      },
      child: Container(
//        padding: EdgeInsets.all(8),
        height: 60,
        decoration: BoxDecoration(
            border: Border(
              bottom: BorderSide(width: 1,color: Colors.black12),
            )
        ),
        child: Row(
          children: [
            Container(padding: EdgeInsets.only(left: 8),child: Text("${title}"),width: 82,),
            Expanded(child: Text("${text}",style: TextStyle(fontSize: 15,color: Colors.black54),)),
            Padding(
              padding: const EdgeInsets.only(right: 10),
              child: Icon(Icons.arrow_forward_ios_sharp,size: 20,color: Colors.black54,),
            ),
          ],
        ),
      ),
    );
  }

  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("新建收货地址"),),
      body: Container(

        child: ListView(
          children: [
                  AddressInputFiled(title: "收货人",text: "${this.name}",onChanged: (value){
                       print(value);
                  },),
                  AddressInputFiled(title: "手机号码",text: "${this.phoneNUm}",onChanged: (value){
                      print(value);
                  },),
                  AddressSelectCell("所在地区", "${this.areaAddress}"),
                  AddressInputFiled(title: "邮政编码",text: "邮政编码",onChanged: (value){
                      print(value);
                  },),
                  AddressInputFiled(title: "详细地址",text: "${this.userAddress}",onChanged: (value){
                      print(value);
                  },),
            Padding(padding: EdgeInsets.only(top: 20)),
            AddressButton(buttonTitle: "保存",tapEvent: (){

            },),
            AddressButton(buttonTitle: "设为默认收货地址",tapEvent:(){

            }),
          ],
        ),
      ),
    );
  }
}
