import 'package:flutter/material.dart';
import 'package:line_icons/line_icons.dart';
import 'package:restaurant_app/model/restaurant.dart';
import 'package:restaurant_app/pages/detail_restaurant_page.dart';
import 'package:restaurant_app/utils/constants.dart';
import 'package:restaurant_app/widgets/card_item.dart';

class SearchPage extends StatefulWidget {
  final List<Restaurant> restaurants;

  const SearchPage({Key? key, required this.restaurants}) : super(key: key);

  @override
  _SearchPageState createState() => _SearchPageState();
}

class _SearchPageState extends State<SearchPage> {
  final TextEditingController _controller = TextEditingController();
  List<Restaurant> _tempData = [];
  bool _shouldListShown = false;
  bool _shouldEmptyListShown = false;

  @override
  void initState() {
    _controller.text = '';
    _tempData = widget.restaurants;
    super.initState();
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      width: MediaQuery.of(context).size.width,
      child: Column(
        children: [
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16.0),
            child: TextField(
              controller: _controller,
              onChanged: _searchList,
              onSubmitted: _searchList,
              decoration: InputDecoration(
                  border: UnderlineInputBorder(
                    borderSide: BorderSide(
                      color: darkGreen,
                    ),
                  ),
                  fillColor: darkGreen,
                  focusColor: darkGreen,
                  hoverColor: darkGreen,
                  suffixIcon: GestureDetector(
                    child: Icon(LineIcons.search, color: darkGreen),
                    onTap: () {
                      _searchList(_controller.text);
                    },
                  ),
                  hintText: 'Search here',
                  hintStyle: TextStyle(color: Colors.black38)),
            ),
          ),
          SizedBox(height: 20),
          Expanded(
            child: _shouldListShown
                ? ListView.builder(
                    padding: EdgeInsets.symmetric(horizontal: 12.0),
                    itemCount: _tempData.length,
                    itemBuilder: (ctx, index) {
                      return CardItem(
                        item: _tempData[index],
                        onTapCallback: (restaurant) {
                          Navigator.of(context).pushNamed(
                              DetailRestaurantPage.route,
                              arguments: restaurant);
                        },
                      );
                    },
                  )
                : Container(
                    child: Center(
                      child: Column(
                        children: [
                          SizedBox(height: 56.0),
                          Icon(LineIcons.mapMarked,
                              size: 142.0, color: darkGreen.withOpacity(0.4)),
                          Text('Explore your favorite restaurants with us.',
                              style: TextStyle(
                                  fontSize: 18.0,
                                  fontWeight: FontWeight.bold,
                                  color: darkGreen),
                              textAlign: TextAlign.center)
                        ],
                      ),
                    ),
                  ),
          ),
          Container(
            child: _shouldEmptyListShown
                ? Expanded(
                    flex: 4,
                    child: Center(
                      child: Text('No item found!',
                          style: TextStyle(
                              color: darkGreen,
                              fontSize: 18.0,
                              fontWeight: FontWeight.bold)),
                    ),
                  )
                : null,
          ),
        ],
      ),
    );
  }

  void _searchList(String query) {
    if (query.isEmpty) {
      setState(() {
        _tempData = widget.restaurants;
        _shouldListShown = false;
        _shouldEmptyListShown = false;
      });
      return;
    }

    List<Restaurant> result = [];

    for (var restaurant in widget.restaurants) {
      if (restaurant.name.toLowerCase().contains(query.toLowerCase())) {
        result.add(restaurant);
      }
    }

    setState(() {
      _shouldListShown = true;
      _tempData = result;

      if (_tempData.isEmpty) {
        _shouldEmptyListShown = true;
      } else {
        _shouldEmptyListShown = false;
      }
    });
  }
}
