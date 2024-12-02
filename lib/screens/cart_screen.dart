import 'package:flutter/material.dart';
import 'dart:convert';
import 'package:shared_preferences/shared_preferences.dart';
import 'payment_screen.dart';

class CartScreen extends StatefulWidget {
  @override
  _CartScreenState createState() => _CartScreenState();
}

class _CartScreenState extends State<CartScreen> {
  List<Map<String, dynamic>> cartItems = [];
  List<bool> selectedItems = []; // Menyimpan status checklist produk
  bool isLoading = false; // Untuk menampilkan indikator loading

  @override
  void initState() {
    super.initState();
    _loadCartItems();
  }

  // Memuat data keranjang dari SharedPreferences
  Future<void> _loadCartItems() async {
    final prefs = await SharedPreferences.getInstance();
    final cart = prefs.getStringList('cart') ?? [];
    setState(() {
      cartItems = cart
          .map((item) => json.decode(item) as Map<String, dynamic>)
          .toList();
      selectedItems = List<bool>.filled(
          cartItems.length, false); // Semua item tidak dicentang secara default
    });
  }

  // Menghapus produk dari keranjang dan memperbarui SharedPreferences dengan validasi
  Future<void> _removeFromCart(int index) async {
    setState(() {
      isLoading = true;
    });

    final prefs = await SharedPreferences.getInstance();
    final cart = prefs.getStringList('cart') ?? [];

    if (index >= 0 && index < cart.length) {
      try {
        // Memfilter item dari cartItems dan selectedItems berdasarkan index
        cartItems = cartItems.where((item) {
          return cartItems.indexOf(item) !=
              index; // Menghilangkan item yang ingin dihapus
        }).toList();

        selectedItems =
            List<bool>.generate(cartItems.length, (i) => selectedItems[i]);

        // Menyimpan kembali ke SharedPreferences
        await prefs.setStringList(
            'cart', cartItems.map((item) => json.encode(item)).toList());

        // Tampilkan notifikasi sukses
        _showSuccessDialog('Item berhasil dihapus.');
      } catch (e) {
        // Tampilkan notifikasi gagal
        _showErrorDialog('Gagal menghapus item: $e');
      } finally {
        setState(() {
          isLoading = false;
        });
      }
    } else {
      // Tampilkan error jika indeks tidak valid
      _showErrorDialog('Indeks tidak valid.');
    }
  }

  // Dialog error (Gagal)
  void _showErrorDialog(String message) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: Text('Error'),
        content: Text(message),
        actions: [
          TextButton(
            onPressed: () {
              Navigator.pop(context); // Tutup dialog setelah tombol OK ditekan
            },
            child: Text('OK'),
          ),
        ],
      ),
    );
  }

  // Dialog sukses (Berhasil)
  void _showSuccessDialog(String message) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: Text('Sukses'),
        content: Text(message),
        actions: [
          TextButton(
            onPressed: () {
              Navigator.pop(context); // Tutup dialog setelah tombol OK ditekan
            },
            child: Text('OK'),
          ),
        ],
      ),
    );
  }

  // Menghitung total harga berdasarkan produk yang dicentang
  double _calculateTotalPrice() {
    double total = 0;
    for (int i = 0; i < cartItems.length; i++) {
      if (selectedItems[i]) {
        total += cartItems[i]['price'];
      }
    }
    return total;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Keranjang'),
        backgroundColor: Colors.green,
      ),
      body: Stack(
        children: [
          cartItems.isEmpty
              ? Center(
                  child: Text(
                    'Keranjang Anda kosong.',
                    style: TextStyle(fontSize: 18, color: Colors.grey),
                  ),
                )
              : ListView.builder(
                  itemCount: cartItems.length,
                  itemBuilder: (context, index) {
                    final product = cartItems[index];
                    return ListTile(
                      leading: Image.asset(
                        product['image'] ??
                            '', // Menangani kasus jika image null
                        width: 50,
                        fit: BoxFit.cover,
                      ),
                      title: Text(product['name']),
                      subtitle: Text('Rp${product['price']}'),
                      trailing: Row(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          Checkbox(
                            value: selectedItems[index],
                            onChanged: (value) {
                              setState(() {
                                selectedItems[index] = value!;
                              });
                            },
                          ),
                          IconButton(
                            icon: Icon(Icons.delete, color: Colors.red),
                            onPressed: () => _removeFromCart(index),
                          ),
                        ],
                      ),
                    );
                  },
                ),
          if (isLoading)
            Center(
              child: CircularProgressIndicator(),
            ),
        ],
      ),
      bottomNavigationBar: BottomNavigationBar(
        backgroundColor: Colors.green,
        selectedItemColor: Colors.white,
        unselectedItemColor: const Color.fromARGB(255, 255, 254, 254),
        items: [
          BottomNavigationBarItem(
            icon: Icon(Icons.home),
            label: 'Beranda',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.notifications),
            label: 'Notifikasi',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.person),
            label: 'Saya',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.history),
            label: 'Riwayat',
          ),
        ],
        onTap: (index) {
          switch (index) {
            case 0:
              Navigator.pushReplacementNamed(context, '/home');
              break;
            case 1:
              Navigator.pushNamed(context, '/notifications');
              break;
            case 2:
              Navigator.pushNamed(context, '/profile');
              break;
            case 3:
              Navigator.pushNamed(context, '/order-history');
              break;
          }
        },
      ),
      floatingActionButton: cartItems.isEmpty
          ? null
          : Align(
              alignment: Alignment.bottomCenter,
              child: ElevatedButton(
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => PaymentScreen(products: cartItems),
                    ),
                  );
                },
                style: ElevatedButton.styleFrom(
                  padding: EdgeInsets.symmetric(horizontal: 16, vertical: 12),
                  backgroundColor: Colors.green,
                ),
                child: Text('Lakukan Pembayaran'),
              ),
            ),
    );
  }
}
