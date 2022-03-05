class Pedido {
  late double _total;
  late String _obs = 'NONE';
  late String _status = 'RECIVED';
  late String _user;
  late String _restaurant;
  late List<String> _producs;

  Pedido(
      {required String user,
      required String restaurant,
      required List<String> products,
      required double total}) {
    this._user = user;
    this._restaurant = restaurant;
    this._producs = products;
    this._total = total;
  }

  Map toMap() {
    Map map = Map();
    map = {
      "obs": _obs,
      "total": _total,
      "status": _status,
      "user": _user,
      "restaurants": _restaurant,
      "products": _producs
    };

    return map;
  }

  List<String> get producs => _producs;

  set producs(List<String> producs) {
    _producs = producs;
  }

  String get restaurant => _restaurant;

  set restaurant(String restaurant) {
    _restaurant = restaurant;
  }

  String get user => _user;

  set user(String user) {
    _user = user;
  }

  String get status => _status;

  set status(String status) {
    _status = status;
  }

  String get obs => _obs;

  set obs(String obs) {
    _obs = obs;
  }

  double get total => _total;

  set total(double total) {
    _total = total;
  }
}
