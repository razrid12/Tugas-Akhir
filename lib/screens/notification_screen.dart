import 'package:flutter/material.dart';

class NotificationScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Notifikasi'),
      ),
      body: ListView.builder(
        itemCount: 10, // Dummy data jumlah notifikasi
        itemBuilder: (context, index) {
          return ListTile(
            title: Text('Notifikasi ${index + 1}'),
            subtitle: Text('Pesan notifikasi ${index + 1}'),
            trailing: Icon(Icons.notifications),
            onTap: () {
              // Navigasi atau aksi saat notifikasi diklik
            },
          );
        },
      ),
      bottomNavigationBar: BottomNavigationBar(
        backgroundColor: Colors.green,
        selectedItemColor: Colors.white, // Warna teks dan ikon yang dipilih
        unselectedItemColor: const Color.fromARGB(
            246, 255, 255, 255), // Warna ikon tidak dipilih
        type: BottomNavigationBarType.fixed,
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
