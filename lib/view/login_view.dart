import 'package:coffee_app/utils/colors.dart';
import 'package:coffee_app/utils/widgets/buttons.dart';
import 'package:coffee_app/utils/widgets/form_textfields.dart';
import 'package:coffee_app/view_models/login_view_model.dart';
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
          spacing: 30,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            //Logo
            SvgPicture.asset(
              'assets/icons/logo.svg',
              width: 200,
            ),
            //Title
            const Text(
              "LOGIN",
              style: TextStyle(
                  fontSize: 30, fontWeight: FontWeight.bold, color: kTextColor),
            ),
            //Username Form
            CustomTextField(
              controller: usernameController,
              labelText: 'Username',
              prefixIcon: const Icon(Icons.person, color: kButtonColor),
            ),
            //Password Form
            PasswordTextField(
                controller: passwordController, labelText: 'Password'),
            //Login Button
            CustomIconButton(
              width: 150,
              height: 50,
              onPressed: () async {
                final userLogged = await ref
                    .read(loginViewModelProvider.notifier)
                    .login(usernameController.text, passwordController.text);

                if (userLogged && context.mounted) {
                  Navigator.of(context).pushNamed('/home');
                }
              },
              icon: const Icon(
                Icons.login_rounded,
                size: 20,
              ),
              label: loginViewModel.maybeWhen(
                  orElse: () => const Text('Login'),
                  loading: () => const CircularProgressIndicator()),
            ),
            //Error message
            loginViewModel.maybeWhen(
                orElse: () => const SizedBox.shrink(),
                error: (error, stack) {
                  final errorMessage = (error as Exception).toString();
                  final message = errorMessage.split(':').last.trim();
                  return Text(
                    message.toString(),
                    style: TextStyle(
                        color: Colors.red[700],
                        fontSize: 14,
                        fontWeight: FontWeight.bold),
                  );
                })
          ],
        ),
      ),
    ));
  }
}
