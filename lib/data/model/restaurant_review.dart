class RestaurantReview {
  late String name;
  late String review;
  late String date;

  RestaurantReview({
    required this.name,
    required this.review,
    required this.date,
  });

  factory RestaurantReview.fromJson(Map<String, dynamic> json) =>
      RestaurantReview(
          name: json['name'], review: json['review'], date: json['date']);
}
