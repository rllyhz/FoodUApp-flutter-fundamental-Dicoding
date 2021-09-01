import 'package:flutter/material.dart';

class CardError extends StatelessWidget {
  final String label;
  final String description;
  final double height;
  final double fontSize;

  CardError(
      {Key? key,
      required this.label,
      required this.description,
      this.height = 120.0,
      this.fontSize = 18.0})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      height: height,
      padding: EdgeInsets.symmetric(horizontal: 16.0, vertical: 12.0),
      decoration: BoxDecoration(
        color: Colors.red.shade100,
        borderRadius: BorderRadius.circular(4.0),
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text(
            label,
            style: TextStyle(
              color: Colors.black.withOpacity(0.75),
              fontSize: fontSize,
              fontWeight: FontWeight.bold,
            ),
          ),
          SizedBox(height: 12.0),
          Text(
            description,
            style: TextStyle(
              color: Colors.black.withOpacity(0.75),
              fontSize: fontSize,
            ),
          ),
        ],
      ),
    );
  }
}
