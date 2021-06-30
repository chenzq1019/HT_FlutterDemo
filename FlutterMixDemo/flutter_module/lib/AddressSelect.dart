
import 'package:flutter/material.dart';
import 'package:flutter_module/services/ScreenAdaper.dart';
import 'package:dio/dio.dart';
import 'package:flutter_module/Model/AddressListInfo.dart';
import 'dart:convert';

abstract class EvnetAreaDialogCallBack{
  void onEventAreaDialogCallBack(Map<int, AddressCityItem> selectMap);
}

class AddressSelectPage extends StatefulWidget {

  EvnetAreaDialogCallBack eventCallBack ;
  Map<int, AddressCityItem> defaultAreaMap;
  AddressSelectPage({Key key,this.eventCallBack,this.defaultAreaMap}):super(key: key);

  @override
  _AddressSelectPageState createState() => _AddressSelectPageState();
}

class _AddressSelectPageState extends State<AddressSelectPage> with TickerProviderStateMixin{

  TabController _tabController;

  String selectProvinceStr = '省份';
  String selectCityStr = '城市';
  String selectDistricStr = '区/县';

  Map<int,List<AddressCityItem>> datas = new Map();
  Map<int, AddressCityItem> selectDatas = new Map();
  int currentTabPos = -1;
  bool hasDefaultAddress = false;

