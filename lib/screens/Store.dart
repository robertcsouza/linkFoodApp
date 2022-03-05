import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:linkfood/assets/Colors.dart';
import 'package:linkfood/controller/ProductController.dart';
import 'package:linkfood/models/Product.dart';
import 'package:linkfood/models/Restaurant.dart';
import 'package:linkfood/screens/ProductDetail.dart';

class Store extends StatefulWidget {
  late Restaurant restaurant;
  Store({required Restaurant rest}) {
    this.restaurant = rest;
  }

  @override
  _StoreState createState() => _StoreState();
}

class _StoreState extends State<Store> {
  late Restaurant _restaurant;
  ProductController _productController = ProductController();
  late Future productFuture;
  List products = [];

  _callRoute({Restaurant? restaurant, Product? product}) {
    Navigator.push(
      context,
      MaterialPageRoute(
          builder: (context) => ProductDetail(
                restaurant: restaurant,
                product: product,
              )),
    );
  }

  @override
  void initState() {
    super.initState();
    _restaurant = widget.restaurant;

    productFuture = _productController.index(storeId: _restaurant.id);
  }

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
                child: CachedNetworkImage(
                  imageUrl: _restaurant.thumbnail,
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
    return FutureBuilder(
        future: productFuture,
        builder: (context, AsyncSnapshot snapshot) {
          if (ConnectionState.waiting == snapshot.connectionState) {
            EasyLoading.show();
            return SizedBox();
          } else {
            EasyLoading.dismiss();
            products = snapshot.data;
            return Expanded(
                child: ListView.builder(
              itemCount: products.length,
              itemBuilder: (context, index) {
                return _cardProducts(products[index]);
              },
            ));
          }
        });
  }

  Widget _cardProducts(Product product) {
    return Padding(
      padding: const EdgeInsets.all(4.0),
      child: Container(
          width: MediaQuery.of(context).size.width,
          height: 100,
          child: ListTile(
            onTap: () {
              _callRoute(product: product, restaurant: widget.restaurant);
            },
            leading: ClipRRect(
                borderRadius: BorderRadius.all(Radius.circular(10)),
                child: Container(
                    width: 90,
                    height: 90,
                    child: CachedNetworkImage(imageUrl: product.thumbnail))),
            title: Padding(
              padding: const EdgeInsets.only(top: 8.0),
              child: Text(
                product.name,
                style: TextStyle(
                    fontWeight: FontWeight.bold, color: Colors.grey[800]),
              ),
            ),
            subtitle: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Text(product.description)),
                Text(
                  'R\$ ${product.price}',
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
              _restaurant.name,
              style: TextStyle(fontSize: 18),
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(4.0),
            child: Text(
              '${_restaurant.duration}   R\$ ${_restaurant.freight.toStringAsFixed(2)}',
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
