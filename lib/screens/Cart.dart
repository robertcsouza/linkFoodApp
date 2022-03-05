import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:get_it/get_it.dart';
import 'package:linkfood/assets/Colors.dart';
import 'package:linkfood/components/buttons.dart';
import 'package:linkfood/controller/PedidosController.dart';
import 'package:linkfood/models/CartProducts.dart';
import 'package:linkfood/models/Pedido.dart';
import 'package:linkfood/models/Product.dart';
import 'package:linkfood/models/User.dart';

class Cart extends StatefulWidget {
  const Cart({Key? key}) : super(key: key);

  @override
  State<Cart> createState() => _CartState();
}

class _CartState extends State<Cart> {
  GetIt getIt = GetIt.instance;
  List<Product> _listproduct = [];
  List<String> _productsOrder = [];
  PedidosController _pedidosController = PedidosController();
  late User _user;
  double _total = 0;
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _listproduct = getIt<CartProducts>().productsCart;
    _user = getIt<User>();
    _calculateTotal();
  }

  _makeOrder() {
    _listproduct.forEach((element) {
      _productsOrder.add(element.id);
    });
    Pedido _pedido = Pedido(
        user: getIt<User>().id,
        restaurant: getIt<CartProducts>().restaurantId,
        products: _productsOrder,
        total: _total);

    _pedidosController.create(pedido: _pedido);
  }

  _calculateTotal() {
    double _tmpTotal = 0;
    _listproduct.forEach((element) {
      _tmpTotal += (element.price * element.quant);
    });

    setState(() {
      _total = _tmpTotal;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Carrinho'),
        centerTitle: true,
      ),
      body: _body(),
    );
  }

  Widget _body() {
    return Container(
      width: MediaQuery.of(context).size.width,
      height: MediaQuery.of(context).size.height,
      child: Column(
        children: [
          Row(
            children: [
              Padding(
                padding:
                    const EdgeInsets.only(top: 32.0, left: 16.0, bottom: 8.0),
                child: Text(
                  'Endereço',
                  style: TextStyle(fontSize: 16),
                ),
              )
            ],
          ),
          _adressInfo(),
          Row(
            children: [
              Padding(
                padding:
                    const EdgeInsets.only(top: 32.0, left: 16.0, bottom: 8.0),
                child: Text(
                  'Produtos',
                  style: TextStyle(fontSize: 16),
                ),
              )
            ],
          ),
          _listProducts(),
          Padding(
            padding: const EdgeInsets.only(right: 32.0, bottom: 16.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                Padding(
                  padding: const EdgeInsets.only(left: 16.0, bottom: 8.0),
                  child: Text(
                    'Total $_total',
                    style: TextStyle(
                        fontSize: 16,
                        color: primary,
                        fontWeight: FontWeight.bold),
                  ),
                )
              ],
            ),
          ),
          SafeArea(
              child: Padding(
            padding: const EdgeInsets.all(16.0),
            child: btPrimary(
                lable: 'Fazer pedido',
                context: context,
                call: () {
                  _makeOrder();
                }),
          ))
        ],
      ),
    );
  }

  Widget _cardProducts(Product product) {
    return Padding(
      padding: const EdgeInsets.all(4.0),
      child: Container(
          width: MediaQuery.of(context).size.width,
          height: 100,
          child: ListTile(
            leading: ClipRRect(
                borderRadius: BorderRadius.all(Radius.circular(10)),
                child: Container(
                    width: 90,
                    height: 90,
                    child: CachedNetworkImage(
                      imageUrl: product.thumbnail,
                    ))),
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
                    child: Text('Quantidade   ${product.quant}')),
                Text(
                  'R\$ ${product.price}',
                  style: TextStyle(color: primary, fontWeight: FontWeight.bold),
                )
              ],
            ),
          )),
    );
  }

  Widget _listProducts() {
    return Expanded(
        child: ListView.builder(
      itemCount: _listproduct.length,
      itemBuilder: (context, index) {
        return _cardProducts(_listproduct[index]);
      },
    ));
  }

  Widget _adressInfo() {
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: Container(
        width: MediaQuery.of(context).size.width,
        height: 150,
        decoration: BoxDecoration(
            borderRadius: BorderRadius.all(Radius.circular(10)),
            border: Border.all(color: Colors.grey)),
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.only(top: 16.0, bottom: 4.0),
              child: Text('${_user.street} ${_user.number}'),
            ),
            Padding(
              padding: const EdgeInsets.all(4.0),
              child: Text(_user.district),
            ),
            Padding(
              padding: const EdgeInsets.all(16.0),
              child: Divider(
                color: Colors.grey,
                height: 1.0,
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(4.0),
              child: Text(_user.references),
            ),
          ],
        ),
      ),
    );
  }
}