  TextStyle tabTvStyle = new TextStyle(color: Colors.black,fontSize: 18,fontWeight: FontWeight.w300);
  List tabsdata = [];
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    tabsdata =[];// ["请选择"];
    //初始化控制器
    _tabController = new TabController(length: tabsdata.length, vsync: this);
//    _tabController.addListener(() {
//        currentTabPos = _tabController.index;
//    });
    if(widget.defaultAreaMap!=null&& widget.defaultAreaMap.length>0){
      hasDefaultAddress = true;
    }
    _queryLocal("","1");
  }

  void queryDefaultSelectArear(){
//    for(int i =0;i<widget.defaultAreaMap.length;i++){
      AddressCityItem item = widget.defaultAreaMap[currentTabPos];
      this.tabsdata[currentTabPos] = item.name;
      _queryLocal(item.code, item.rank);
//      currentTabPos++;
//      this.tabsdata[currentTabPos] = '请选择';
//    }
  }

  _showSnack(){
    ScaffoldMessenger.maybeOf(context).showSnackBar(SnackBar(content: new Text('请先选择上级地区')));
  }

  ///查询区域信息
  _queryLocal(String code,String rank)  async{
      if(currentTabPos>=3){
        print("没有四级地址");
        widget.eventCallBack.onEventAreaDialogCallBack(this.selectDatas);
        Navigator.of(context).pop();
        return;
      }
      String rtnType = code.length>0?"1":"0";
      Dio dio = new Dio();
      String apiTail ='';
      switch(rank){
        case "1":
          apiTail = "getProvinces.do";break;
        case "2":
          apiTail = "getCities.do";break;
        case "3":
          apiTail = "getAreas.do";break;
        case "4" :
          apiTail = "getTowns.do";break;
        default:
          apiTail = "getProvinces";break;;
      }
      var str1 = "https://static-content.ulecdn.com/mobilead/address/${apiTail}";
      var response = await dio.get(str1,queryParameters: {"code":code,"rank":rank,"rtnType":rtnType});
      print(response.data);
      final extractData = jsonDecode(response.data) as Map<String, dynamic>;
      AddressCityInfo cityInfo = AddressCityInfo.fromJson(extractData);
      List tabs = this.tabsdata;
      if(cityInfo.addressInfos.length<=0){
         print("没有四级地址");
         widget.eventCallBack.onEventAreaDialogCallBack(this.selectDatas);
         Navigator.of(context).pop();
         return;
      }else{
        currentTabPos++;
        if(!this.hasDefaultAddress){
          tabs.add("请选择");
        }
      }
      setState(() {
        if(this.hasDefaultAddress){
          for(int i=0;i<cityInfo.addressInfos.length;i++){
            AddressCityItem temp = cityInfo.addressInfos[i];
            if(temp.name == widget.defaultAreaMap[currentTabPos].name){
              temp.isSelected = true;
              break;
            }else{
              temp.isSelected = false;
            }
          }
//          if(currentTabPos<=3){
            this.datas[currentTabPos] = cityInfo.addressInfos;
            AddressCityItem item=widget.defaultAreaMap[currentTabPos];
            selectDatas[currentTabPos] = item;
//            if(currentTabPos==0){
//              tabs.removeLast();
//            }
            tabs.add(item.name);
            this.tabsdata = tabs;
            _tabController = new TabController(length: tabsdata.length, vsync: this);
            _tabController.animateTo(currentTabPos);
            print(currentTabPos);
            if(currentTabPos<widget.defaultAreaMap.length-1){
//              currentTabPos++;
              _queryLocal(item.code, item.rank);

            }
//          }
        }else{
          this.datas[currentTabPos] = cityInfo.addressInfos;
          _tabController = new TabController(length: tabsdata.length, vsync: this);
          _tabController.animateTo(currentTabPos);
          this.tabsdata = tabs;
        }
      });
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(automaticallyImplyLeading: false,
      title: Text("所在地区",style: TextStyle(color: Color(0xff666666),fontSize: 15),),
        centerTitle: true,
        elevation: 0.5,
        backgroundColor: Colors.white,
        actions: [
          IconButton(icon: Icon(Icons.close,color: Color(0xff666666),), onPressed: (){
            Navigator.pop(context);
          })
        ],
      ),
      body: _getBody(),
    );
  }

  Widget _getBody(){
    if(_showLoadingDialog()){
      return Center(child: CircularProgressIndicator(),);
    }else{
      return _buildContent();
    }
  }

  Widget _buildContent(){
      return Container(
        color: Colors.white,
        child:  Column(
          children: [
            Padding(padding: EdgeInsets.only(top: 5)),
            Container(
              height: 40,
              alignment: Alignment.centerLeft,
              child: TabBar(
                indicatorColor: Colors.black,
                isScrollable: true,
                indicatorSize: TabBarIndicatorSize.label,
                controller: _tabController,
                  tabs: tabsdata.map((item) {
                    return Text("${item}",style: TextStyle(color: Colors.black54),);
                  }).toList(),
              onTap: (index){
                  print("点击了第${index}个Tab");
                  currentTabPos = index;
              },),
            ),
            Padding(padding: EdgeInsets.only(top: 5)),
             Expanded(
               child: TabBarView(
                 controller: this._tabController,
                   children: _buildPages(),)
             )
          ],
        ),
      );
  }

  List<Widget> _buildPages(){
    List<Widget> pages = [];
    for(int i=0;i<datas.length;i++){
      Widget page = _buildListView(datas[i]);
      pages.add(page);
    }
    return pages;
  }

  Widget _buildListView(List address){
    return ListView.builder(
        shrinkWrap: true,
        itemCount: address.length,
        itemBuilder: (BuildContext context, int position){
       return _buildListRow(address,position);
    });
  }

  Widget _buildListRow(List address,int position){
    AddressCityItem item = address[position];
    return ListTile(
      contentPadding: EdgeInsets.only(top: 0,bottom: 0,left: 15),
      title: Text("${item.name}",style: TextStyle(color: item.isSelected?Colors.red:Color(0xff666666),fontSize: 15),),
      onTap: () =>_onLocalSelect(position),
    );
  }

  _onLocalSelect(int position){
    this.hasDefaultAddress = false;
    print(currentTabPos);
    AddressCityItem item = this.datas[currentTabPos][position];
    tabsdata[currentTabPos] = item.name;
    datas[currentTabPos].forEach((element) { element.isSelected = false;});
    item.isSelected = true;
    selectDatas[currentTabPos] = item;
//    if (currentTabPos>=3){
//      setState(() {
//        tabsdata[currentTabPos] = item.name;
//      });
//      widget.eventCallBack.onEventAreaDialogCallBack(this.selectDatas);
//      Navigator.of(context).pop();
//      return;
//    }
    if(tabsdata.length-1 >currentTabPos){
        tabsdata.removeRange(currentTabPos+1, tabsdata.length);
        int count= datas.length;
        for(int i=currentTabPos+1;i<count;i++){
          datas.remove(i);
          selectDatas.remove(i);
        }
    }
    _queryLocal(item.code, item.rank);
//    currentTabPos++;
//    tabsdata.add("请选择");
  }

  ///根据数据是否有返回显示加载条或者列表
  bool _showLoadingDialog() {
    if (datas == null || datas.length == 0) {
      return true;
    } else {
      return false;
    }
  }
}
