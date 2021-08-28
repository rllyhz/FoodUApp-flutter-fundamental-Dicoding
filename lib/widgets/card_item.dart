import 'package:flutter/material.dart';
import 'package:line_icons/line_icons.dart';
import 'package:restaurant_app/model/restaurant.dart';
import 'package:restaurant_app/utils/constants.dart';

class CardItem extends StatefulWidget {
  final Restaurant item;
  final Function(Restaurant) onTapCallback;

  const CardItem({Key? key, required this.item, required this.onTapCallback})
      : super(key: key);

  @override
  _CardItemState createState() => _CardItemState();
}

class _CardItemState extends State<CardItem> {
  bool _isFav = false;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        widget.onTapCallback(widget.item);
      },
      child: Card(
        margin: EdgeInsets.only(bottom: 12.0, left: 4.0, right: 4.0),
        child: Column(
          children: [
            ClipRRect(
              borderRadius: BorderRadius.circular(4.0),
              child: Stack(
                children: [
                  Hero(
                    tag: widget.item.id,
                    child: Image.network(
                      widget.item.pictureId,
                      width: MediaQuery.of(context).size.width,
                    ),
                  ),
                  Positioned(
                    bottom: 12.0,
                    right: 12.0,
                    child: Container(
                      padding:
                          EdgeInsets.symmetric(horizontal: 12.0, vertical: 4.0),
                      decoration: BoxDecoration(
                          color: lightGreen,
                          borderRadius: BorderRadius.circular(4.0)),
                      child: Center(
                          child: Text(
                        widget.item.rating.toString(),
                        style: TextStyle(
                            fontSize: 18.0, fontWeight: FontWeight.bold),
                      )),
                    ),
                  ),
                ],
              ),
            ),
            SizedBox(height: 12.0),
            Container(
              padding: EdgeInsets.only(
                  top: 8.0, left: 18.0, right: 18.0, bottom: 16.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Expanded(
                      child: CircleAvatar(
                        backgroundColor: darkGreen,
                        backgroundImage: NetworkImage(widget.item.pictureId),
                      ),
                      flex: 1),
                  SizedBox(width: 12.0),
                  Expanded(
                    flex: 6,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          widget.item.name,
                          style: TextStyle(
                            fontSize: 20.0,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        SizedBox(height: 4.0),
                        Row(children: [
                          Icon(LineIcons.mapMarker, size: 18.0),
                          SizedBox(width: 4.0),
                          Text(
                            widget.item.city,
                            style: TextStyle(fontSize: 18.0),
                          )
                        ]),
                      ],
                    ),
                  ),
                  Expanded(
                    flex: 1,
                    child: IconButton(
                      onPressed: () {
                        setState(() {
                          _isFav = !_isFav;
                        });
                      },
                      icon: Icon(
                        _isFav ? LineIcons.heartAlt : LineIcons.heart,
                        color: lightGreen,
                        size: 28.0,
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}