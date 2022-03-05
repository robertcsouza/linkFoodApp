import 'package:flutter/material.dart';

class User {
  String _name = '';
  bool _isAdmin = false;
  late String _thumbnail;
  late String _street;
  late int _number;
  late String _district;
  late String _references;
  late String _email;
  late String _senha;
  late String _confirmarSenha;

  User(
      {required String name,
      required String street,
      required int number,
      required String district,
      required String references}) {
    this._name = name;
    this._street = street;
    this._number = number;
    this._district = district;
    this._references = references;
  }

  String get name => _name;

  set name(String name) {
    _name = name;
  }

  bool get isAdmin => _isAdmin;

  set isAdmin(bool isAdmin) {
    _isAdmin = isAdmin;
  }

  String get thumbnail => _thumbnail;

  set thumbnail(String thumbnail) {
    _thumbnail = thumbnail;
  }

  String get street => _street;

  set street(String street) {
    _street = street;
  }

  int get number => _number;

  set number(int number) {
    _number = number;
  }

  String get district => _district;

  set district(String district) {
    _district = district;
  }

  String get references => _references;

  set references(String references) {
    _references = references;
  }

  String get email => _email;

  set email(String email) {
    _email = email;
  }

  String get confirmarSenha => _confirmarSenha;

  set confirmarSenha(String confirmarSenha) {
    _confirmarSenha = confirmarSenha;
  }

  String get senha => _senha;

  set senha(String senha) {
    _senha = senha;
  }

  User.fromApi(dynamic response) {
    print(response);
    this._name = response.data['result']['name'];
    this.isAdmin = response.data['result']['isAdmin'];
    this._thumbnail = response.data['result']['thumbnail'];
    this._street = response.data['result']['street'];
    this._number = response.data['result']['number'];
    this._district = response.data['result']['district'];
    this._references = response.data['result']['reference'];
    this._email = response.data['result']['email'];
  }

  Map toMap() {
    Map _map = Map();
    _map = {
      'name': this._name,
      'isAdmin': false,
      'email': this._email,
      'password': this._senha,
      'passwordConfirm': this._confirmarSenha,
      'street': this._street,
      'number': this._number,
      'district': this._district,
      'reference': this._references,
    };
    return _map;
  }
}
