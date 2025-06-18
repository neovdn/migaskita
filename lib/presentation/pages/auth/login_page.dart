import 'package:flutter/material.dart';
import 'package:flutter_migaskita/presentation/providers/user_provider.dart';
import 'package:provider/provider.dart';
import '../../providers/auth_provider.dart';
import '../../widgets/custom_text_field.dart';
import '../../widgets/custom_button.dart';

class LoginPage extends StatefulWidget {
  @override
  _LoginPageState createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();
  bool _obscurePassword = true;

  void _showSnackBar(String message) {
    ScaffoldMessenger.of(
      context,
    ).showSnackBar(SnackBar(content: Text(message)));
  }

  bool _isValidEmail(String email) {
    return RegExp(r'^[\w-\.]+@([\w-]+\.)+[\w-]{2,4}$').hasMatch(email);
  }

  Future<void> _handleLogin() async {
    final email = _emailController.text.trim();
    final password = _passwordController.text.trim();

    // Validasi
    if (email.isEmpty || password.isEmpty) {
      _showSnackBar('Email dan password harus diisi');
      return;
    }

    if (!_isValidEmail(email)) {
      _showSnackBar('Email tidak valid');
      return;
    }

    final authProvider = Provider.of<AuthProvider>(context, listen: false);
    final success = await authProvider.signInUser(
      email: _emailController.text.trim(),
      password: _passwordController.text.trim(),
      context: context,
    );

    if (success) {
      final userRole =
          Provider.of<UserProvider>(context, listen: false).user?.role;
      if (userRole == 'admin') {
        Navigator.pushReplacementNamed(context, '/admin-home');
      } else {
        Navigator.pushReplacementNamed(context, '/employee-home');
      }
    } else {
      _showSnackBar('Email atau password salah');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: SingleChildScrollView(
            // agar tidak ketutupan keyboard
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Image.asset('assets/images/logo.png', height: 150),
                SizedBox(height: 20),
                CustomTextField(
                  label: 'Email',
                  controller: _emailController,
                  keyboardType: TextInputType.emailAddress,
                ),
                CustomTextField(
                  label: 'Password',
                  controller: _passwordController,
                  obscureText: _obscurePassword,
                  suffixIcon: IconButton(
                    icon: Icon(
                      _obscurePassword
                          ? Icons.visibility_off
                          : Icons.visibility,
                    ),
                    onPressed: () {
                      setState(() {
                        _obscurePassword = !_obscurePassword;
                      });
                    },
                  ),
                ),
                Align(
                  alignment: Alignment.centerRight,
                  child: GestureDetector(
                    onTap: () {
                      // Arahkan ke halaman lupa password kalau ada
                    },
                    child: Text(
                      'Lupa Password?',
                      style: TextStyle(color: Color(0xFF324F5E)),
                    ),
                  ),
                ),
                SizedBox(height: 20),
                CustomButton(text: 'Masuk', onPressed: _handleLogin),
                SizedBox(height: 20),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      'Belum punya akun? ',
                      style: TextStyle(color: Color(0xFF324F5E)),
                    ),
                    GestureDetector(
                      onTap: () => Navigator.pushNamed(context, '/sign_up'),
                      child: Text(
                        'Daftar',
                        style: TextStyle(
                          color: Color(0xFF324F5E),
                          decoration: TextDecoration.underline,
                        ),
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
