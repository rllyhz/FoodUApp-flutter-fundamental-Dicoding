import 'package:flutter/foundation.dart';
import 'package:restaurant_app/data/api/api_service.dart';
import 'package:restaurant_app/data/db/database_helper.dart';
import 'package:restaurant_app/data/response/restaurant_result.dart';

class DatabaseProvider extends ChangeNotifier {
  final DatabaseHelper databaseHelper;

  DatabaseProvider({required this.databaseHelper}) {
    _getFavoriteRestaurants();
  }

  ResultState _state = ResultState.Empty;
  ResultState get state => _state;

  String _message = '';
  String get message => _message;

  List<Restaurant> _favRestaurants = [];
  List<Restaurant> get favRestaurants => _favRestaurants;

  void _getFavoriteRestaurants() async {
    _favRestaurants = await databaseHelper.getFavorites();
    if (_favRestaurants.isNotEmpty) {
      _state = ResultState.HasData;
    } else {
      _state = ResultState.NoData;
      _message = "Empty data";
    }

    notifyListeners();
  }

  void addFavorite(Restaurant restaurant) async {
    try {
      await databaseHelper.insertFavorite(restaurant);
      _getFavoriteRestaurants();
    } catch (e) {
      _state = ResultState.Error;
      _message = 'Error: $e';
      notifyListeners();
    }
  }

  void deleteFavorite(String id) async {
    try {
      await databaseHelper.deleteFavorite(id);
      _getFavoriteRestaurants();
    } catch (e) {
      _state = ResultState.Error;
      _message = 'Error: $e';
      notifyListeners();
    }
  }

  Future<bool> isFavorite(String id) async {
    final favRestaurant = await databaseHelper.getFavoriteById(id);
    return favRestaurant != null;
  }
}
