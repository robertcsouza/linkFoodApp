import 'dart:io';

import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:get_it/get_it.dart';
import 'package:linkfood/models/User.dart';
import 'package:shared_preferences/shared_preferences.dart';

class UserController {
  GetIt getIt = GetIt.instance;
  BaseOptions options = new BaseOptions(
    baseUrl: "http://192.168.100.9:3050",
    connectTimeout: 5000,
  );

  UserController() {}

  register({required User user, context}) async {
    try {
      EasyLoading.show(status: 'Caregando...');
      await Dio(options).post('/api/v1/user/create', data: user.toMap());

      EasyLoading.showSuccess('Usuario Cadastrado com suecesso');
    } catch (erro) {
      Future.delayed(Duration(seconds: 2), () {
        EasyLoading.showError('Nao foi possivel Cadastrar Usuario');
      });
    }
  }

  uploadThumbnail({required File file, required String fileName}) async {
    try {
      EasyLoading.show(status: 'Caregando...');
      final prefs = await SharedPreferences.getInstance();
      String? token = prefs.getString('token');
      options.headers = {
        'x-access-token': token,
        'Content-Type': 'multipart/form-data'
      };

      Dio dio = new Dio(options);

      FormData formData = new FormData.fromMap({
        'file': await MultipartFile.fromFile(file.path, filename: fileName)
      });
      var response = await dio.post('/api/v1/user/thumbnail/', data: formData);
      getIt<User>().thumbnail = response.data['result']['msg'];
      EasyLoading.showSuccess('Imagem atualizada');
    } catch (erro) {
      Future.delayed(Duration(seconds: 2), () {
        print(erro);
        EasyLoading.showError('Nao foi possivel Atualizar Imagem');
      });
    }
  }
}
