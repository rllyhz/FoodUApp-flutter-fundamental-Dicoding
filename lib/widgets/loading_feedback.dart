import 'package:flutter/material.dart';
import 'package:restaurant_app/utils/constants.dart';

class LoadingFeedback extends StatelessWidget {
  const LoadingFeedback({Key? key, required this.text, this.fontSize = 18.0})
      : super(key: key);

  final String text;
  final double fontSize;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        CircularProgressIndicator(
          color: lightGreen,
        ),
        SizedBox(height: 16.0),
        Text(text,
            style: TextStyle(
              color: darkGreen,
              fontSize: fontSize,
            )),
      ],
    );
  }
}
