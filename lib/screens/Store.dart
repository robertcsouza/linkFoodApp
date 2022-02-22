import 'package:flutter/material.dart';
import 'package:linkfood/assets/Colors.dart';

class Store extends StatefulWidget {
  const Store({Key? key}) : super(key: key);

  @override
  _StoreState createState() => _StoreState();
}

class _StoreState extends State<Store> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: _body(),
    );
  }

  Widget _body() {
    return Container(
      width: MediaQuery.of(context).size.width,
      height: MediaQuery.of(context).size.height,
      child: Column(
        children: [
          Stack(
            children: [
              Container(
                width: MediaQuery.of(context).size.width,
                height: 200,
                child: Image.asset(
                  'images/dominos.png',
                  fit: BoxFit.cover,
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(top: 40.0, left: 8.0),
                child: _appBarCustom(),
              ),
            ],
          )
        ],
      ),
    );
  }

  Widget _appBarCustom() {
    return Container(
      width: MediaQuery.of(context).size.width,
      height: 50,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Padding(
            padding: const EdgeInsets.only(left: 8.0),
            child: Container(
              width: 40,
              height: 40,
              child: ClipOval(
                child: Material(
                  color: Colors.white, // Button color
                  child: InkWell(
                    splashColor: primary, // Splash color
                    onTap: () {
                      Navigator.pop(context);
                    },
                    child: SizedBox(
                        width: 40,
                        height: 40,
                        child: Icon(Icons.arrow_back_ios_new)),
                  ),
                ),
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.only(right: 8.0),
            child: Container(
              width: 40,
              height: 40,
              child: ClipOval(
                child: Material(
                  color: Colors.white, // Button color
                  child: InkWell(
                    splashColor: primary, // Splash color
                    onTap: () {
                      Navigator.pop(context);
                    },
                    child: SizedBox(
                        width: 40,
                        height: 40,
                        child: Icon(Icons.favorite_border)),
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
