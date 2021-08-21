import 'dart:convert';

class Restaurant {
  late String name, description, pictureId, city;
  late double rating;
  late List<dynamic> foods, drinks;

  Restaurant({
    required this.name,
    required this.description,
    required this.pictureId,
    required this.city,
    required this.rating,
    required this.foods,
    required this.drinks,
  });

  Restaurant.fromJson(Map<String, dynamic> restaurant) {
    name = restaurant['name'];
    description = restaurant['description'];
    pictureId = restaurant['pictureId'];
    city = restaurant['city'];
    rating = restaurant['rating'];
    foods = restaurant['menus']['foods'];
    drinks = restaurant['menus']['drinks'];
  }
}

List<Restaurant> parseRestaurant(String? json) {
  if (json == null) {
    return [];
  }

  final List parsed = jsonDecode(json)["restaurants"];
  return parsed.map((json) => Restaurant.fromJson(json)).toList();
}
