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

  bool toggle = false;

  Widget _body() {
    return Container(
      width: MediaQuery.of(context).size.width,
      height: MediaQuery.of(context).size.height,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
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
          ),
          Padding(
            padding: const EdgeInsets.only(top: 32.0, left: 16),
            child: _customerInfo(),
          ),
          Padding(
            padding: const EdgeInsets.only(left: 16.0, top: 16.0),
            child: Text(
              'Produtos',
              style: TextStyle(fontSize: 18),
            ),
          ),
          _listProducts()
        ],
      ),
    );
  }

  Widget _listProducts() {
    return Expanded(
        child: ListView.builder(
      itemCount: 5,
      itemBuilder: (context, index) {
        return _cardProducts();
      },
    ));
  }

  Widget _cardProducts() {
    return Padding(
      padding: const EdgeInsets.all(4.0),
      child: Container(
          width: MediaQuery.of(context).size.width,
          height: 100,
          child: ListTile(
            onTap: () {
              Navigator.pushNamed(context, '/product/detail');
            },
            leading: ClipRRect(
                borderRadius: BorderRadius.all(Radius.circular(10)),
                child: Container(
                    width: 90,
                    height: 90,
                    child: Image.asset('images/pizza.jpg'))),
            title: Padding(
              padding: const EdgeInsets.only(top: 8.0),
              child: Text(
                'Pizza Calabresa Grande',
                style: TextStyle(
                    fontWeight: FontWeight.bold, color: Colors.grey[800]),
              ),
            ),
            subtitle: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Text('Mussarela,Calabresa,requeijão,cebola,azeite')),
                Text(
                  'R\$ 39.90',
                  style: TextStyle(color: primary, fontWeight: FontWeight.bold),
                )
              ],
            ),
          )),
    );
  }

  Widget _customerInfo() {
    return Container(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: const EdgeInsets.all(4.0),
            child: Text(
              'Dominos Pizzaria',
              style: TextStyle(fontSize: 18),
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(4.0),
            child: Text(
              '30-40 min   R\$ 7.00',
              style: TextStyle(fontSize: 18),
            ),
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
                        child: Icon(
                          Icons.arrow_back_ios_new,
                          color: primary,
                        )),
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
                      setState(() {
                        toggle = !toggle;
                      });
                    },
                    child: SizedBox(
                        width: 40,
                        height: 40,
                        child: Icon(
                          toggle != false
                              ? Icons.favorite_border
                              : Icons.favorite,
                          color: primary,
                        )),
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
