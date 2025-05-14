import 'package:coffee_app/utils/colors.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class CustomTextField extends StatelessWidget {
  const CustomTextField(
      {super.key,
      required this.controller,
      this.width,
      this.height,
      this.keyboardType,
      this.onChanged,
      this.inputFormatters,
      this.labelText, this.prefixIcon});
  final TextEditingController controller;
  final double? width;
  final void Function(String)? onChanged;
  final double? height;
  final TextInputType? keyboardType;
  final String? labelText;
  final List<TextInputFormatter>? inputFormatters;
  final Widget? prefixIcon;

  @override
  Widget build(BuildContext context) {
    return Container(
      constraints: const BoxConstraints(maxWidth: 300, minHeight: 50),
      width: width,
      height: height,
      child: TextField(
        controller: controller,
        onChanged: onChanged,
        inputFormatters: inputFormatters,
        cursorColor: kButtonColor,
        keyboardType: keyboardType,
        decoration: InputDecoration(
          prefixIcon: prefixIcon,
          filled: true,
          fillColor: kAppBarColor.withValues(alpha: 0.5),
          border: const OutlineInputBorder(
            borderSide: BorderSide.none,
            borderRadius: BorderRadius.all(Radius.circular(20)),
          ),
          floatingLabelAlignment: FloatingLabelAlignment.start,
          floatingLabelBehavior: FloatingLabelBehavior.auto,
          labelText: labelText,
          labelStyle:
              const TextStyle(color: kTextColor, fontWeight: FontWeight.w700),
        ),
      ),
    );
  }
}

class PasswordTextField extends StatefulWidget {
  const PasswordTextField(
      {super.key,
      required this.controller,
      this.width,
      this.height,
      this.keyboardType,
      this.labelText});
  final TextEditingController controller;
  final double? width;
  final double? height;
  final TextInputType? keyboardType;
  final String? labelText;

  @override
  State<PasswordTextField> createState() => _PasswordTextFieldState();
}

class _PasswordTextFieldState extends State<PasswordTextField> {
  bool showPassword = false;

  @override
  Widget build(BuildContext context) {
    return Container(
      constraints: const BoxConstraints(maxWidth: 300, minHeight: 50),
      width: widget.width,
      height: widget.height,
      child: TextField(
        controller: widget.controller,
        cursorColor: kButtonColor,
        keyboardType: widget.keyboardType,
        obscureText: !showPassword,
        decoration: InputDecoration(
          prefixIcon: const Icon(Icons.password_rounded, color: kButtonColor),
          suffixIcon: IconButton(
              onPressed: () {
                setState(() {
                  showPassword = !showPassword;
                });
              },
              icon: Icon(showPassword ? Icons.visibility : Icons.visibility_off,
                  color: kButtonColor)),
          filled: true,
          fillColor: kAppBarColor.withValues(alpha: 0.5),
          border: const OutlineInputBorder(
            borderSide: BorderSide.none,
            borderRadius: BorderRadius.all(Radius.circular(20)),
          ),
          floatingLabelAlignment: FloatingLabelAlignment.start,
          floatingLabelBehavior: FloatingLabelBehavior.auto,
          labelText: widget.labelText,
          labelStyle:
              const TextStyle(color: kTextColor, fontWeight: FontWeight.w700),
        ),
      ),
    );
  }
}
