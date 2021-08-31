import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:restaurant_app/api/api_service.dart';
import 'package:restaurant_app/data/model/restaurant_review.dart';
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
  ScrollController get scrollController => _controller;

  bool _isFav = false;
  bool get isFav => _isFav;

  set isFav(bool value) {
    _isFav = value;
    notifyListeners();
  }

  // Customer Reviews
  ResultState _customerReviewState = ResultState.Empty;
  ResultState get customerReviewState => _customerReviewState;

  String _customerReviewMessage = '';
  String get customerReviewMessage => _customerReviewMessage;

  late List<RestaurantReview> _customerReviews;
  List<RestaurantReview> get customerReviews => _customerReviews;

  TextEditingController _addReviewInputController = TextEditingController();
  TextEditingController get addReviewInputController =>
      _addReviewInputController;

  void postReview() {
    if (addReviewInputController.text.isEmpty) return;

    _addReview(
      detailRestaurant.restaurant.id,
      addReviewInputController.text,
      'Rully Ihza Mahendra',
    );
  }

  Future<dynamic> _addReview(String id, String review, String name) async {
    try {
      _customerReviewState = ResultState.Loading;
      notifyListeners();

      final addReviewResult = await apiService.addReview(id, review, name);

      if (!addReviewResult.error &&
          addReviewResult.customerReviews.isNotEmpty) {
        _customerReviewState = ResultState.HasData;
        _customerReviews = addReviewResult.customerReviews;
        addReviewInputController.text = "";
        notifyListeners();
        return _customerReviews;
      } else if (!addReviewResult.error &&
          addReviewResult.customerReviews.isEmpty) {
        _customerReviewState = ResultState.NoData;
        _customerReviewMessage = addReviewResult.message;
        notifyListeners();
        return _customerReviewMessage;
      } else {
        _customerReviewState = ResultState.Error;
        _customerReviewMessage = addReviewResult.message;
        notifyListeners();
        return _customerReviewMessage;
      }
    } catch (e) {
      _customerReviewState = ResultState.Error;
      _customerReviewMessage = 'Error --> $e';
      notifyListeners();
      return _customerReviewMessage;
    }
  }

  Future<dynamic> _fetchDetailRestaurant(String id) async {
    try {
      _state = ResultState.Loading;
      notifyListeners();

      final detailRestaurant = await apiService.fetchDetailRestaurant(id);

      if (!detailRestaurant.error) {
        _state = ResultState.HasData;
        _detailRestaurantResult = detailRestaurant;

        if (detailRestaurant.restaurant.customerReviews.isNotEmpty) {
          _customerReviewState = ResultState.HasData;
          _customerReviews = detailRestaurant.restaurant.customerReviews;
        } else {
          _customerReviewState = ResultState.NoData;
          _customerReviewMessage = 'No customer reviews yet!';
        }

        notifyListeners();
        return _detailRestaurantResult;
      } else {
        _state = ResultState.Error;
        _customerReviewState = ResultState.Error;
        _message = detailRestaurant.message;
        _customerReviewMessage = detailRestaurant.message;
        notifyListeners();
        return _message;
      }
    } catch (e) {
      _state = ResultState.Error;
      _customerReviewState = ResultState.Error;
      _message = 'Error --> $e';
      _customerReviewMessage = 'Error --> $e';
      notifyListeners();
      return _message;
    }
  }
}
