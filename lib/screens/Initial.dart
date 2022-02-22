import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:linkfood/assets/Colors.dart';
import 'package:linkfood/components/bottomNavigator.dart';

class Initial extends StatefulWidget {
  const Initial({Key? key}) : super(key: key);

  @override
  _InitialState createState() => _InitialState();
}

class _InitialState extends State<Initial> {
  String endereco = 'Benedito Inocêncio 4444';
  List images = [1, 2, 3];
  double rating = 4.6;
  bool toggle = false;

  _callRoute() {
    Navigator.pushNamed(context, '/store');
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
      bottomNavigationBar: bottomNavigatior(index: 0),
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
            child: images.isNotEmpty ? _carousel() : SizedBox(),
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

  Widget _cardLojas() {
    return Padding(
      padding: const EdgeInsets.all(4.0),
      child: Container(
          width: MediaQuery.of(context).size.width,
          height: 100,
          child: ListTile(
            onTap: () {
              _callRoute();
            },
            leading: ClipRRect(
                borderRadius: BorderRadius.all(Radius.circular(100)),
                child: Container(
                    width: 50,
                    height: 50,
                    child: Image.asset('images/dominos.png'))),
            title: Text(
              'Dominos pizzaria',
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
    return Expanded(
        child: ListView.builder(
      itemCount: 5,
      itemBuilder: (context, index) {
        return _cardLojas();
      },
    ));
  }

  Widget _carousel() {
    return SizedBox(
        width: MediaQuery.of(context).size.width,
        height: 150.0,
        child: CarouselSlider(
          options: CarouselOptions(height: 400.0),
          items: images.map((i) {
            return Builder(
              builder: (BuildContext context) {
                return Container(
                    width: MediaQuery.of(context).size.width,
                    margin: EdgeInsets.symmetric(horizontal: 5.0),
                    decoration: BoxDecoration(color: Colors.amber),
                    child: Text(
                      'text $i',
                      style: TextStyle(fontSize: 16.0),
                    ));
              },
            );
          }).toList(),
        ));
  }
}

/*

Row(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Column(
                children: [
                  Padding(
                    padding: const EdgeInsets.only(left: 16.0),
                    child: ClipRRect(
                        borderRadius: BorderRadius.all(Radius.circular(100)),
                        child: Container(
                            width: 50,
                            height: 50,
                            child: Image.asset('images/dominos.png'))),
                  ),
                ],
              ),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Padding(
                      padding: const EdgeInsets.only(left: 8.0),
                      child: Text(
                        'Dominos pizzaria',
                        style: TextStyle(
                            fontWeight: FontWeight.bold,
                            color: Colors.grey[800]),
                      ),
                    ),
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
              ),
              
            ],
          )


 */
