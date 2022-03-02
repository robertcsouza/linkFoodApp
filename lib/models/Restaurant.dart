class Restaurant {
  late String _id;
  late String _name;
  late int _freight;
  late String _duration;
  late String _owner;
  late String _thumbnail;

  Restaurant(
      {required String id,
      required String name,
      required int freight,
      required String duration,
      required String owner,
      required String thumbnail}) {
    this._id = id;
    this._name = name;
    this._duration = duration;
    this._freight = freight;
    this._owner = owner;
    this._thumbnail = thumbnail;
  }

  String get thumbnail => _thumbnail;

  set thumbnail(String thumbnail) {
    _thumbnail = thumbnail;
  }

  String get owner => _owner;

  set owner(String owner) {
    _owner = owner;
  }

  int get freight => _freight;

  set freight(int freight) {
    _freight = freight;
  }

  String get duration => _duration;

  set duration(String duration) {
    _duration = duration;
  }

  String get name => _name;

  set name(String name) {
    _name = name;
  }

  String get id => _id;

  set id(String id) {
    _id = id;
  }
}
