import 'package:dio/dio.dart';

import 'package:linkfood/models/Restaurant.dart';
import 'package:shared_preferences/shared_preferences.dart';

class RestaurantController {
  BaseOptions options = new BaseOptions(
    baseUrl: "https://linkfoodapi.herokuapp.com",
    connectTimeout: 5000,
  );

  index() async {
    List restaurants = [];
    final prefs = await SharedPreferences.getInstance();
    String? token = prefs.getString('token');
    options.headers = {'x-access-token': token};
    var response = await Dio(options).get('/api/v1/restaurant');
    response.data['result'].forEach((element) {
      Restaurant restaurant = Restaurant(
          id: element['_id'],
          name: element['name'],
          freight: element['freight'],
          duration: element['duration'],
          owner: element['owner'],
          thumbnail: element['thumbnail']);
      restaurants.add(restaurant);
    });
    return restaurants;
  }
}
