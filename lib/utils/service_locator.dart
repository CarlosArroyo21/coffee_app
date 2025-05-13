import 'package:coffee_app/services/login_service.dart';
import 'package:coffee_app/services/sqflite_login_service.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'service_locator.g.dart';

// THESE SERVICES ARE FOR DEPENDENCY INJECTION
@riverpod
LoginService loginService(Ref ref) => SqfLiteLoginService();

