import 'package:flutter/foundation.dart';
import 'package:restaurant_app/api/api_service.dart';
import 'package:restaurant_app/data/response/detail_restaurant_result.dart';

class SearchRestaurantsProvider extends ChangeNotifier {
  final ApiService apiService;

  SearchRestaurantsProvider({required this.apiService});

  DetailRestaurantResult? _detailRestaurantResult;
  DetailRestaurantResult? get detail => _detailRestaurantResult;

  ResultState _state = ResultState.Empty;
  ResultState get state => _state;

  String _message = '';
  String get message => _message;

  void setState(ResultState newState) {
    _state = newState;
    notifyListeners();
  }

  Future<dynamic> fetchDetailRestaurant(String id) async {
    try {
      _state = ResultState.Loading;
      notifyListeners();

      final detailRestaurant = await apiService.fetchDetailRestaurant(id);

      if (detailRestaurant.restaurant != null) {
        _state = ResultState.HasData;
        _detailRestaurantResult = detailRestaurant;
        notifyListeners();
        return _detailRestaurantResult;
      } else if (detailRestaurant.restaurant == null) {
        _state = ResultState.NoData;
        _message = detailRestaurant.message;
        notifyListeners();
        return _message;
      } else {
        _state = ResultState.Error;
        _message = detailRestaurant.message;
        notifyListeners();
        return _message;
      }
    } catch (e) {
      _state = ResultState.Error;
      _message = 'Error --> $e';
      notifyListeners();
      return _message;
    }
  }
}
