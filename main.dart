import 'dart:convert';
import 'dart:io';

import 'package:dio/dio.dart';
import 'package:flutter/material.dart';

import 'package:jsoncomplex/Model/RestModel.dart';


//do not used in production mode
class MyHttpOverrides extends HttpOverrides{
  @override
  HttpClient createHttpClient(SecurityContext? context){
    return super.createHttpClient(context)
      ..badCertificateCallback = (X509Certificate cert, String host, int port)=> true;
  }
}

void main() {
  HttpOverrides.global = MyHttpOverrides();
  runApp(MyApp());
}

class NetHelper {
  // Future<RestModel> getData() async {
  //   print("net 1");
  //   Response response = await http.get(Uri.parse("https://hadescrypto.000webhostapp.com/complexjson.json"));
  //   print(jsonDecode(response.body));
  //   return  RestModel.fromJson(jsonDecode(response.body));
  // }

  // Future<RestModel?> getData() async {
  //   RestModel rmodel;
  //   try {
  //     var response = await Dio().get(
  //         "https://hadescrypto.000webhostapp.com/complexjson.json");
  //     print(response.data);
  //     rmodel = RestModel.fromJson(response.data);
  //   } on DioError catch (e) {
  //     print(e);
  //   }
  //   return rmodel;
  // }

  Future<RestModel?> getData() async {
    RestModel? user;
    try {
      Response userData = await  Dio().get("https://hadescrypto.000webhostapp.com/complexjson.json");
      print('User Info: ${userData.data}');
      user = RestModel.fromJson(userData.data);
    } on DioError catch (e) {
      // The request was made and the server responded with a status code
      // that falls out of the range of 2xx and is also not 304.
      if (e.response != null) {
        print('Dio error!');
        print('STATUS: ${e.response?.statusCode}');
        print('DATA: ${e.response?.data}');
        print('HEADERS: ${e.response?.headers}');
      } else {
        // Error due to setting up or sending the request
        print('Error sending request!');
        print(e.message);
      }
    }
    return user;
  }


  //dio post
 sendData() async {
    var formData = FormData.fromMap({
      "username" : "tompok",
      "password" : "123456"
    });
    try {
      Response userData = await  Dio().post("https://fooddelivery.globizsapp.com/api/site/login",
     data: formData,
      );
      print('User Info: ${userData.data}');

    } on DioError catch (e) {
      // The request was made and the server responded with a status code
      // that falls out of the range of 2xx and is also not 304.
      if (e.response != null) {
        print('Dio error!');
        print('STATUS: ${e.response?.statusCode}');
        print('DATA: ${e.response?.data}');
        print('HEADERS: ${e.response?.headers}');
      } else {
        // Error due to setting up or sending the request
        print('Error sending request!');
        print(e.message);
      }
    }
  }

  sendDataWithHeader() async {
    var formData = FormData.fromMap({
      "username" : "tompok",
      "password" : "123456"
    });
    try {
      Response userData = await  Dio().post("https://fooddelivery.globizsapp.com/api/restaurantapp/orderlist",options: Options(
          headers: {
            "Token" : "r8sRWL7TK_gOpZtSHP-_HPjBqsHUJWMg",
          }
      )
      );
      print('User Info: ${userData.data}');

    } on DioError catch (e) {
      // The request was made and the server responded with a status code
      // that falls out of the range of 2xx and is also not 304.
      if (e.response != null) {
        print('Dio error!');
        print('STATUS: ${e.response?.statusCode}');
        print('DATA: ${e.response?.data}');
        print('HEADERS: ${e.response?.headers}');
      } else {
        // Error due to setting up or sending the request
        print('Error sending request!');
        print(e.message);
      }
    }

  }
}

class MyApp extends StatelessWidget {

  NetHelper netHelper = NetHelper();
 getD()async{
   final response = await netHelper.getData();
   RestModel? _response = response;
   print(_response?.name);
   print(_response?.cuisine);
   print(_response?.reviews[0].score);
   print(_response?.reviews[1].score);

 }
 sendD()async{
   final response = await netHelper.sendData();

 }
 sendDH()async{
   final response = await netHelper.sendDataWithHeader();

 }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        body: Center(
          child: Column(
            children: [
              ElevatedButton(
                onPressed: (){
                  getD();
                },
                child: Text("restult"),
              ),
              ElevatedButton(
                onPressed: (){
                  sendD();
                },
                child: Text("send"),
              ),ElevatedButton(
                onPressed: (){
                  sendDH();
                },
                child: Text("send"),
              ),
            ],
          )
        ),
      ),
    );
  }
}
