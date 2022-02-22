import 'package:flutter/material.dart';
import 'package:linkfood/components/Inputs.dart';
import 'assets/Colors.dart' as projectColor;

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: MyHomePage(title: 'Flutter Demo Home Page'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  MyHomePage({Key? key, required this.title}) : super(key: key);

  final String title;

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Container(
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
                  padding: const EdgeInsets.only(top: 50.0, bottom: 32),
                  child: input(context: context, lable: 'email'),
                ),
                input(context: context, lable: 'senha'),
                btPrimary(context: context, lable: 'Entrar', call: _ca())
              ],
            )));
  }

  String _ca() {
    print('debug');
    return 'deubg';
  }

  Widget btPrimary({context, String? lable, call}) {
    return Container(
        width: MediaQuery.of(context).size.width,
        height: 50,
        child: ElevatedButton(
            onPressed: () {
              call();
            },
            child: Text('Entar')));
  }
}
