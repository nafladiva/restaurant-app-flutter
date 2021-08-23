import 'package:flutter/material.dart';
import 'package:restail/data/api/api_service.dart';
import 'package:restail/data/model/restaurant.dart';

enum ResultState { Loading, NoData, HasData, Error }

class RestaurantSearchProvider extends ChangeNotifier {
  late ApiService apiService;
  late String query;

  RestaurantSearchProvider({required this.apiService, required this.query}) {
    _fetchAllRestaurant();
  }

  late RestaurantSearch _restaurantResult;
  String _message = '';
  late ResultState _state;

  String get message => _message;

  RestaurantSearch get result => _restaurantResult;

  ResultState get state => _state;

  Future<dynamic> _fetchAllRestaurant() async {
    try {
      _state = ResultState.Loading;
      notifyListeners();
      final restaurant = await apiService.search(query);
      if (restaurant.restaurants.isEmpty) {
        _state = ResultState.NoData;
        notifyListeners();
        return _message = 'Empty Data';
      } else {
        _state = ResultState.HasData;
        notifyListeners();
        return _restaurantResult = restaurant;
      }
    } catch (e) {
      _state = ResultState.Error;
      notifyListeners();
      return _message = 'Error --> $e';
    }
  }
}
