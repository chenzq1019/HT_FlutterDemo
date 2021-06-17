import 'package:flutter/material.dart';
import 'package:flutterjdappdemo/address/AddressAdd.dart';
import 'package:flutterjdappdemo/address/AddressEdit.dart';
import 'package:flutterjdappdemo/address/AddressList.dart';
import 'package:flutterjdappdemo/pages/login/Login.dart';
import 'package:flutterjdappdemo/pages/login/RegisterFirst.dart';
import 'package:flutterjdappdemo/pages/login/RegisterSecond.dart';
import 'package:flutterjdappdemo/pages/login/RegisterThird.dart';
import 'package:flutterjdappdemo/pages/productContent/CheckOut.dart';
import 'package:flutterjdappdemo/pages/productContent/Order.dart';
import 'package:flutterjdappdemo/pages/productContent/OrderInfo.dart';
import 'package:flutterjdappdemo/pages/productContent/Pay.dart';
import 'package:flutterjdappdemo/pages/productContent/ProductContent.dart';
import 'package:flutterjdappdemo/pages/tabs/Cart.dart';
import 'package:flutterjdappdemo/pages/tabs/ProductList.dart';
import 'package:flutterjdappdemo/pages/tabs/Search.dart';
import 'package:flutterjdappdemo/pages/tabs/Tabs.dart';

//配置路由
final routes = {
  '/': (context) => Tabs(),
  '/cart':(context) => CartPage(),
  '/login':(context) => LoginPage(),
  '/registerFirst':(context) => RegisterFirstPage(),
  '/registerSecond': (context,{arguments}) => RegisterSecondPage(arguments: arguments),
  '/registerThird':(context,{arguments}) => RegisterThirdPage(arguments: arguments),
  '/search': (context) => SearchPage(),
  '/productList': (context,{arguments}) => ProductListPage(arguments:arguments),
  '/productContent': (context,{arguments}) => ProductContentPage(arguments:arguments),
  '/checkOut': (context) => CheckOutPage(),
  '/addressAdd': (context) => AddressAddPage(),
  '/addressEdit': (context,{arguments}) => AddressEditPage(arguments:arguments),
  '/addressList': (context) => AddressListPage(),
  '/pay': (context) => PayPage(),
  '/order': (context) => OrderPage(),
  '/orderinfo': (context) => OrderInfoPage(),
};

//固定写法
var onGenerateRoute = (RouteSettings settings) {
// 统一处理
  final String name = settings.name;
  final Function pageContentBuilder = routes[name];
  if (pageContentBuilder != null) {
    if (settings.arguments != null) {
      final Route route = MaterialPageRoute(
          builder: (context) =>
              pageContentBuilder(context, arguments: settings.arguments));
      return route;
    } else {
      final Route route =
      MaterialPageRoute(builder: (context) => pageContentBuilder(context));
      return route;
    }
  }
};
