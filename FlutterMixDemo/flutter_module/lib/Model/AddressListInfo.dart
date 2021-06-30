
import 'dart:convert';

class AddressListInfo{
  List<AddressListModel> addressList;
  AddressListInfo({this.addressList});

  AddressListInfo.fromJson(Map<String, dynamic> json) {
    if (json["addressInfo"] != null){
      addressList = [];
      json["addressInfo"].forEach((v){
          addressList.add(new AddressListModel.fromJson(v));
      });
    }
  }

}

class AddressListModel{
  String name;
  String phoneNum;
  String address;
  bool isMyPrimaryAddress;
  String provinceName;
  String provinceCode;
  String cityName;
  String cityCode;
  String areaName;
  String areaCode;
  String townName;
  String townCode;
  String userAddress;

  AddressListModel({
    this.name,this.phoneNum,this.address,this.isMyPrimaryAddress=false,this.provinceName,this.provinceCode,
    this.cityName,this.cityCode,this.areaName,this.areaCode,this.townName,this.townCode,this.userAddress
});

  AddressListModel.fromJson(Map<String, dynamic> json){
    name = json["usrName"];
    phoneNum = json["phoneNumber"];
    address = json["provienceNameNew"]+ json["cityNameNew"] +json["areaNameNew"] + json["townNameNew"] + json["usrAddress"];
    isMyPrimaryAddress= json["isMyPrimaryAddress"] == '1' ? true:false ;
    provinceName = json["provienceNameNew"];
    provinceCode = json["provienceCodeNew"];
    cityName = json["cityNameNew"];
    cityCode = json["cityCodeNew"];
    areaName =  json["areaNameNew"];
    areaCode = json["areaCodeNew"];
    townName = json["townNameNew"];
    townCode = json["townCodeNew"];
    userAddress = json["usrAddress"];

  }
}

class AddressCityInfo{
  List<AddressCityItem> addressInfos;
  AddressCityInfo({this.addressInfos});
  AddressCityInfo.fromJson(Map<String,dynamic> json){
    addressInfos= [];
    if(json["addressInfos"] != null){
      json["addressInfos"].forEach((value){
         addressInfos.add(AddressCityItem.fromJson(value));
      });
    }
  }
}

class AddressCityItem{
  String dialingCode;
  String rank;
  String name;
  String levelCode;
  String code;
  String parentCode;
  String postCode;
  bool isSelected;
  AddressCityItem({this.dialingCode,this.rank,this.name,this.levelCode,this.code,this.parentCode,this.postCode,this.isSelected});
  AddressCityItem.fromJson(Map<String,dynamic> json){
    dialingCode = json["dialingCode"];
    rank = json["rank"];
    name = json["name"];
    code = json["code"];
    levelCode = json["levelCode"];
    parentCode = json["parentCode"];
    postCode = json["postCode"];
    isSelected = json["isSelected"] == "1"? true:false;
  }
}