import 'package:coffee_app/utils/colors.dart';
import 'package:coffee_app/utils/routes.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  runApp(const ProviderScope(child: MainApp()));
}

class MainApp extends StatelessWidget {
  const MainApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      routes: kRoutes,
      theme: ThemeData.from(
          colorScheme: ColorScheme.fromSeed(
            seedColor: kButtonColor,
            dynamicSchemeVariant: DynamicSchemeVariant.fidelity,
            surface: kBackgroundColor)),
      debugShowCheckedModeBanner: false,
      initialRoute: '/login',
    );
  }
}
