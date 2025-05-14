import 'package:coffee_app/models/user_model.dart';
import 'package:coffee_app/utils/service_locator.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'login_viewmodel.g.dart';

@riverpod
class LoginViewModel extends _$LoginViewModel {
  @override
  AsyncValue<UserModel?> build() {
    return const AsyncData(null);
  }

  void _validateData(String username, String password) {
    if (username.isEmpty) {
      throw Exception('Username is required.');
    }

    if (password.isEmpty) {
      throw Exception('Password is required.');
    }
  }

  Future<bool> login(String username, String password) async {

    _validateData(username, password);

    state = const AsyncLoading();

    //Wait for login service database
    final loginService = await ref.read(loginServiceProvider.future);

    //Alternative way to use try - catch with riverpod
    state = await AsyncValue.guard(
        () async => await loginService.login(username, password));
    
    //To show the message for x seconds, then clear the message
    if (state.hasError) {
      Future.delayed(const Duration(seconds: 3), () => state = const AsyncData(null));
      return false;
    }

    return state.hasValue;
  }
}
