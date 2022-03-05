import 'package:linkfood/models/Product.dart';

class CartProducts {
  late int _quanty = 0;
  late List<Product> _productsCart = [];
  late String _restaurantId = '';
  late String _userId = '';

  String get userId => _userId;

  set userId(String userId) {
    _userId = userId;
  }

  String get restaurantId => _restaurantId;

  set restaurantId(String restaurantId) {
    _restaurantId = restaurantId;
  }

  List<Product> get productsCart => _productsCart;

  set productsCart(List<Product> productsCart) {
    _productsCart = productsCart;
  }

  int get quanty => _quanty;

  set quanty(int quanty) {
    _quanty = quanty;
  }
}
