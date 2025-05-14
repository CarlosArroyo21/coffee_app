
import 'package:coffee_app/models/coffee_model.dart';
import 'package:coffee_app/utils/service_locator.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'coffee_view_model.g.dart';
@riverpod
class CoffeeViewModel extends _$CoffeeViewModel {
  @override
  AsyncValue<List<CoffeeModel>> build() {
    return const AsyncData([]);
  }


  Future<void> getCoffees() async {
    try {
      state = const AsyncLoading();
      final coffeeService = await ref.read(coffeeServiceProvider.future);
      final coffees = await coffeeService.getCoffees();
      state = AsyncData(coffees);
    } catch (error) {
      state = AsyncError(error, StackTrace.current);
    }
  }

  Future<bool> addCoffee(CoffeeModel coffee) async {

    try {
      state = const AsyncLoading();

      //Wait for coffee service to be ready
      final coffeeService = await ref.read(coffeeServiceProvider.future);
        
      final coffeeId = await coffeeService.addCoffee(coffee);
      
      //If the id is not 0, then the coffee was added to the database
      if (coffeeId != 0) {
        await getCoffees();
        return true;
      }

      return false;
      
    } catch (error) {
      state = AsyncError(error, StackTrace.current);
      return false;
    }
  }

  Future<bool> updateCoffee(CoffeeModel coffee) async {
    try {
      state = const AsyncLoading();
      
      final coffeeService = await ref.read(coffeeServiceProvider.future);

      coffeeService.updateCoffee(coffee).then((_) => getCoffees());

      return true;
    } catch (error) {
      state = AsyncError(error, StackTrace.current);
      return false;
    }
  }

  Future<bool> deleteCoffee(CoffeeModel coffee) async {
    try {
      state = const AsyncLoading();
      final coffeeService = await ref.read(coffeeServiceProvider.future);
      coffeeService.deleteCoffee(coffee).then((_) => getCoffees());

      return true;
    } catch (error) {
      state = AsyncError(error, StackTrace.current);
      return false;
    }
  }
}

@riverpod
int totalCoffeeQuantity(Ref ref) {
  final soldCoffees = ref.watch(coffeeViewModelProvider).valueOrNull ?? [];

  return soldCoffees.fold(0, (total, coffee) => total + coffee.quantity);
}

@riverpod
double totalEarnings(Ref ref) {
  final soldCoffees = ref.watch(coffeeViewModelProvider).valueOrNull ?? [];

  return soldCoffees.fold(0, (total, coffee) => total + coffee.price);
}