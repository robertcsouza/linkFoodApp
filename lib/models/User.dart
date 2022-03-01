class User {
  String _name = '';

  bool _isAdmin = false;

  User({required String name, required bool isAdmin}) {
    this._name = name;
    this._isAdmin = isAdmin;
  }

  String get name => _name;

  set name(String name) {
    _name = name;
  }

  bool get isAdmin => _isAdmin;

  set isAdmin(bool isAdmin) {
    _isAdmin = isAdmin;
  }

  User.fromApi(dynamic response) {
    this._name = response.data['result']['name'];
    this.isAdmin = response.data['result']['isAdmin'];
  }
}
