import 'package:coffee_app/utils/colors.dart';
import 'package:coffee_app/view_models/login_viewmodel.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_svg/flutter_svg.dart';

class LoginView extends ConsumerWidget {
  LoginView({super.key});

  final usernameController = TextEditingController();
  final passwordController = TextEditingController();

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final loginViewModel = ref.watch(loginViewModelProvider);

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
              child: TextField(
                controller: usernameController,
                decoration: const InputDecoration(
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
              child: TextField(
                controller: passwordController,
                obscureText: true,
                decoration: const InputDecoration(
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
              onPressed: () async {
                final userLogged = await ref
                    .read(loginViewModelProvider.notifier)
                    .login(usernameController.text, passwordController.text);
                
                if (userLogged && context.mounted) {
                  Navigator.of(context).pushNamed('/home');
                }
              },
              style: FilledButton.styleFrom(backgroundColor: kButtonColor),
              child: loginViewModel.maybeWhen(
                  orElse: () => const Text('Login'),
                  loading: () => const CircularProgressIndicator()),
            ),

            const SizedBox(
              height: 20,
            ),

            //Error message
            loginViewModel.maybeWhen(
                orElse: () => const SizedBox.shrink(),
                error: (error, stack) {

                  final errorMessage = (error as Exception).toString();
                  final message = errorMessage.split(':').last.trim();
                  return Text(
                      message.toString(),
                      style: const TextStyle(color: Colors.red, fontSize: 12, fontWeight: FontWeight.bold),
                      
                    );
                })
          ],
        ),
      ),
    ));
  }
}
