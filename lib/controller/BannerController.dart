import 'package:dio/dio.dart';
import 'package:linkfood/models/BannerInfo.dart';
import 'package:shared_preferences/shared_preferences.dart';

class BannerController {
  BaseOptions options = new BaseOptions(
    baseUrl: "https://linkfoodapi.herokuapp.com",
    connectTimeout: 5000,
  );

  index() async {
    List banners = [];
    final prefs = await SharedPreferences.getInstance();
    String? token = prefs.getString('token');
    options.headers = {'x-access-token': token};
    var response = await Dio(options).get('/api/v1/banner');
    response.data['result'].forEach((element) {
      BannerInfo banner = BannerInfo(url: element['url'], id: element['_id']);
      banners.add(banner);
    });
    return banners;
  }
}
