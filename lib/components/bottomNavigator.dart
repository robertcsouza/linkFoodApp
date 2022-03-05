import 'package:flutter/material.dart';
import 'package:linkfood/assets/Colors.dart';

_redirect(index, context) {
  switch (index) {
    case 0:
      Navigator.pushNamed(context, '/initial');
      break;
    case 1:
      Navigator.pushNamed(context, '/cart');
      break;
    case 2:
      Navigator.pushNamed(context, '/perfil');
      break;
    default:
  }
}

BottomNavigationBar bottomNavigatior({required int index, required context}) {
  return BottomNavigationBar(
    items: const <BottomNavigationBarItem>[
      BottomNavigationBarItem(
        icon: Icon(Icons.home),
        label: 'Início',
        backgroundColor: Colors.red,
      ),
      BottomNavigationBarItem(
        icon: Icon(Icons.shopping_cart),
        label: 'Carrinho',
        backgroundColor: Colors.green,
      ),
      BottomNavigationBarItem(
        icon: Icon(Icons.school),
        label: 'Perfil',
        backgroundColor: Colors.white,
      ),
    ],
    currentIndex: index,
    selectedItemColor: primary,
    onTap: (index) {
      _redirect(index, context);
    },
  );
}
