import 'package:linkfood/screens/Initial.dart';
import 'package:linkfood/screens/Perfil.dart';
import 'package:linkfood/screens/ProductDetail.dart';
import 'package:linkfood/screens/Register.dart';
import 'package:linkfood/screens/Store.dart';

routes() {
  return {
    '/register': (context) => Register(),
    '/initial': (context) => Initial(),
    '/store': (context) => Store(),
    '/perfil': (context) => Perfil(),
    '/product/detail': (context) => ProductDetail(),
  };
}
