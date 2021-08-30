class RestaurantResult {
  bool error;
  String message;
  int count;
  List<Restaurant> restaurants;

  RestaurantResult({
    required this.error,
    required this.message,
    required this.count,
    required this.restaurants,
  });

  factory RestaurantResult.fromJson(Map<String, dynamic> json) =>
      RestaurantResult(
        error: json["error"],
        message: json["message"],
        count: json["count"],
        restaurants: List<Restaurant>.from(
          json["restaurants"].map((item) => Restaurant.fromJson(item)),
        ),
      );

  Map<String, dynamic> toJson() => {
        'error': error,
        'message': message,
        'count': count,
        'restaurants': List<dynamic>.from(restaurants.map((x) => x.toJson())),
      };
}

class RestaurantSearch {
  bool error;
  int founded;
  List<Restaurant> restaurants;

  RestaurantSearch({
    required this.error,
    required this.founded,
    required this.restaurants,
  });

  factory RestaurantSearch.fromJson(Map<String, dynamic> json) =>
      RestaurantSearch(
        error: json["error"],
        founded: json["founded"],
        restaurants: List<Restaurant>.from(
          json["restaurants"].map((item) => Restaurant.fromJson(item)),
        ),
      );
}

class Restaurant {
  late String id, name, description, pictureId, city;
  late double rating;

  Restaurant({
    required this.id,
    required this.name,
    required this.description,
    required this.pictureId,
    required this.city,
    required this.rating,
  });

  factory Restaurant.fromJson(Map<String, dynamic> json) => Restaurant(
        id: json['id'],
        name: json['name'],
        description: json['description'],
        pictureId: json['pictureId'],
        city: json['city'],
        rating: json['rating'].toDouble(),
      );

  Map<String, dynamic> toJson() => {
        'id': id,
        'name': name,
        'description': description,
        'pictureId': pictureId,
        'city': city,
        'rating': rating,
      };
}

class RestaurantResultDetail {
  bool error;
  String message;
  Map<String, dynamic> restaurants;

  RestaurantResultDetail({
    required this.error,
    required this.message,
    required this.restaurants,
  });

  factory RestaurantResultDetail.fromJson(Map<String, dynamic> json) =>
      RestaurantResultDetail(
        error: json["error"],
        message: json["message"],
        restaurants: json["restaurant"],
      );
}

class RestaurantDetail {
  late String id, name, description, pictureId, city, address;
  late double rating;
  List<dynamic> categories = [], foods = [], drinks = [], customerReviews = [];

  RestaurantDetail({
    required this.id,
    required this.name,
    required this.description,
    required this.pictureId,
    required this.city,
    required this.address,
    required this.rating,
    required this.categories,
    required this.foods,
    required this.drinks,
    required this.customerReviews,
  });

  factory RestaurantDetail.fromJson(Map<String, dynamic> json) =>
      RestaurantDetail(
        id: json['id'],
        name: json['name'],
        description: json['description'],
        pictureId: json['pictureId'],
        city: json['city'],
        address: json['address'],
        rating: json['rating'].toDouble(),
        categories: json['categories'],
        foods: json['menus']['foods'],
        drinks: json['menus']['drinks'],
        customerReviews: json['customerReviews'],
      );
}

class RestaurantFavorite {
  late String idRestaurant, name, pictureId, city;

  RestaurantFavorite({
    required this.idRestaurant,
    required this.name,
    required this.pictureId,
    required this.city,
  });

  Map<String, dynamic> toMap() {
    return {
      'id_restaurant': idRestaurant,
      'name': name,
      'pictureId': pictureId,
      'city': city,
    };
  }

  RestaurantFavorite.fromMap(Map<String, dynamic> map) {
    idRestaurant = map['id_restaurant'];
    name = map['name'];
    pictureId = map['pictureId'];
    city = map['city'];
  }
}
