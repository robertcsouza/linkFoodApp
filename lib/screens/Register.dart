import 'package:flutter/material.dart';
import 'package:linkfood/assets/Colors.dart';
import 'package:linkfood/components/Inputs.dart';
import 'package:linkfood/components/buttons.dart';

class Register extends StatefulWidget {
  const Register({Key? key}) : super(key: key);

  @override
  _RegisterState createState() => _RegisterState();
}

class _RegisterState extends State<Register> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: SingleChildScrollView(
      child: Container(
          width: MediaQuery.of(context).size.width,
          height: MediaQuery.of(context).size.height,
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
                child: input(context: context, lable: 'Nome'),
              ),
              Padding(
                padding: const EdgeInsets.only(top: 8.0, bottom: 8),
                child: input(context: context, lable: 'email'),
              ),
              Padding(
                padding: const EdgeInsets.only(top: 8.0, bottom: 8),
                child: input(context: context, lable: 'senha'),
              ),
              input(context: context, lable: 'Confirmar Senha'),
              Padding(
                padding:
                    const EdgeInsets.only(top: 16.0, left: 16.0, right: 16.0),
                child: btPrimary(
                    context: context,
                    lable: 'Cadastrar',
                    call: () {},
                    textStyle: TextStyle(fontSize: 18)),
              ),
            ],
          )),
    ));
  }
}
