import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:dio_sample/interceptors/dio_interceptor.dart';
import 'package:dio_sample/services/store.dart';

class DemoAPI {
  late final Dio _dio;

  DemoAPI() {
    _dio = Dio();
    _dio.interceptors.add(DioInterceptor());
  }

  final String _registerUrl =
      "http://restapi.adequateshop.com/api/authaccount/registration";

  final String _loginUrl =
      "http://restapi.adequateshop.com/api/authaccount/login";

  final String _dataUrl = "http://restapi.adequateshop.com/api/users?page=1";

  Map<String, dynamic> get _loginData => {
        "email": "neerajraut@gmail.com",
        "password": "123456",
      };

  Map<String, dynamic> get _resistrationData => {
        "name": "Developer",
        "email": "Developer5@gmail.com",
        "password": 123456
      };

  Future<void> _saveToken(Map<String, dynamic> data) async {
    debugPrint("$data");
    final token = data['data']['Token'];
    await Store.setToken(token);
  }

  String _getResult(Map<String, dynamic> json) {
    debugPrint("data received is $json");
    final List<dynamic> list = json['data'];
    return 'Received ${list.length} objects';
  }

  Future<bool> dioLogin() async {
    final response = await _dio.post(_loginUrl, data: _loginData);

    if (response.statusCode == 200) {
      await _saveToken(response.data);
      return true;
    }
    return false;
  }

  Future<String> dioGetData() async {
    try {
      final response = await _dio.get(_dataUrl);
      if (response.statusCode == 200) {
        return _getResult(response.data);
      }
      return response.data as String;
    } on DioError catch (e) {
      return e.response?.data ?? 'Error occured';
    }
  }
}
