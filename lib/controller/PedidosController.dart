import 'package:dio/dio.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:linkfood/models/Pedido.dart';
import 'package:shared_preferences/shared_preferences.dart';

class PedidosController {
  BaseOptions options = new BaseOptions(
    baseUrl: "http://192.168.100.9:3050",
    connectTimeout: 5000,
  );

  create({required Pedido pedido}) async {
    try {
      List products = [];
      final prefs = await SharedPreferences.getInstance();
      String? token = prefs.getString('token');
      options.headers = {'x-access-token': token};

      await Dio(options).post('/api/v1/order/create', data: pedido.toMap());

      EasyLoading.showSuccess('Pedido enviado');

      return products;
    } catch (e) {
      print(e);
      EasyLoading.showError('Nao autorizado');
      return [];
    }
  }
}
