import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:line_icons/line_icons.dart';
import 'package:provider/provider.dart';
import 'package:restaurant_app/api/api_service.dart';
import 'package:restaurant_app/data/model/restaurant.dart';
import 'package:restaurant_app/provider/detail_restaurant_provider.dart';
import 'package:restaurant_app/utils/constants.dart';
import 'package:restaurant_app/utils/time_utils.dart';
import 'package:restaurant_app/widgets/card_error.dart';

class DetailRestaurantPage extends StatelessWidget {
  static final route = "/detail";

  const DetailRestaurantPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final _restaurant =
        ModalRoute.of(context)?.settings.arguments as RestaurantModel;

    return Scaffold(
      body: SafeArea(
        child: ChangeNotifierProvider<DetailRestaurantProvider>(
          create: (_) => DetailRestaurantProvider(
              apiService: ApiService(), id: _restaurant.id),
          child: Consumer<DetailRestaurantProvider>(
            builder: (ctx, provider, _) {
              return _buildDetailInfo(context, provider, _restaurant);
            },
          ),
        ),
      ),
    );
  }

  Widget _buildDetailInfo(BuildContext context,
      DetailRestaurantProvider provider, RestaurantModel restaurant) {
    return CustomScrollView(
      physics: const BouncingScrollPhysics(),
      slivers: [
        SliverAppBar(
          expandedHeight: 284.0,
          stretch: true,
          pinned: true,
          collapsedHeight: 56.0,
          backgroundColor: lightGreen,
          leading: IconButton(
            onPressed: () {
              Navigator.of(context).pop();
            },
            icon: Icon(LineIcons.arrowLeft),
          ),
          actions: [
            IconButton(
                onPressed: () {
                  provider.isFav = !provider.isFav;
                },
                icon: Icon(
                  provider.isFav ? LineIcons.heartAlt : LineIcons.heart,
                  color: Colors.white,
                ))
          ],
          flexibleSpace: FlexibleSpaceBar(
            stretchModes: [StretchMode.zoomBackground],
            background: Stack(
              fit: StackFit.expand,
              alignment: Alignment.center,
              children: [
                Hero(
                  tag: restaurant.id,
                  child: Image.network(
                    ApiService.pictureMediumSizeBaseUrl + restaurant.pictureId,
                    fit: BoxFit.fill,
                  ),
                ),
                Container(
                  decoration: BoxDecoration(
                    gradient: LinearGradient(
                      begin: AlignmentDirectional.topCenter,
                      end: AlignmentDirectional.center,
                      colors: [Colors.black45, Colors.transparent],
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
        SliverList(
          delegate: SliverChildListDelegate([
            SizedBox(height: 12.0),
            Padding(
              padding: EdgeInsets.only(left: 12.0),
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Text(
                    restaurant.name,
                    style:
                        TextStyle(fontSize: 24.0, fontWeight: FontWeight.bold),
                  ),
                  SizedBox(width: 8),
                  Container(
                    width: 8,
                    height: 8,
                    decoration: BoxDecoration(
                      color: Colors.black38,
                      borderRadius: BorderRadius.circular(8.0),
                    ),
                  ),
                  SizedBox(width: 8),
                  RatingBar.builder(
                    initialRating: restaurant.rating,
                    minRating: 0,
                    maxRating: 5.0,
                    itemSize: 16.0,
                    direction: Axis.horizontal,
                    allowHalfRating: true,
                    itemCount: 5,
                    itemBuilder: (context, index) => Icon(
                      Icons.star,
                      color: Colors.pink[200],
                    ),
                    onRatingUpdate: (rating) {},
                  ),
                ],
              ),
            ),
            SizedBox(height: 4.0),
            Padding(
              padding: EdgeInsets.only(left: 8.0),
              child: Row(
                children: [
                  Icon(
                    LineIcons.mapMarker,
                    color: Colors.black38,
                    size: 18.0,
                  ),
                  Text(
                    restaurant.city,
                    style: TextStyle(fontSize: 18.0, color: Colors.black38),
                  ),
                ],
              ),
            ),
            SizedBox(height: 16.0),
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 16.0),
              child: Text(
                "Description",
                style: TextStyle(fontSize: 20.0, fontWeight: FontWeight.bold),
              ),
            ),
            SizedBox(height: 8.0),
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 16.0),
              child: Text(restaurant.description,
                  style: TextStyle(fontSize: 18.0)),
            ),
            SizedBox(height: 16.0),
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 16.0),
              child: Text(
                "Menus",
                style: TextStyle(fontSize: 20.0, fontWeight: FontWeight.bold),
              ),
            ),
            SizedBox(height: 4.0),
            Row(
              children: [
                SizedBox(width: 12.0),
                _buildMenuItem(
                    provider,
                    'Foods',
                    provider.selectedOptionMenuIndex == 0
                        ? darkGreen
                        : Colors.grey,
                    0),
                SizedBox(width: 8.0),
                _buildMenuItem(
                    provider,
                    'Drinks',
                    provider.selectedOptionMenuIndex == 1
                        ? darkGreen
                        : Colors.grey,
                    1),
              ],
            ),
            SizedBox(height: 12.0),
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 12.0),
              child: _buildMenuOptions(context, provider),
            ),
            SizedBox(height: 26.0),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 12.0),
              child: Text(
                'Consumer Reviews',
                style: TextStyle(fontSize: 20.0, fontWeight: FontWeight.bold),
              ),
            ),
            SizedBox(height: 12.0),
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 12.0),
              child: _buildReviewsUI(context, provider),
            ),
          ]),
        ),
      ],
    );
  }

  Widget _buildMenuOptions(
      BuildContext context, DetailRestaurantProvider provider) {
    if (provider.state == ResultState.Loading) {
      return Padding(
        padding: const EdgeInsets.symmetric(vertical: 24.0),
        child: Center(
          child: CircularProgressIndicator(
            color: lightGreen,
          ),
        ),
      );
    } else if (provider.state == ResultState.HasData) {
      return ListView.builder(
        itemCount: provider.selectedOptionMenuIndex == 0
            ? provider.detailRestaurant.restaurant.menus.foods.length
            : provider.detailRestaurant.restaurant.menus.drinks.length,
        controller: provider.scrollController,
        physics: ClampingScrollPhysics(),
        shrinkWrap: true,
        itemBuilder: (ctx, index) {
          return Container(
            padding: EdgeInsets.all(8.0),
            decoration: BoxDecoration(
              border: Border(
                  bottom: BorderSide(width: 1.0, color: Colors.grey.shade400)),
            ),
            child: Text(
              provider.selectedOptionMenuIndex == 0
                  ? provider.detailRestaurant.restaurant.menus.foods[index].name
                  : provider
                      .detailRestaurant.restaurant.menus.drinks[index].name,
              style: TextStyle(fontSize: 16.0),
            ),
          );
        },
      );
    } else
      return CardError(
        height: 120.0,
        label: cardErrorLabel,
        description: cardErrorDescription,
      );
  }

  Widget _buildMenuItem(DetailRestaurantProvider provider, String title,
      Color backgroundColor, int index) {
    return ElevatedButton(
      style: ElevatedButton.styleFrom(
        primary: backgroundColor,
        onPrimary: Colors.white,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(18.0),
        ),
        padding: EdgeInsets.all(4.0),
      ),
      onPressed: () {
        provider.setSelectedOptionMenuIndex(index);
        provider.scrollController.animateTo(0.0,
            duration: Duration(milliseconds: 200), curve: Curves.easeInOut);
      },
      child: Text(
        title,
        style: TextStyle(color: Colors.white),
      ),
    );
  }

  Widget _buildReviewsUI(
      BuildContext context, DetailRestaurantProvider provider) {
    if (provider.shouldShowToast &&
        provider.customerReviewState == ResultState.HasData)
      _showToast("Successfully post the review!");

    if (provider.shouldShowToast &&
        provider.customerReviewState == ResultState.Error)
      _showToast('Failed to post the review!');

    if (provider.state == ResultState.Loading) {
      return Padding(
        padding: const EdgeInsets.symmetric(vertical: 24.0),
        child: Center(
          child: Column(
            children: [
              _buildAddReviewInputUI(context, provider),
              SizedBox(height: 12.0),
              CircularProgressIndicator(
                color: lightGreen,
              ),
            ],
          ),
        ),
      );
    }

    if (provider.state == ResultState.Error) {
      return CardError(
        height: 120.0,
        label: cardErrorLabel,
        description: cardErrorDescription,
      );
    }

    if (provider.customerReviews.isEmpty) {
      return Container(
        child: Column(
          children: [
            _buildAddReviewInputUI(context, provider),
            SizedBox(height: 12.0),
            Text(
              'No reviews yet.',
              style: TextStyle(fontSize: 16.0),
            ),
          ],
        ),
      );
    }

    final customerReviews = provider.customerReviews;
    customerReviews.sort((before, next) =>
        convertStringDateToDateTime(before.date)
                .isAfter(convertStringDateToDateTime(next.date))
            ? -1
            : 1);

    return Column(
      children: [
        _buildAddReviewInputUI(context, provider),
        SizedBox(height: 12.0),
        ListView.builder(
          physics: ClampingScrollPhysics(),
          shrinkWrap: true,
          itemCount: customerReviews.length,
          itemBuilder: (ctx, index) {
            final review = customerReviews[index];

            return Padding(
              padding: EdgeInsets.only(
                left: index % 2 == 0 ? 0 : 42.0,
                right: index % 2 == 0 ? 42.0 : 0,
                bottom: 4.0,
              ),
              child: Card(
                child: Padding(
                  padding: EdgeInsets.all(12.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(review.name,
                              style: TextStyle(
                                  fontSize: 16.0,
                                  fontWeight: FontWeight.bold,
                                  color: lightGreen)),
                          Text(review.date,
                              style: TextStyle(
                                  fontSize: 14.0, color: Colors.grey)),
                        ],
                      ),
                      SizedBox(height: 16.0),
                      Text(
                        '`' + review.review + '`',
                        style: TextStyle(
                            fontSize: 16.0,
                            fontStyle: FontStyle.italic,
                            color: Colors.grey.shade700),
                      ),
                    ],
                  ),
                ),
              ),
            );
          },
        ),
      ],
    );
  }

  Widget _buildAddReviewInputUI(
      BuildContext context, DetailRestaurantProvider provider) {
    return Container(
      margin: EdgeInsets.symmetric(vertical: 8.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: [
          Flexible(
            child: TextField(
              controller: provider.addReviewInputController,
              decoration: InputDecoration(
                hintText: 'Add new review',
              ),
            ),
          ),
          SizedBox(width: 12.0),
          provider.customerReviewState == ResultState.Loading
              ? Center(
                  child: CircularProgressIndicator(
                    color: lightGreen,
                  ),
                )
              : ElevatedButton(
                  style: ButtonStyle(
                      backgroundColor: MaterialStateProperty.all(darkGreen)),
                  onPressed: () {
                    provider.postReview();
                  },
                  child: Text('Post'),
                ),
        ],
      ),
    );
  }

  void _showToast(String message) {
    Fluttertoast.showToast(
      msg: message,
      gravity: ToastGravity.CENTER,
      timeInSecForIosWeb: 1,
    );
  }
}
