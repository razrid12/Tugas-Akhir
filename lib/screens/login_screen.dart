import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class LoginScreen extends StatefulWidget {
  @override
  _LoginScreenState createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();
  bool isLoading = false;
  bool _isPasswordVisible = false; // Variabel untuk kontrol lihat password

  Future<void> handleLogin() async {
    setState(() {
      isLoading = true;
    });

    try {
      await Future.delayed(Duration(seconds: 2));

      SharedPreferences prefs = await SharedPreferences.getInstance();
      String? registeredEmail = prefs.getString('email');
      String? registeredPassword = prefs.getString('password');

      if (emailController.text.isEmpty || passwordController.text.isEmpty) {
        _showErrorDialog('Email dan password harus diisi!');
        return;
      }

      if (emailController.text != registeredEmail) {
        // Tampilkan dialog error dan arahkan ke halaman registrasi setelah klik OK
        _showErrorDialog(
            'Email belum terdaftar! Anda akan diarahkan ke halaman registrasi.');
        return;
      }

      if (passwordController.text != registeredPassword) {
        _showErrorDialog('Password salah!');
        return;
      }

      // Jika login berhasil, simpan status login dan arahkan ke Home
      await prefs.setBool('isLoggedIn', true);
      Navigator.pushReplacementNamed(context, '/home');
    } catch (e) {
      _showErrorDialog('Terjadi kesalahan: $e');
    } finally {
      setState(() {
        isLoading = false;
      });
    }
  }

  void _showErrorDialog(String message) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: Text('Error'),
        content: Text(message),
        actions: [
          TextButton(
            onPressed: () {
              Navigator.pop(context); // Tutup dialog
              if (message.contains('Email belum terdaftar')) {
                // Jika pesan mengandung kata-kata tentang email yang tidak terdaftar, arahkan ke halaman registrasi
                Navigator.pushReplacementNamed(context, '/registration');
              }
            },
            child: Text('OK'),
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Login'),
      ),
      body: Stack(
        children: [
          Center(
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Text(
                  'LOGIN',
                  style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
                ),
                SizedBox(height: 10),
                Image.asset('assets/images/logo_keranjang.jpeg',
                    height: 250), // Sesuaikan logo
                Card(
                  margin: EdgeInsets.all(16),
                  child: Padding(
                    padding: const EdgeInsets.all(16.0),
                    child: Column(
                      children: [
                        _buildTextField(
                          controller: emailController,
                          label: 'Email',
                          icon: Icons.email,
                        ),
                        _buildTextField(
                          controller: passwordController,
                          label: 'Password',
                          icon: Icons.lock,
                          isPassword: true,
                        ),
                      ],
                    ),
                  ),
                ),
                ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.green,
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(12)),
                  ),
                  onPressed: isLoading ? null : handleLogin,
                  child: Padding(
                    padding: const EdgeInsets.all(12.0),
                    child: Text(
                      'LOGIN',
                      style: TextStyle(color: Colors.white, fontSize: 18),
                    ),
                  ),
                ),
                TextButton(
                  onPressed: isLoading
                      ? null
                      : () => Navigator.pushNamed(context, '/registration'),
                  child: Text('Belum punya akun? Daftar di sini.'),
                ),
              ],
            ),
          ),
          if (isLoading)
            Center(
              child: CircularProgressIndicator(),
            ),
        ],
      ),
    );
  }

  Widget _buildTextField({
    required TextEditingController controller,
    required String label,
    required IconData icon,
    bool isPassword = false,
  }) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8.0),
      child: TextField(
        controller: controller,
        obscureText:
            isPassword && !_isPasswordVisible, // Atur status lihat password
        decoration: InputDecoration(
          labelText: label,
          prefixIcon: Icon(icon),
          suffixIcon: isPassword
              ? IconButton(
                  icon: Icon(
                    _isPasswordVisible
                        ? Icons.visibility
                        : Icons.visibility_off,
                  ),
                  onPressed: () {
                    setState(() {
                      _isPasswordVisible =
                          !_isPasswordVisible; // Toggle password visibility
                    });
                  },
                )
              : null,
          border: OutlineInputBorder(),
        ),
      ),
    );
  }
}
