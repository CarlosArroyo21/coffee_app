import 'package:coffee_app/utils/colors.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

class LoginView extends StatelessWidget {
  const LoginView({super.key});

  @override
  Widget build(BuildContext context) {
    final screenSize = MediaQuery.of(context).size;
    return Scaffold(
        body: SingleChildScrollView(
          child: SizedBox(
            width: screenSize.width,
            height: screenSize.height,
            child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            //Logo
            SvgPicture.asset(
              'assets/icons/logo.svg',
              width: 200,
            ),
            const SizedBox(
              height: 20,
            ),
            //Title
            const Text(
              "LOGIN",
              style: TextStyle(
                  fontSize: 30, fontWeight: FontWeight.bold, color: kTextColor),
            ),
            const SizedBox(
              height: 20,
            ),
            //Username Form
            Container(
              constraints: const BoxConstraints(maxWidth: 300, minHeight: 50),
              child: const TextField(
                decoration: InputDecoration(
                  border: OutlineInputBorder(),
                  labelText: 'Username',
                ),
              ),
            ),
            const SizedBox(
              height: 20,
            ),
            //Password Form
            Container(
              constraints: const BoxConstraints(maxWidth: 300, minHeight: 50),
              child: const TextField(
                obscureText: true,
                decoration: InputDecoration(
                  border: OutlineInputBorder(),
                  labelText: 'Password',
                ),
              ),
            ),
            const SizedBox(
              height: 20,
            ),
            //Login Button
            FilledButton(
                onPressed: () {
                  
                },
                style: FilledButton.styleFrom(backgroundColor: kButtonColor),
                child: const Text('Login'))
          ],
        ),
          ),
        ));
  }
}
