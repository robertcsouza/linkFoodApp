import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:linkfood/models/User.dart';

class SessionController {
  BaseOptions options = new BaseOptions(
    baseUrl: "http://192.168.100.9:3050",
    connectTimeout: 5000,
  );

  SessionController() {}

  login({String? email, String? password, context}) async {
    try {
      EasyLoading.show(status: 'Caregando...');

      var response = await Dio(options).post('/api/v1/session',
          data: {'email': email, 'password': password});

      Future.delayed(Duration(seconds: 2), () {
        EasyLoading.showSuccess('Login efetuado com suecesso');
      });

      User user = User.fromApi(response);

      user.isAdmin == true
          ? null
          : Navigator.pushReplacementNamed(context, '/initial');
    } catch (erro) {
      Future.delayed(Duration(seconds: 2), () {
        EasyLoading.showError('Nao foi possivel fazer login');
      });
    }
  }
}
