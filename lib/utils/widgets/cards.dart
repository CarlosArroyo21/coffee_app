import 'package:coffee_app/utils/colors.dart';
import 'package:flutter/material.dart';

class CustomValueCard extends StatelessWidget {
  const CustomValueCard(
      {super.key,
      this.width = 200,
      this.height = 150,
      required this.title,
      required this.value});

  final String title;
  final String value;
  final double? width;
  final double? height;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: height,
      width: width,
      child: Card(
        elevation: 2,
        color: kAppBarColor,
        shadowColor: kSecondaryColor,
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(spacing: 20, children: [
            Text(
              title,
              style: const TextStyle(
                  fontSize: 20, fontWeight: FontWeight.bold, color: kTextColor),
            ),
            Text(
              value,
              style: const TextStyle(
                  fontSize: 40,
                  fontWeight: FontWeight.bold,
                  color: kSecondaryColor),
            )
          ]),
        ),
      ),
    );
  }
}
