import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:line_icons/line_icons.dart';
import 'package:restaurant_app/model/restaurant.dart';
import 'package:restaurant_app/utils/constants.dart';

class DetailRestaurantPage extends StatefulWidget {
  const DetailRestaurantPage({Key? key}) : super(key: key);

  static final route = "/detail";

  @override
  _DetailRestaurantPageState createState() => _DetailRestaurantPageState();
}

class _DetailRestaurantPageState extends State<DetailRestaurantPage> {
  int _selectedOptionMenu = 0;
  ScrollController _controller = ScrollController();
  bool _isFav = false;

  @override
  void initState() {
    super.initState();
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final restaurant = ModalRoute.of(context)?.settings.arguments as Restaurant;

    return Scaffold(
      body: SafeArea(
        child: CustomScrollView(
          physics: const BouncingScrollPhysics(),
          slivers: [
            SliverAppBar(
              expandedHeight: 260.0,
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
                      setState(() {
                        _isFav = !_isFav;
                      });
                    },
                    icon: Icon(
                      _isFav ? LineIcons.heartAlt : LineIcons.heart,
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
                        restaurant.pictureId,
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
                        style: TextStyle(
                            fontSize: 24.0, fontWeight: FontWeight.bold),
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
                    style:
                        TextStyle(fontSize: 20.0, fontWeight: FontWeight.bold),
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
                    style:
                        TextStyle(fontSize: 20.0, fontWeight: FontWeight.bold),
                  ),
                ),
                SizedBox(height: 4.0),
                Row(
                  children: [
                    SizedBox(width: 12.0),
                    _buildMenuItem('Foods',
                        _selectedOptionMenu == 0 ? darkGreen : Colors.grey, 0),
                    SizedBox(width: 8.0),
                    _buildMenuItem('Drinks',
                        _selectedOptionMenu == 1 ? darkGreen : Colors.grey, 1),
                  ],
                ),
                SizedBox(height: 12.0),
                Container(
                  padding: const EdgeInsets.only(
                      left: 12.0, right: 12.0, bottom: 12.0),
                  height: 240,
                  child: _buildMenuOptions(
                      context, restaurant, _selectedOptionMenu),
                ),
              ]),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildMenuOptions(
      BuildContext context, Restaurant restaurant, int selectedOptionMenu) {
    List menu = [];
    if (selectedOptionMenu == 0) {
      menu = restaurant.menus.foods;
    } else {
      menu = restaurant.menus.drinks;
    }

    return ListView.builder(
      itemCount: menu.length,
      controller: _controller,
      itemBuilder: (ctx, index) {
        return Container(
          padding: EdgeInsets.all(8.0),
          decoration: BoxDecoration(
            border: Border(
                bottom: BorderSide(width: 1.0, color: Colors.grey.shade400)),
          ),
          child: Text(menu[index].name, style: TextStyle(fontSize: 16.0)),
        );
      },
    );
  }

  Widget _buildMenuItem(String title, Color backgroundColor, int index) {
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
        setState(() {
          _selectedOptionMenu = index;
          _controller.animateTo(0.0,
              duration: Duration(milliseconds: 200), curve: Curves.easeInOut);
        });
      },
      child: Text(
        title,
        style: TextStyle(color: Colors.white),
      ),
    );
  }
}
