import 'package:linkfood/screens/Initial.dart';
import 'package:linkfood/screens/Register.dart';
import 'package:linkfood/screens/Store.dart';

routes() {
  return {
    '/register': (context) => Register(),
    '/initial': (context) => Initial(),
    '/store': (context) => Store(),
  };
}
