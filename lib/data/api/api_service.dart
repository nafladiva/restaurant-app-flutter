import 'package:http/http.dart' as http;
import 'dart:convert';

import 'package:restail/data/model/restaurant.dart';

class ApiService {
  static final String _baseUrl = 'https://restaurant-api.dicoding.dev/';
  http.Client client;

  ApiService(this.client);

  Future<RestaurantResult> getRestaurantList() async {
    final response = await client.get(Uri.parse(_baseUrl + 'list'));
    if (response.statusCode == 200) {
      return RestaurantResult.fromJson(json.decode(response.body));
    } else {
      throw Exception('Failed to load list restaurant');
    }
  }

  Future<RestaurantSearch> search(String query) async {
    final response =
        await client.get(Uri.parse(_baseUrl + 'search?q=' + query));

    if (response.statusCode == 200) {
      return RestaurantSearch.fromJson(json.decode(response.body));
    } else {
      throw Exception('Failed to load searched data');
    }
  }

  Future<RestaurantResultDetail> getDetail(String restaurantId) async {
    final response =
        await client.get(Uri.parse(_baseUrl + 'detail/' + restaurantId));

    if (response.statusCode == 200) {
      return RestaurantResultDetail.fromJson(json.decode(response.body));
    } else {
      throw Exception('Failed to load detail restaurant');
    }
  }
}
