import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:linkfood/assets/Colors.dart';
import 'package:linkfood/models/Product.dart';
import 'package:linkfood/models/Restaurant.dart';
import 'package:shared_preferences/shared_preferences.dart';

class ProductDetail extends StatefulWidget {
  late Restaurant restaurant;
  late Product product;
  ProductDetail({Restaurant? restaurant, Product? product}) {
    this.restaurant = restaurant!;
    this.product = product!;
  }

  @override
  _ProductDetailState createState() => _ProductDetailState();
}

class _ProductDetailState extends State<ProductDetail> {
  List<String>? _cart = [];
  double _totalProduct = 0;
  _increment(int quantity) {
    _totalProduct = (widget.product.price * quantity);
  }

  _setOnCart(
      {required Product product,
      required int quanty,
      required Restaurant restaurant}) async {
    final prefs = await SharedPreferences.getInstance();

    _cart = await prefs.getStringList('cart') != null
        ? prefs.getStringList('cart')
        : [];

    Map productTocart = {
      'product': product.id,
      'quanty': quanty,
      'restaurant': restaurant.id
    };
    String productToSave = jsonEncode(productTocart);
    _cart!.add(productToSave);
    prefs.setStringList('cart', _cart!);

    EasyLoading.showSuccess('Produto adicionado no carrinho');
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();

    _totalProduct = widget.product.price;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: _body(),
    );
  }

  bool toggle = false;
  int quant = 1;
  Widget _body() {
    return Container(
      width: MediaQuery.of(context).size.width,
      height: MediaQuery.of(context).size.height,
      child: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Stack(
              children: [
                Container(
                  width: MediaQuery.of(context).size.width,
                  height: 200,
                  child: Image.asset(
                    'images/pizza.jpg',
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
              padding: const EdgeInsets.only(left: 32.0, top: 32.0),
              child: Text(
                'R\$ ${widget.product.price.toStringAsFixed(2)}',
                style: TextStyle(
                    fontSize: 18, fontWeight: FontWeight.bold, color: primary),
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(28.0),
              child: _generalInfos(),
            ),
            _observation(),
            _addProduct()
          ],
        ),
      ),
    );
  }

  Widget _addProduct() {
    return Container(
      width: MediaQuery.of(context).size.width,
      height: 70,
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Padding(
            padding: const EdgeInsets.only(
              left: 32.0,
            ),
            child: Container(
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(10),
                border: Border.all(
                  color: Colors.black,
                  width: 0.5,
                ),
              ),
              child: Row(
                children: [
                  IconButton(
                      onPressed: () {
                        setState(() {
                          quant <= 1 ? quant = 1 : quant--;
                          _increment(quant);
                        });
                      },
                      icon: Icon(
                        Icons.remove,
                        size: 32,
                        color: primary,
                      )),
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Text(
                      quant.toString(),
                      style: TextStyle(
                        fontSize: 18,
                      ),
                    ),
                  ),
                  IconButton(
                      onPressed: () {
                        setState(() {
                          quant++;
                          _increment(quant);
                        });
                      },
                      icon: Icon(
                        Icons.add,
                        size: 32,
                        color: primary,
                      )),
                ],
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.only(right: 8.0),
            child: Container(
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.all(Radius.circular(20))),
                width: 200,
                height: 50,
                child: ElevatedButton(
                  onPressed: () {
                    _setOnCart(
                        product: widget.product,
                        quanty: quant,
                        restaurant: widget.restaurant);
                  },
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [Text('Adicionar'), Text('R\$ ${_totalProduct}')],
                  ),
                  style: ButtonStyle(
                      backgroundColor:
                          MaterialStateProperty.all<Color>(primary)),
                )),
          )
        ],
      ),
    );
  }

  Widget _observation() {
    return Container(
      width: MediaQuery.of(context).size.width,
      height: 130,
      child: Column(
        children: [
          Padding(
            padding: const EdgeInsets.only(left: 32.0, top: 8.0),
            child: Row(
              children: [
                Icon(Icons.message),
                Padding(
                  padding: const EdgeInsets.only(left: 8.0),
                  child: Text('Alguma Observação?'),
                )
              ],
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: TextField(
              decoration: InputDecoration(
                  labelText: 'Ex: tirar cebola, maionese exra ...',
                  enabledBorder: OutlineInputBorder(
                    borderSide: const BorderSide(
                      width: 1.0,
                    ),
                    borderRadius: BorderRadius.circular(15),
                  ),
                  focusedBorder: OutlineInputBorder(
                    borderSide: const BorderSide(width: 1, color: Colors.green),
                    borderRadius: BorderRadius.circular(10),
                  )),
            ),
          ),
        ],
      ),
    );
  }

  Widget _generalInfos() {
    return Container(
      width: MediaQuery.of(context).size.width,
      height: 100,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(10),
        border: Border.all(
          color: Colors.black,
          width: 0.5,
        ),
      ),
      child: Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Padding(
                padding: const EdgeInsets.only(left: 16.0),
                child: Text(widget.restaurant.name,
                    style: TextStyle(fontSize: 16)),
              ),
              Padding(
                padding: const EdgeInsets.all(16.0),
                child: Row(
                  children: [
                    Icon(
                      Icons.star,
                      color: Colors.amber,
                      size: 24,
                    ),
                    Text(
                      '4.6',
                      style: TextStyle(color: Colors.amber, fontSize: 16),
                    ),
                  ],
                ),
              )
            ],
          ),
          Padding(
            padding: const EdgeInsets.only(left: 16.0, right: 16.0),
            child: Divider(
              height: 1.0,
            ),
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Padding(
                padding: const EdgeInsets.only(left: 16.0),
                child: Text(widget.restaurant.duration,
                    style: TextStyle(fontSize: 16)),
              ),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Text(
                  'R\$ ${widget.restaurant.freight.toStringAsFixed(2)}',
                  style: TextStyle(fontSize: 16),
                ),
              )
            ],
          ),
        ],
      ),
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
              widget.product.name,
              style: TextStyle(fontSize: 20),
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Text(
              widget.product.description,
              style: TextStyle(fontSize: 16),
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
        ],
      ),
    );
  }
}
