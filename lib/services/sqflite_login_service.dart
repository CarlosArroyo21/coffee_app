import 'package:coffee_app/models/user_model.dart';
import 'package:coffee_app/services/login_service.dart';
import 'package:sqflite/sqflite.dart';

class SqfLiteLoginService extends LoginService {
  final Database _db;

  SqfLiteLoginService({required Database db}) : _db = db;

  @override
  Future<UserModel> login(String username, String password) async {
    final dbUser = await _db.query('users', where: 'username = ? AND password = ?', whereArgs: [username, password], limit: 1);
    
    if (dbUser.isEmpty) throw Exception('User not found. Try again with different credentials.');

    final userData = UserModel.fromMap(dbUser.first);
    return userData;
  
  }
}