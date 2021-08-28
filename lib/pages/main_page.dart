import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:google_nav_bar/google_nav_bar.dart';
import 'package:line_icons/line_icons.dart';
import 'package:restaurant_app/model/restaurant.dart';
import 'package:restaurant_app/pages/home_page.dart';
import 'package:restaurant_app/pages/profile_page.dart';
import 'package:restaurant_app/pages/search_page.dart';
import 'package:restaurant_app/utils/constants.dart';

import 'favorites_page.dart';

class MainPage extends StatefulWidget {
  const MainPage({Key? key, required this.title}) : super(key: key);

  static const route = "/home";
  final String title;

  @override
  _MainPageState createState() => _MainPageState();
}

class _MainPageState extends State<MainPage> {
  PageController? _controller;
  int _selectedIndex = 0;
  List<Restaurant> _restaurants = [];

  @override
  void initState() {
    super.initState();
    _controller = PageController(initialPage: 0);
    _loadData();
  }

  @override
  void dispose() {
    _controller?.dispose();
    super.dispose();
  }

  void _loadData() async {
    String jsonData = await rootBundle.loadString('assets/restaurants.json');
    setState(() {
      _restaurants = parseRestaurantData(jsonData);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: _buildAppBarUI(context),
      bottomNavigationBar: _buildBottomNavBarUI(context),
      backgroundColor: Colors.grey[50],
      body: PageView(
        scrollDirection: Axis.horizontal,
        controller: _controller,
        onPageChanged: (newSelectedIndex) {
          setState(() {
            _selectedIndex = newSelectedIndex;
          });
        },
        physics: BouncingScrollPhysics(),
        children: [
          HomePage(restaurants: _restaurants),
          SearchPage(restaurants: _restaurants),
          FavoritesPage(),
          ProfilePage(),
        ],
      ),
    );
  }

  Container _buildBottomNavBarUI(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.only(
            topLeft: Radius.circular(12.0), topRight: Radius.circular(12.0)),
        color: lightGreen,
      ),
      child: GNav(
        onTabChange: (index) {
          _controller?.animateToPage(index,
              duration: Duration(milliseconds: 350), curve: Curves.easeInOut);
        },
        selectedIndex: _selectedIndex,
        tabMargin: EdgeInsets.symmetric(vertical: 8.0, horizontal: 12.0),
        padding: EdgeInsets.all(12.0),
        iconSize: 24,
        curve: Curves.easeInExpo,
        duration: Duration(milliseconds: 900),
        gap: 8.0,
        haptic: true,
        color: darkGreen,
        activeColor: Colors.white,
        tabBackgroundColor: darkGreen,
        backgroundColor: Colors.transparent,
        tabs: [
          GButton(
            icon: LineIcons.home,
            text: 'Home',
          ),
          GButton(
            icon: LineIcons.search,
            text: 'Search',
          ),
          GButton(
            icon: LineIcons.heart,
            text: 'Saved',
          ),
          GButton(
            icon: LineIcons.user,
            text: 'Profile',
          ),
        ],
      ),
    );
  }

  AppBar _buildAppBarUI(BuildContext context) {
    return AppBar(
      backgroundColor: Colors.transparent,
      shadowColor: Colors.transparent,
      title: Text(widget.title, style: TextStyle(color: Colors.black)),
      centerTitle: true,
    );
  }
}
