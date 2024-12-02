import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class RegistrationScreen extends StatefulWidget {
  @override
  _RegistrationScreenState createState() => _RegistrationScreenState();
}

class _RegistrationScreenState extends State<RegistrationScreen> {
  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();
  final TextEditingController confirmPasswordController =
      TextEditingController();
  final TextEditingController nameController = TextEditingController();
  final TextEditingController phoneController = TextEditingController();
  final TextEditingController addressController = TextEditingController();

  bool isLoading = false;
  bool _isPasswordVisible = false;
  bool _isConfirmPasswordVisible = false;

  Future<void> handleRegistration() async {
    setState(() {
      isLoading = true;
    });

    try {
      await Future.delayed(Duration(seconds: 2));

      if (nameController.text.isEmpty ||
          emailController.text.isEmpty ||
          passwordController.text.isEmpty ||
          confirmPasswordController.text.isEmpty ||
          phoneController.text.isEmpty ||
          addressController.text.isEmpty) {
        _showErrorDialog('Semua kolom harus diisi!');
        return;
      }

      if (!emailController.text.contains('@gmail.com')) {
        _showErrorDialog('Email harus menggunakan domain @gmail.com');
        return;
      }

      if (!RegExp(r'^\+62[1-9][0-9]{7,9}$').hasMatch(phoneController.text)) {
        _showErrorDialog(
            'Nomor HP harus dimulai dengan +62 dan diikuti nomor tanpa 0 di depan!');
        return;
      }

      if (passwordController.text != confirmPasswordController.text) {
        _showErrorDialog('Password dan Konfirmasi password tidak cocok!');
        return;
      }

      if (!RegExp(
              r'^(?=.*[a-z])(?=.*[A-Z])(?=.*\d)(?=.*[@$!%*?&])[A-Za-z\d@$!%*?&]{8,}$')
          .hasMatch(passwordController.text)) {
        _showErrorDialog(
            'Password harus minimal 8 karakter, mengandung huruf besar, huruf kecil, angka, dan simbol!');
        return;
      }

      SharedPreferences prefs = await SharedPreferences.getInstance();
      await prefs.setString('email', emailController.text);
      await prefs.setString('password', passwordController.text);

      _showSuccessDialog();
    } catch (e) {
      _showErrorDialog('Terjadi kesalahan: $e');
    } finally {
      setState(() {
        isLoading = false;
      });
    }
  }

  void _showSuccessDialog() {
    showDialog(
      context: context,
      barrierDismissible: false,
      builder: (context) => AlertDialog(
        title: Text('Registrasi Berhasil'),
        content: Text('Silakan login menggunakan email Anda.'),
        actions: [
          TextButton(
            onPressed: () {
              Navigator.pop(context);
              Navigator.pushReplacementNamed(context, '/login');
            },
            child: Text('OK'),
          ),
        ],
      ),
    );
  }

  void _showErrorDialog(String message) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: Text('Error'),
        content: Text(message),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
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
        title: Text('Registrasi'),
      ),
      body: Stack(
        children: [
          SingleChildScrollView(
            child: Center(
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Text(
                    'DAFTAR',
                    style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
                  ),
                  SizedBox(height: 10),
                  Image.asset('assets/images/logo_keranjang.jpeg', height: 250),
                  Card(
                    margin: EdgeInsets.all(16),
                    child: Padding(
                      padding: const EdgeInsets.all(16.0),
                      child: Column(
                        children: [
                          _buildTextField(
                              controller: nameController,
                              label: 'Nama Lengkap',
                              icon: Icons.person),
                          _buildTextField(
                              controller: emailController,
                              label: 'Email',
                              icon: Icons.email),
                          _buildTextField(
                              controller: passwordController,
                              label: 'Password',
                              icon: Icons.lock,
                              isPassword: true),
                          _buildTextField(
                              controller: confirmPasswordController,
                              label: 'Konfirmasi Password',
                              icon: Icons.lock,
                              isPassword: true),
                          _buildTextField(
                              controller: phoneController,
                              label: 'Nomor HP',
                              icon: Icons.phone),
                          _buildTextField(
                              controller: addressController,
                              label: 'Alamat',
                              icon: Icons.location_on),
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
                    onPressed: isLoading ? null : handleRegistration,
                    child: Padding(
                      padding: const EdgeInsets.all(12.0),
                      child: Text(
                        'DAFTAR',
                        style: TextStyle(color: Colors.white, fontSize: 18),
                      ),
                    ),
                  ),
                  TextButton(
                    onPressed: isLoading
                        ? null
                        : () {
                            Navigator.pushReplacementNamed(context, '/login');
                          },
                    child: Text('Sudah punya akun? Login di sini.'),
                  ),
                ],
              ),
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
        obscureText: isPassword
            ? (isPassword ? (_isPasswordVisible ? false : true) : false)
            : false,
        decoration: InputDecoration(
          labelText: label,
          prefixIcon: Icon(icon),
          suffixIcon: isPassword
              ? IconButton(
                  icon: Icon(
                    isPassword
                        ? (_isPasswordVisible
                            ? Icons.visibility
                            : Icons.visibility_off)
                        : null,
                  ),
                  onPressed: () {
                    setState(() {
                      if (isPassword) {
                        if (label == "Password") {
                          _isPasswordVisible = !_isPasswordVisible;
                        } else if (label == "Konfirmasi Password") {
                          _isConfirmPasswordVisible =
                              !_isConfirmPasswordVisible;
                        }
                      }
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
