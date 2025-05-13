abstract class LoginService {
  Future<bool> login(String username, String password);
  Future<bool> logout();
}