import 'package:coffee_app/models/user_model.dart';

abstract class LoginService {
  Future<UserModel?> login(String username, String password);
  Future<bool> logout();
}