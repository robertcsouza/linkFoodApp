class Product {
  late String _id;
  late String _name;
  late double _price;
  late String _restaurant;
  late String _thumbnail;
  late String _description;
  late String _observation;
  late int _quant;

  Product(
      {required String id,
      required String name,
      required double price,
      required String restaurant,
      required String thumbnail,
      required String description}) {
    this._id = id;
    this._name = name;
    this._price = price;
    this._restaurant = restaurant;
    this._thumbnail = thumbnail;
    this._description = description;
  }

  String get thumbnail => _thumbnail;

  set thumbnail(String thumbnail) {
    _thumbnail = thumbnail;
  }

  String get restaurant => _restaurant;

  set restaurant(String restaurant) {
    _restaurant = restaurant;
  }

  double get price => _price;

  set price(double price) {
    _price = price;
  }

  String get name => _name;

  set name(String name) {
    _name = name;
  }

  String get id => _id;

  set id(String id) {
    _id = id;
  }

  String get description => _description;

  set description(String description) {
    _description = description;
  }

  String get observation => _observation;

  set observation(String observation) {
    _observation = observation;
  }

  int get quant => _quant;

  set quant(int quant) {
    _quant = quant;
  }
}
