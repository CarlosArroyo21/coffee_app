import 'package:coffee_app/utils/colors.dart';
import 'package:flutter/material.dart';

class CustomIconButton extends StatelessWidget {
  const CustomIconButton({super.key, required this.label, this.onPressed, this.width, this.height, this.icon});

  final Widget label;
  final VoidCallback? onPressed;
  final double? width;
  final double? height;
  final Widget? icon;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: width,
      height: height,
      child: FilledButton.icon(
          onPressed: onPressed,
          style: FilledButton.styleFrom(backgroundColor: kButtonColor),
          icon: icon,
          label: label),
    );
  }
}
