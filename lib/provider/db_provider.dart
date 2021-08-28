import 'package:flutter/foundation.dart';
import 'package:restail/data/model/restaurant.dart';

import '../data/db/database_helper.dart';

class DBProvider extends ChangeNotifier {
  List<RestaurantFavorite> _favorites = [];
  late DatabaseHelper _dbHelper;

  List<RestaurantFavorite> get favorites => _favorites;

  DBProvider() {
    _dbHelper = DatabaseHelper();
    _getAllFavorites();
  }

  void _getAllFavorites() async {
    _favorites = await _dbHelper.getFavorites();
    notifyListeners();
  }

  Future<void> addFavorite(RestaurantFavorite favorite) async {
    await _dbHelper.addFavorite(favorite);
    _getAllFavorites();
  }

  Future<RestaurantFavorite> getFavoriteById(String id) async {
    return await _dbHelper.getFavoriteById(id);
  }

  void deleteFavorite(String id) async {
    await _dbHelper.deleteFavorite(id);
    _getAllFavorites();
  }

  Future<void> deleteAllData() async {
    await _dbHelper.deleteAllData();
    _getAllFavorites();
  }
}
