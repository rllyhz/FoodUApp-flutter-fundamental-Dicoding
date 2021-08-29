import 'package:flutter/material.dart';

class CardError extends StatelessWidget {
  final String label;
  final String description;

  const CardError({Key? key, required this.label, required this.description})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 16.0, vertical: 12.0),
      decoration: BoxDecoration(
        color: Colors.red.shade200,
        borderRadius: BorderRadius.circular(8.0),
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text(
            label,
            style: TextStyle(
              color: Colors.black.withOpacity(0.75),
              fontSize: 18.0,
              fontWeight: FontWeight.bold,
            ),
          ),
          SizedBox(height: 12.0),
          Text(
            description,
            style: TextStyle(
              color: Colors.black.withOpacity(0.75),
              fontSize: 18.0,
            ),
          ),
        ],
      ),
    );
  }
}
