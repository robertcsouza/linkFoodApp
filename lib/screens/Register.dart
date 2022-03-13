import 'package:flutter/material.dart';
import 'package:linkfood/assets/Colors.dart';
import 'package:linkfood/components/Inputs.dart';
import 'package:linkfood/components/buttons.dart';
import 'package:linkfood/controller/UserController.dart';
import 'package:linkfood/models/User.dart';

class Register extends StatefulWidget {
  const Register({Key? key}) : super(key: key);

  @override
  _RegisterState createState() => _RegisterState();
}

class _RegisterState extends State<Register> {
  TextEditingController _controllerName = TextEditingController();
  TextEditingController _controllerEmail = TextEditingController();
  TextEditingController _controllerSenha = TextEditingController();
  TextEditingController _controllerRepetirSenha = TextEditingController();
  TextEditingController _controllerRua = TextEditingController();
  TextEditingController _controllerNumero = TextEditingController();
  TextEditingController _controllerBairro = TextEditingController();
  TextEditingController _controllerReferencia = TextEditingController();
  UserController _userController = UserController();
  _registerUser(context) {
    User _user = User(
        name: _controllerName.text,
        street: _controllerRua.text,
        number: int.parse(_controllerNumero.text),
        district: _controllerBairro.text,
        references: _controllerReferencia.text);
    _user.email = _controllerEmail.text;
    _user.senha = _controllerSenha.text;
    _user.confirmarSenha = _controllerRepetirSenha.text;
    _userController.register(user: _user);
    Navigator.pop(context);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Container(
            width: MediaQuery.of(context).size.width,
            height: MediaQuery.of(context).size.height,
            child: SingleChildScrollView(
              child: Column(
                children: [
                  Padding(
                    padding: const EdgeInsets.only(top: 64.0),
                    child: Text(
                      'Cadastar',
                      style: TextStyle(
                          fontSize: 24,
                          color: primary,
                          fontWeight: FontWeight.bold),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(top: 8.0),
                    child: Container(
                      width: 200,
                      height: 200,
                      child: Image.asset('images/logo.png'),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(top: 8.0, bottom: 8),
                    child: input(
                        context: context,
                        lable: 'Nome',
                        obscure: false,
                        controller: _controllerName),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(top: 8.0, bottom: 8),
                    child: input(
                        context: context,
                        lable: 'email',
                        obscure: false,
                        controller: _controllerEmail),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(top: 8.0, bottom: 8),
                    child: input(
                        context: context,
                        lable: 'senha',
                        obscure: true,
                        controller: _controllerSenha),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(top: 8.0, bottom: 8),
                    child: input(
                        context: context,
                        lable: 'Confirmar Senha',
                        obscure: true,
                        controller: _controllerRepetirSenha),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(top: 8.0, bottom: 8),
                    child: Row(
                      children: [
                        Padding(
                          padding: const EdgeInsets.all(16.0),
                          child: Text(
                            'Endereço',
                            style: TextStyle(fontSize: 16),
                          ),
                        )
                      ],
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(top: 8.0, bottom: 8),
                    child: input(
                        context: context,
                        lable: 'Rua',
                        obscure: false,
                        controller: _controllerRua),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(top: 8.0, bottom: 8),
                    child: input(
                        context: context,
                        lable: 'Numero',
                        obscure: false,
                        controller: _controllerNumero),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(top: 8.0, bottom: 8),
                    child: input(
                        context: context,
                        lable: 'Bairro',
                        obscure: false,
                        controller: _controllerBairro),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(top: 8.0, bottom: 8),
                    child: input(
                        context: context,
                        lable: 'Referencia',
                        obscure: false,
                        controller: _controllerReferencia),
                  ),
                  SafeArea(
                    child: Padding(
                      padding: const EdgeInsets.only(
                          top: 16.0, left: 16.0, right: 16.0, bottom: 50),
                      child: btPrimary(
                          context: context,
                          lable: 'Cadastrar',
                          call: () {
                            _registerUser(context);
                          },
                          textStyle: TextStyle(fontSize: 18)),
                    ),
                  ),
                ],
              ),
            )));
  }
}
