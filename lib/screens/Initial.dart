import 'package:cached_network_image/cached_network_image.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:linkfood/assets/Colors.dart';
import 'package:linkfood/components/bottomNavigator.dart';
import 'package:linkfood/controller/RestaurantsController.dart';
import 'package:linkfood/controller/bannerController.dart';
import 'package:linkfood/models/BannerInfo.dart';
import 'package:linkfood/models/Restaurant.dart';
import 'package:linkfood/screens/Store.dart';

class Initial extends StatefulWidget {
  const Initial({Key? key}) : super(key: key);

  @override
  _InitialState createState() => _InitialState();
}

class _InitialState extends State<Initial> {
  BannerController _bannerController = BannerController();
  RestaurantController _restaurantController = RestaurantController();
  late Future rest;
  late Future ban;
  String endereco = 'Benedito Inocêncio 4444';
  double rating = 4.6;
  bool toggle = false;
  List restaurants = [];
  List banners = [];

  _callRoute(Restaurant restaurant) {
    Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => Store(rest: restaurant)),
    );
  }

  @override
  void initState() {
    super.initState();
    rest = _restaurantController.index();
    ban = _bannerController.index();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: primary,
        title: Text('Restaurantes Parceiros'),
        centerTitle: true,
      ),
      body: _body(),
      bottomNavigationBar: bottomNavigatior(index: 0, context: context),
    );
  }

  Widget _body() {
    return Container(
      width: MediaQuery.of(context).size.width,
      height: MediaQuery.of(context).size.height,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: const EdgeInsets.only(top: 32.0, left: 16),
            child: Text(
              endereco,
              style: TextStyle(
                  fontSize: 16,
                  color: Colors.grey[600],
                  fontWeight: FontWeight.bold),
            ),
          ),
          Padding(
            padding: const EdgeInsets.only(top: 16.0, bottom: 8.0),
            child: _carousel(),
          ),
          Padding(
            padding: const EdgeInsets.only(top: 16.0, left: 16),
            child: Text(
              'Lojas',
              style: TextStyle(fontSize: 16, color: Colors.grey[800]),
            ),
          ),
          _listLojas(),
        ],
      ),
    );
  }

  Widget _cardLojas(Restaurant restaurant) {
    return Padding(
      padding: const EdgeInsets.all(4.0),
      child: Container(
          width: MediaQuery.of(context).size.width,
          height: 100,
          child: ListTile(
            onTap: () {
              _callRoute(restaurant);
            },
            leading: ClipRRect(
                borderRadius: BorderRadius.all(Radius.circular(100)),
                child: Container(
                    width: 50,
                    height: 50,
                    child: CachedNetworkImage(
                        imageUrl: restaurant.thumbnail, fit: BoxFit.fill))),
            title: Text(
              restaurant.name,
              style: TextStyle(
                  fontWeight: FontWeight.bold, color: Colors.grey[800]),
            ),
            subtitle: Column(
              children: [
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      Icon(
                        Icons.star,
                        color: Colors.amber,
                        size: 24,
                      ),
                      Text(
                        rating.toString(),
                        style: TextStyle(color: Colors.amber, fontSize: 16),
                      ),
                      Padding(
                        padding: const EdgeInsets.only(left: 8.0),
                        child: Text(
                          'Restaurante',
                          style: TextStyle(fontSize: 12),
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
            trailing: IconButton(
                onPressed: () {
                  setState(() {
                    toggle = !toggle;
                  });
                },
                icon: Icon(
                  toggle == false ? Icons.favorite_border : Icons.favorite,
                  color: Colors.red,
                )),
          )),
    );
  }

  Widget _listLojas() {
    return FutureBuilder(
        future: rest,
        builder: (context, AsyncSnapshot snapshot) {
          if (ConnectionState.waiting == snapshot.connectionState) {
            EasyLoading.show();
            return SizedBox();
          } else {
            EasyLoading.dismiss();
            restaurants = snapshot.data as List;
            return Expanded(
                child: ListView.builder(
              itemCount: restaurants.length,
              itemBuilder: (context, index) {
                return _cardLojas(restaurants[index]);
              },
            ));
          }
        });
  }

  Widget _carousel() {
    return FutureBuilder(
        future: ban,
        builder: (context, snapshot) {
          if (ConnectionState.waiting == snapshot.connectionState) {
            return SizedBox();
          } else {
            banners = snapshot.data as List;

            return SizedBox(
                width: MediaQuery.of(context).size.width,
                height: 150.0,
                child: CarouselSlider(
                  options: CarouselOptions(height: 400.0),
                  items: banners.map((item) {
                    BannerInfo banner = item;
                    List split = banner.url!.split('/');
                    String url = 'http://192.168.100.9:3050/files/${split[4]}';

                    return Builder(
                      builder: (BuildContext context) {
                        return Container(
                            width: MediaQuery.of(context).size.width,
                            margin: EdgeInsets.symmetric(horizontal: 0.5),
                            decoration: BoxDecoration(color: Colors.white),
                            child: CachedNetworkImage(
                              imageUrl: url,
                              fit: BoxFit.fill,
                            ));
                      },
                    );
                  }).toList(),
                ));
          }
        });
  }
}
