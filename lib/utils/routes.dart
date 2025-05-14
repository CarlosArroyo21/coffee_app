import 'package:coffee_app/view/home_view.dart';
import 'package:coffee_app/view/login_view.dart';
import 'package:coffee_app/view/modify_coffee_view.dart';
import 'package:coffee_app/view/register_coffee_view.dart';

final kRoutes = {
  '/login': (context) => LoginView(),
  '/home': (context) => const HomeView(),
  '/newCoffee': (context) => const RegisterCoffeeView(),
  '/editCoffee': (context) => const ModifyCoffeeView(),
};