import 'package:dio/dio.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:linkfood/models/Product.dart';
import 'package:shared_preferences/shared_preferences.dart';

class ProductController {
  BaseOptions options = new BaseOptions(
    baseUrl: "https://linkfoodapi.herokuapp.com",
    connectTimeout: 5000,
  );

  index({required String storeId}) async {
    try {
      List products = [];
      final prefs = await SharedPreferences.getInstance();
      String? token = prefs.getString('token');
      options.headers = {'x-access-token': token};

      var response = await Dio(options).get('/api/v1/product/${storeId}');

      response.data['result'].forEach((element) {
        Product _product = Product(
            id: element['_id'],
            name: element['name'],
            price: element['price'].toDouble(),
            restaurant: element['restaurant'],
            thumbnail: element['thumbnail'],
            description: element['description']);
        products.add(_product);
      });

      return products;
    } catch (e) {
      print(e);
      EasyLoading.showError('Nao autorizado');
      return [];
    }
  }
}
