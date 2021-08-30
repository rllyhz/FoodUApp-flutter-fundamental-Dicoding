import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:restaurant_app/api/api_service.dart';
import 'package:restaurant_app/data/response/detail_restaurant_result.dart';

class DetailRestaurantProvider extends ChangeNotifier {
  final ApiService apiService;
  final String id;

  DetailRestaurantProvider({required this.apiService, required this.id}) {
    _fetchDetailRestaurant(id);
  }

  late DetailRestaurantResult _detailRestaurantResult;
  DetailRestaurantResult get detailRestaurant => _detailRestaurantResult;

  ResultState _state = ResultState.Empty;
  ResultState get state => _state;

  String _message = '';
  String get message => _message;

  int _selectedOptionMenuIndex = 0;
  int get selectedOptionMenuIndex => _selectedOptionMenuIndex;

  void setSelectedOptionMenuIndex(int index) {
    _selectedOptionMenuIndex = index;
    notifyListeners();
  }

  ScrollController _controller = ScrollController();
  ScrollController get inputController => _controller;

  bool _isFav = false;
  bool get isFav => _isFav;

  set isFav(bool value) {
    _isFav = value;
    notifyListeners();
  }

  Future<dynamic> _fetchDetailRestaurant(String id) async {
    try {
      _state = ResultState.Loading;
      notifyListeners();

      final detailRestaurant = await apiService.fetchDetailRestaurant(id);

      if (!detailRestaurant.error) {
        _state = ResultState.HasData;
        _detailRestaurantResult = detailRestaurant;
        notifyListeners();
        return _detailRestaurantResult;
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
