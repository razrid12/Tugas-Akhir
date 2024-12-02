import 'package:flutter/material.dart';

class OrderHistoryScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    // Daftar riwayat pesanan dummy
    List<Map<String, dynamic>> orders = [
      {
        'name': 'Produk A',
        'price': 100.00,
        'status': 'Sukses',
        'date': '2024-11-01'
      },
      {
        'name': 'Produk B',
        'price': 200.00,
        'status': 'Gagal',
        'date': '2024-11-05'
      },
    ];

    return Scaffold(
      appBar: AppBar(
        title: Text('Riwayat Pemesanan'),
      ),
      body: ListView.builder(
        itemCount: orders.length,
        itemBuilder: (context, index) {
          var order = orders[index];
          return ListTile(
            title: Text(order['name']),
            subtitle: Text('Harga: \$${order['price']}'),
            trailing: Text(order['status'],
                style: TextStyle(
                    color: order['status'] == 'Sukses'
                        ? Colors.green
                        : Colors.red)),
            onTap: () {
              // Navigasi ke detail pesanan
            },
          );
        },
      ),
      bottomNavigationBar: BottomNavigationBar(
        backgroundColor: Colors.green,
        selectedItemColor: Colors.white, // Warna teks dan ikon yang dipilih
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
              // Navigasi ke halaman Beranda
              Navigator.pushReplacementNamed(context, '/home');
              break;
            case 1:
              // Navigasi ke halaman Notifikasi
              Navigator.pushNamed(context, '/notifications');
              break;
            case 2:
              // Navigasi ke halaman Profil Saya
              Navigator.pushNamed(context, '/profile');
              break;
            case 3:
              // Navigasi ke halaman Riwayat Pemesanan
              Navigator.pushNamed(context, '/order-history');
              break;
          }
        },
      ),
    );
  }
}
