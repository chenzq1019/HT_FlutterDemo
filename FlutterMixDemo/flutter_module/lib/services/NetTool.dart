import 'package:flutter/material.dart';
import 'dart:convert';
import 'package:dio/dio.dart';
import 'package:flutter_module/Model/base_model.dart';
/// 自定义枚举
enum Method {
  get,
  post
}

class Net{
  // 工厂模式
  factory Net() => _getInstance();
  static Net get instance => _getInstance();
  static Net _instance;

  Dio dio;
  Net._internal() {
    // 初始化
    dio = Dio(BaseOptions(
      connectTimeout: 60000,   // 连接服务器超时时间，单位是毫秒.
      receiveTimeout: 10000,   // 响应流上前后两次接受到数据的间隔，单位为毫秒, 这并不是接收数据的总时限.
    )
    );
    dio.options.headers["appkey"] = "b9563a085baedf51";
    dio.options.headers["client_type"] = "ule";
    dio.options.headers["market_id"] = "015";
    dio.options.headers["session_id"] = "41836e9330962ab71ba56082f8607f4e2968f366";
    dio.options.headers["user_token"] = "730bf6bccce3456f93a1e89056bc1c86";
  }
  // 单列模式
  static Net _getInstance() {
    if (_instance == null){
      _instance = Net._internal();
    }
    return _instance;
  }

  get(String url, Map<String,dynamic> params, {Function success,Function failure}){
    _doRequest(url, params, Method.get, success, failure);
  }

  post(String url, Map<String,dynamic> params, {Function success,Function failure}){
    _doRequest(url, params, Method.post, success, failure);
  }

  void _doRequest(String url, Map<String,dynamic> params ,Method method, Function successCallBack, Function failureCallBack) async{
    try{
      /// 可以添加header
      //  dio.options.headers.addAll({'token':xxx});
      Response response;
      switch (method){
        case Method.get:
          if (params != null && params.isNotEmpty){
            response = await dio.get(url,queryParameters: params);
          }else {
            response = await dio.get(url);
          }
          break;
        case Method.post:
          if (params != null && params.isNotEmpty){
            response = await dio.post(url,queryParameters: params);
          }else {
            response = await dio.post(url);
          }
          break;
      }
      Map<String, dynamic> result= jsonDecode(response.data) as Map<String, dynamic>;
//      Map<String, dynamic> result = json.decode(response.toString());
      // 打印信息
      print('''api: $url\nparams: $params\nresult: $result''');
      // 转化为model
//      BaseModel model = BaseModel.fromJson(result);
//      if (model.code == 200){ // 200 请求成功
//        if (successCallBack != null){//返回请求数据
//          successCallBack(model.data);
//        }
//      }else {
//        //TODO
//        //直接使用Toast弹出错误信息
//        //返回失败信息
//        if (failureCallBack != null){
//          failureCallBack(model.error);
//        }
//      }
      // 不转model直接返回
      if(successCallBack!=null){
        successCallBack(result);
      }
    }catch (exception){
      print('错误：${exception.toString()}');
//      Fluttertoast.showToast(msg: "请求失败，请稍后再试");
//      ScaffoldMessenger.maybeOf(context).showSnackBar(SnackBar(content: Text("请求失败，请稍后再试")));
      if (failureCallBack != null){
        failureCallBack(exception.toString());
      }
    }
  }

//// 上传文件（图片）
//  doUploadFile(String url, File file, String loadingText,Function successCallBack,
//      Function failureCallBack) async {
//    try {
//      String timeStamp = DateTime.now().millisecondsSinceEpoch.toString();
//      FormData formData = FormData.from({
//        'file': UploadFileInfo(file, '$timeStamp.jpg',
//            contentType: ContentType.parse("image/jpeg"))
//      });
//      Response response = await dio.post(url, data: formData);
//      print('$response'); // 在需要生成model时需要json格式
//      Map<String, dynamic> result = json.decode(response.toString());
//      assert(() {
//        // assert只会在debug模式下执行，release模式下不会执行
//        // 打印信息
//        print('''api: $url\nresult: $result''');
//        return true;
//      }());
//
//      BaseModel model = BaseModel.fromJson(result);
//      if (model.code == 200) {
//        // 200 请求成功
//        if (successCallBack != null) {
//          if (model.data != null) {
//            successCallBack(model.data);
//          } else {
//            successCallBack({});
//          }
//        }
//      } else {
//        //Fluttertoast.showToast(msg: "${model.msg}");
//        if (failureCallBack != null) {
//          failureCallBack(model.msg);
//        }
//      }
//    } catch (exception) {
//      assert(() {
//        // 打印信息
//        print('''api: $url\n错误：${exception.toString()}''');
//        return true;
//      }());
//
//      //  Fluttertoast.showToast(msg: '加载失败');
//      if (failureCallBack != null) {
//        failureCallBack(exception.toString());
//      }
//    }
//  }

}