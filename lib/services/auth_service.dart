import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';

class AuthService {
  Future<Database> _getDatabase() async {
    final databasePath = await getDatabasesPath();
    final path = join(databasePath, 'users.db');

    return openDatabase(path, version: 1, onCreate: (db, version) {
      return db.execute(
        'CREATE TABLE users(id INTEGER PRIMARY KEY AUTOINCREMENT, username TEXT, email TEXT, phone TEXT, password TEXT)',
      );
    });
  }

  Future<bool> register(
      String username, String email, String phone, String password) async {
    final db = await _getDatabase();

    await db.insert('users', {
      'username': username,
      'email': email,
      'phone': phone,
      'password': password,
    });

    return true;
  }
}
