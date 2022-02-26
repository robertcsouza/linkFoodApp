import 'package:dio/dio.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';

class SessionController {
  BaseOptions options = new BaseOptions(
    baseUrl: "http://192.168.100.9:3050",
    connectTimeout: 5000,
  );

  SessionController() {}

  login({String? email, String? password}) async {
    try {
      EasyLoading.show(status: 'Caregando...');

      var response = await Dio(options).post('/api/v1/session',
          data: {'email': email, 'password': password});

      Future.delayed(Duration(seconds: 2), () {
        EasyLoading.showSuccess('Login efetuado com suecesso');
      });
      return response.data;
    } catch (erro) {
      Future.delayed(Duration(seconds: 2), () {
        EasyLoading.showError('Nao foi possivel fazer login');
      });
    }
  }
}
