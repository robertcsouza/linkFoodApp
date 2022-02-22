import 'package:flutter/material.dart';
import 'package:linkfood/assets/Colors.dart';

BottomNavigationBar bottomNavigatior({required int index}) {
  return BottomNavigationBar(
    items: const <BottomNavigationBarItem>[
      BottomNavigationBarItem(
        icon: Icon(Icons.home),
        label: 'Início',
        backgroundColor: Colors.red,
      ),
      BottomNavigationBarItem(
        icon: Icon(Icons.business),
        label: 'Pedidos',
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
      print(index);
    },
  );
}
