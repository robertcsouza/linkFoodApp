class BannerInfo {
  String? _url;
  String? _id;

  BannerInfo({required String url, required id}) {
    this._id = id;
    this._url = url;
  }

  String? get id => _id;

  set id(String? id) {
    _id = id;
  }

  String? get url => _url;

  set url(String? url) {
    _url = url;
  }
}
