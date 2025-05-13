import 'package:coffee_app/services/login_service.dart';
import 'package:coffee_app/services/sqflite_login_service.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:path/path.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:sqflite/sqflite.dart';

part 'service_locator.g.dart';

// THESE SERVICES ARE FOR DEPENDENCY INJECTION

@riverpod
Future<Database> sqfliteDatabase(Ref ref) async {
  final dbPath = join(await getDatabasesPath(), 'coffee_app.db');

  // As this is a technical test, i want to create a default user for the app
  // When i create the database for the first time
  final db =
      await openDatabase(dbPath, version: 1, onCreate: (db, version) async {
    await db.execute('''CREATE TABLE users(
          id INTEGER PRIMARY KEY, 
          username TEXT NOT NULL, 
          password TEXT NOT NULL);''');

    await db.insert('users', {'username': 'oscar', 'password': 'oscar123'});
  });
  return db;
}

@riverpod
Future<LoginService> loginService(Ref ref) async {
  final sqliteDb = await ref.watch(sqfliteDatabaseProvider.future);

  return SqfLiteLoginService(db: sqliteDb);
}
