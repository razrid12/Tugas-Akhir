import 'package:shared_preferences/shared_preferences.dart';

class SessionManager {
  // Menyimpan data sesi pengguna
  static Future<void> saveSession(String username, String password) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.setString('username', username);
    prefs.setString('password', password);
  }

  // Mengambil data sesi
  static Future<Map<String, String>> getSession() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String? username = prefs.getString('username');
    String? password = prefs.getString('password');

    return {'username': username ?? '', 'password': password ?? ''};
  }

  // Menghapus data sesi (logout)
  static Future<void> clearSession() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.remove('username');
    prefs.remove('password');
  }

  // Mengecek apakah pengguna sudah login
  static Future<bool> isLoggedIn() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    return prefs.containsKey('username') && prefs.containsKey('password');
  }

  // Fungsi login, cocokkan username dan password
  static Future<bool> login(String username, String password) async {
    // Biasanya, Anda akan memeriksa username dan password dengan API atau database lokal
    Map<String, String> session = await getSession();
    if (session['username'] == username && session['password'] == password) {
      return true;
    }
    return false;
  }
}
