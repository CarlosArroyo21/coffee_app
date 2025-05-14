import 'package:coffee_app/models/coffee_model.dart';
import 'package:coffee_app/services/coffee_service.dart';
import 'package:sqflite/sqlite_api.dart';

class SqfLiteCoffeeService implements CoffeeService {
  final Database _db;

  SqfLiteCoffeeService({required Database db}) : _db = db;

  @override
  Future<int> addCoffee(CoffeeModel coffee) async {
    try {
      return await _db.insert('coffees', coffee.toMap());
    } catch (error) {
      throw Exception(error.toString());
    }
  }

  @override
  Future<void> deleteCoffee(CoffeeModel coffee) async {
    try {
      final rowsDeleted = await _db.delete('coffees', where: 'id = ?', whereArgs: [coffee.id]);

      if (rowsDeleted == 0) {
        throw Exception('No rows deleted');
      }

      if (rowsDeleted > 1) {
        throw Exception('More than one row deleted');
      }
    } catch (error) {
      throw Exception(error.toString());
    }
  }

  @override
  Future<List<CoffeeModel>> getCoffees() {
    try {
      return _db.query('coffees').then(
          (dbCoffees) => dbCoffees.map((dbCoffee) => CoffeeModel.fromMap(dbCoffee)).toList());
    } catch (error) {
      throw Exception(error.toString());
    }
  }

  @override
  Future<void> updateCoffee(CoffeeModel coffee) async {
    try {
      final rowsUpdated = await _db.update('coffees', coffee.toMap(), where: 'id = ?', whereArgs: [coffee.id]);

      if (rowsUpdated == 0) {
        throw Exception('No rows updated');
      }

      if (rowsUpdated > 1) {
        throw Exception('More than one row updated');
      }

    } catch (error) {
      throw Exception(error.toString());
    }
  }
}
