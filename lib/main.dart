import 'package:linkfood/config/Routes.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import '../assets/Colors.dart' as projectColor;
import 'package:flutter/material.dart';
import 'package:linkfood/components/Inputs.dart';
import 'components/buttons.dart';
import 'controller/SessionController.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        title: 'Link Food',
        initialRoute: '/',
        routes: routes(),
        theme: ThemeData(primarySwatch: Colors.green, accentColor: Colors.blue),
        home: MyHomePage(title: 'Link Food'),
        builder: EasyLoading.init());
  }
}

class MyHomePage extends StatefulWidget {
  MyHomePage({Key? key, required this.title}) : super(key: key);

  final String title;

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  SessionController _sessionController = SessionController();
  TextEditingController _email = TextEditingController();
  TextEditingController _password = TextEditingController();

  void _callRegister({required context}) {
    Navigator.pushNamed(context, '/register');
  }

  void _callInitial({required context}) {
    Navigator.pushReplacementNamed(context, '/initial');
  }

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
                padding: const EdgeInsets.only(top: 128.0),
                child: Container(
                  width: 200,
                  height: 200,
                  child: Image.asset('images/logo.png'),
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(top: 32.0, bottom: 16),
                child: input(
                    context: context,
                    lable: 'email',
                    controller: _email,
                    obscure: false),
              ),
              input(
                  context: context,
                  lable: 'senha',
                  controller: _password,
                  obscure: true),
              Padding(
                padding:
                    const EdgeInsets.only(top: 64.0, left: 16.0, right: 16.0),
                child: btPrimary(
                    context: context,
                    lable: 'Login',
                    call: () {
                      //_callInitial(context: context);
                      _sessionController.login(
                          email: _email.text,
                          password: _password.text,
                          context: context);
                    },
                    textStyle: TextStyle(fontSize: 18)),
              ),
              btText(
                  lable: 'Cadastre-se',
                  call: () {
                    _callRegister(context: context);
                  },
                  textStyle: TextStyle(
                      color: projectColor.primary,
                      fontSize: 16,
                      fontWeight: FontWeight.bold))
            ],
          )),
    ));
  }
}
