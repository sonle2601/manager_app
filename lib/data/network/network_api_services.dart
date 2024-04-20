
import 'dart:convert';
import 'dart:developer';
import 'dart:io';


import 'package:flutter/foundation.dart';
import 'package:http/http.dart' as http;

import '../../exception/app_exceptions.dart';
import '../../view_models/user_prefrence_view_model.dart';
import 'base_api_services.dart';

class NetworkApiServices extends BaseApiServices{
  UserPreference _userPreference = UserPreference();

  @override
  Future getApi(String url) async {
    if(kDebugMode){
      print(url);
    }
    dynamic responseJson;
    try{
      final response = await http.get(
          Uri.parse(url),
          headers: await _getHeaders()).timeout(const Duration(seconds: 10)
      );
      responseJson = returnResponse(response);


    } on SocketException {
      throw InternetException('');
    } on RequestTimeOut {
      throw RequestTimeOut('');
    }
    return responseJson;
  }

  var data1 = {
    'part_description': '',
    'part_name': 'Quet',
    'part_status': 0
  };



  @override
  Future<dynamic> postApi(var data, String url) async {
    if(kDebugMode){
      print(url);
      print(data);
    }
    dynamic responseJson;
    try{
      final response = await http.post(
        Uri.parse(url),
        body: json.encode(data),
        headers: {
          'Content-Type': 'application/json',
          ...await _getHeaders(),
        },
      ).timeout(const Duration(seconds: 10));
    responseJson = returnResponse(response);
    } on SocketException catch (e) {
      print('SocketException: $e');
      throw InternetException('');
    } on RequestTimeOut {
      throw RequestTimeOut('');
    }
    return responseJson;
  }

  @override
  Future<dynamic> putApi(var data, String url) async {
    if (kDebugMode) {
      print(url);
      print(data);
    }
    dynamic responseJson;
    try {
      final response = await http.put(
        Uri.parse(url),
        body: json.encode(data),
        headers: {
          'Content-Type': 'application/json',
          ...await _getHeaders(),
        },
      ).timeout(const Duration(seconds: 10));

      responseJson = returnResponse(response);
    } on SocketException catch (e) {
      print('SocketException: $e');
      throw InternetException('');
    } on RequestTimeOut {
      throw RequestTimeOut('');
    }
    return responseJson;
  }

  @override
  Future<dynamic> deleteApi(String url) async {
    if (kDebugMode) {
      print(url);
    }
    dynamic responseJson;
    try {
      final response = await http.delete(
        Uri.parse(url),
        headers: await _getHeaders(),
      ).timeout(const Duration(seconds: 10));
      responseJson = returnResponse(response);
    } on SocketException {
      throw InternetException('');
    } on RequestTimeOut {
      throw RequestTimeOut('');
    }
    return responseJson;
  }



  dynamic returnResponse(http.Response response){
    print("hi"+response.statusCode.toString());

    switch(response.statusCode){
      case 200:
      case 201:
        dynamic responseJson = jsonDecode(response.body);
        return responseJson;
      // case 401:
      //   throw InvalidUrlException();
      default:
        print(response.body);
      throw response.statusCode;
    }
  }


  Future<Map<String, String>> _getHeaders() async {
    final token = await getTokenFromLocalStorage();
    // print('token'+token.toString());
    return {'Authorization': 'Bearer $token'};
  }

  Future<String?> getTokenFromLocalStorage() async {
    return await _userPreference.getToken();
  }


}