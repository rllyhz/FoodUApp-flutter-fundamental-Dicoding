import 'dart:convert';
import 'package:restaurant_app/data/model/restaurant_review.dart';

AddReviewResult addReviewResultFromJson(String str) =>
    AddReviewResult.fromJson(json.decode(str));

String addReviewResultToJson(AddReviewResult data) =>
    json.encode(data.toJson());

class AddReviewResult {
  AddReviewResult({
    required this.error,
    required this.message,
    required this.customerReviews,
  });

  bool error;
  String message;
  List<RestaurantReview> customerReviews;

  factory AddReviewResult.fromJson(Map<String, dynamic> json) =>
      AddReviewResult(
        error: json["error"],
        message: json["message"],
        customerReviews: List<RestaurantReview>.from(
            json["customerReviews"].map((x) => RestaurantReview.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "error": error,
        "message": message,
        "customerReviews":
            List<dynamic>.from(customerReviews.map((x) => x.toJson())),
      };
}
