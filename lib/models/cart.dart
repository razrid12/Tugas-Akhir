import 'package:shared_preferences/shared_preferences.dart';

class Cart {
  static Future<void> addProductToCart(Map<String, dynamic> product) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    List<String> cart = prefs.getStringList('cart') ?? [];
    cart.add(product['name']); // Simpan nama produk ke dalam list cart
    prefs.setStringList('cart', cart); // Simpan kembali ke SharedPreferences
  }

  static Future<List<String>> getCart() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    return prefs.getStringList('cart') ?? [];
  }
}
