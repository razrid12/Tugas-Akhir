import 'package:e_commerce/screens/cart_screen.dart';
import 'package:e_commerce/screens/home_screen.dart';
import 'package:e_commerce/screens/notification_screen.dart';
import 'package:e_commerce/screens/order_history_screen.dart';
import 'package:e_commerce/screens/payment_screen.dart';
import 'package:e_commerce/screens/product_detail_screen.dart';
import 'package:e_commerce/screens/profile_screen.dart';
import 'package:e_commerce/screens/succes_screen.dart';
import 'package:e_commerce/screens/login_screen.dart';
import 'package:e_commerce/screens/registration_screen.dart';
import 'package:flutter/material.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Aplikasi E-Commerce',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      initialRoute: '/login', // Arahkan ke halaman pertama (LoginScreen)
      routes: {
        '/login': (context) => LoginScreen(),
        '/registration': (context) => RegistrationScreen(),
        '/home': (context) => HomeScreen(),
        '/profile': (context) => ProfileScreen(),
        '/product-detail': (context) => ProductDetailScreen(
              productId: 'id_1',
              product: {}, // Berikan data default jika diperlukan
            ),
        '/cart': (context) => CartScreen(),
        '/payment': (context) => PaymentScreen(
              products: [], // Berikan data default jika rute ini dipanggil secara langsung
            ),
        '/order-history': (context) => OrderHistoryScreen(),
        '/notifications': (context) => NotificationScreen(),
        '/success': (context) => SuccessScreen(isSuccess: true),
      },
    );
  }
}
