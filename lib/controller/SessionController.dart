import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:get_it/get_it.dart';
import 'package:linkfood/models/User.dart';
import 'package:shared_preferences/shared_preferences.dart';

class SessionController {
  GetIt getIt = GetIt.instance;
  BaseOptions options = new BaseOptions(
    baseUrl: "http://192.168.100.9:3050",
    connectTimeout: 5000,
  );

  SessionController() {}

  login({String? email, String? password, context}) async {
    try {
      final prefs = await SharedPreferences.getInstance();
      EasyLoading.show(status: 'Caregando...');

      var response = await Dio(options).post('/api/v1/session',
          data: {'email': email, 'password': password});

      await prefs.setString('token', response.data['result']['token']);
      Future.delayed(Duration(seconds: 2), () {
        EasyLoading.showSuccess('Login efetuado com suecesso');
      });

      User user = User.fromApi(response);
      User _userIt = getIt<User>();

      _userIt.name = user.name;
      _userIt.isAdmin = user.isAdmin;
      _userIt.thumbnail = user.thumbnail;
      _userIt.street = user.street;
      _userIt.number = user.number;
      _userIt.district = user.district;
      _userIt.references = user.references;
      _userIt.email = user.email;
      _userIt.id = user.id;

      user.isAdmin == true
          ? null
          : Navigator.pushReplacementNamed(context, '/initial');
    } catch (erro) {
      Future.delayed(Duration(seconds: 2), () {
        print(erro);
        EasyLoading.showError('Nao foi possivel fazer login');
      });
    }
  }
}
