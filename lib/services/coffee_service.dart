import 'package:coffee_app/models/coffee_model.dart';

abstract class CoffeeService {
  Future<List<CoffeeModel>> getCoffees();
  Future<int> addCoffee(CoffeeModel coffee);
  Future<void> updateCoffee(CoffeeModel coffee);
  Future<void> deleteCoffee(CoffeeModel coffee);
}